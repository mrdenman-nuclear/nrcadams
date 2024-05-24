#' Conduct ADAMS Search on ACRS Documents
#'
#' @param days_back dbl: Length of time the search extends in days since the document was published on ADAMS? Default is all time (i.e, NA). Cannot be used with start_date or end_date.
#'
#' @source \url{https://www.nrc.gov/site-help/developers/wba-api-developer-guide.pdf}
#' @return tibble of search results
#' @export
#'
search_ACRS <- function(
  days_back = 7
  ) {
    start_date = Sys.Date() |> lubridate::ymd() - days_back

    url = paste0(
      nrcadams:::adams_search_head,
      "properties_search_all:!(!(AuthorAffiliation,starts,NRC/ACRS,''),",
      nrcadams:::adams_start_or_end(start_date, FALSE),
      ")",
      nrcadams:::adams_search_tail(FALSE)
    )

    paste("Searching with the following URL:\n", url,"\n") |>
      tictoc::tic()
    results = nrcadams:::make_results_tibble_no_docket(url, "ACRS")
    tictoc::toc()

    message(
      paste(
        "\n This search returned:", results |> dplyr::distinct()|> nrow(), "files."
        )
      )

    if(results |> nrow() == 0) {
      warning("\nThe search return no results.\n")
    }
    if(results |> nrow() >= 1000) {
      warning("\nThis search returned more than 1000 results and thus may be incomplete. As a result, the search should be refined.\n")
    }
    return(results)
}




#' Makes a Formatted Tibble from ADAMS URL Search Results
#'
#' @param adams_url ADAMS search URL
#' @param download Logical, if set to true, the file is downloaded before it is processed
#' @param tag_chr tag associted with the search result 
#'
#' @source \url{https://www.nrc.gov/site-help/developers/wba-api-developer-guide.pdf}
#' @return vector of search term results
#' @keywords Internal
#' @examples
#' "https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search_any:!(!(DocketNumber,eq,'99902088','')),properties_search_all:!(!(PublishDatePARS,gt,'01/05/2023',''))))&qn=New&tab=advanced-search-pars&z=0" |>
#' nrcadams:::make_results_tibble()
make_results_tibble_no_docket = function(adams_url, tag_chr = NULL, download = FALSE) {
  if(download) {
    temp = tempfile()
    download.file(adams_url, temp, method = "curl")
    results = xml2::read_xml(temp)
  } else {
    results = xml2::read_xml(adams_url)
  }

  if(results |> nrcadams:::extract_from_xml("count") |> as.integer() == 0) return(tibble::tibble())
 
  adams_tbl = tibble::tibble(
    Title = results |>
      nrcadams:::extract_from_xml("DocumentTitle"),
    `Document Date` = results |>
      nrcadams:::extract_from_xml("DocumentDate") |>
      lubridate::mdy(),
    `Publish Date` = results |>
      nrcadams:::extract_from_xml("PublishDatePARS") |>
      lubridate::mdy_hm(tz = "EDT"),
    Type = results|>
      nrcadams:::extract_from_xml("DocumentType"),
    Affiliation = results|>
      nrcadams:::extract_from_xml("AuthorAffiliation"),
    URL = results |>
      nrcadams:::extract_from_xml("URI"),
    `ML Number` = results |>
      nrcadams:::extract_from_xml("AccessionNumber")
  ) |>
    dplyr::mutate(
      `Publish Date` = `Publish Date` - 4 * 3600,
      Tag = tag_chr
    ) |>
    dplyr::arrange(dplyr::desc(`Publish Date`)) |>
    suppressWarnings()
}