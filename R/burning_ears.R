#' Why are my ears burning?
#' 
#' This function searches for company mentions that are not tagged to a docket. 
#'
#' @param company chr: Name of the company in nrcadams::docket_codex to be searched for. 
#' @param days_back dbl: Length of time the search extends in days since the document was published on ADAMS? Default is all time (i.e, NA). Cannot be used with start_date or end_date.
#'
#' @source \url{https://www.nrc.gov/site-help/developers/wba-api-developer-guide.pdf}
#' @return tibble of search results
#' @export
#'
search_undocketed <- function(
  company = "Kairos Power",
  days_back = 30
) {
  start_date = Sys.Date() |> lubridate::ymd() - days_back

  if(length(company) != 1) stop("Only Supply One Company")

  dockets <- nrcadams::docket_codex |>
    dplyr::filter(Company == company) |>
    dplyr::pull(DocketNumber)

  if(length(dockets) == 0) stop("Unrecognized Company")

  

  url = paste0(
    nrcadams:::adams_search_head,
    nrcadams:::adams_docket_numbers(dockets, exclude = TRUE, closing_bracket = FALSE),
    ",",
    nrcadams:::adams_start_or_end(start_date, FALSE), ")",
    nrcadams:::adams_search_term(company),
    nrcadams:::adams_search_tail(!is.na(company))
  )
  paste("Searching with the following URL:\n", url,"\n") |>
    tictoc::tic()
  
  results = xml2::read_xml(url)
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
      `Publish Date` = `Publish Date` - 4*3600,
      Company = company
    ) |>
    dplyr::arrange(dplyr::desc(`Publish Date`)) |>
    suppressWarnings()


  tictoc::toc()

  message(
    paste(
      "\n This search returned:", adams_tbl |> nrow(), "files."
      )
    )

    if(adams_tbl |> nrow() == 0) {
      warning("\nThe search return no results.\n")
    }
    if(adams_tbl |> nrow() >= 1000) {
      warning("\nThis search returned more than 1000 results and thus may be incomplete. As a result, the search should be refined.\n")
    }
    return(adams_tbl)
}
