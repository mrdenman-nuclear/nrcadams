#' Conduct ADAMS Search
#'
#' @param DocketNumber dbl/vector Docket number (or numbers) to be searched on ADAMS
#' @param days_back dbl Length of time the search extends in days? Default is all time (i.e, NULL)
#' @param search_term chr Any search term desired. Default is nothing (i.e., NULL)
#'
#' @source \url{https://www.nrc.gov/site-help/developers/wba-api-developer-guide.pdf}
#' @return tibble of search results
#' @export
#'
#' @examples nrcadams::search_docket(c(99902088, 05000610))
search_docket <- function(
  DocketNumber,
  search_term = NULL,
  days_back = NULL
) {
  if(DocketNumber |> is.double() ||  DocketNumber |> is.character()) {

    adams_base = "https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:("
    adams_filters = "filters:(public-library:!t),"
    adams_docket = paste0(
      "properties_search_any:!(",
      paste0(
        "!(DocketNumber,eq,'", DocketNumber |> stringr::str_pad(8, pad = "0"), "','')"
        ) |> stringr::str_c(collapse = ","),
      ")"
    )
    if (is.null(days_back)) {
      adams_date = ""
    } else {
      end_date = Sys.Date() |> lubridate::ymd()
      start_date = end_date - days_back
      mdy_fmt = paste0(
        paste(
          start_date |> lubridate::month(),
          start_date |> lubridate::day(),
          start_date |> lubridate::year(),
          sep = '/'
        ),
        '+12:00+AM'
      )

      adams_date = paste0(
        ",properties_search:!(!(PublishDatePARS,gt,'",
        mdy_fmt,
        "',''))")
    }

    if (is.null(search_term)) {
      adams_search_term = ''
    } else {
      adams_search_term = paste0(
        ",single_content_search:'",
        search_term |>
          stringr::str_replace_all(" ", "+"),
        "'"
      )

    }

    adams_end = "))&qn=New&tab=content-search-pars&z=0"

    url = paste0(
      adams_base,
      adams_filters,
      adams_docket,
      adams_date,
      adams_search_term,
      adams_end
    )

    paste("Searching with the following URL:\n", url) |>
      message()

    nrcadams:::make_results_tibble(url)
  } else {
    stop("Either no docket number was entered or the docket number was not formatted as a double or character string.")
  }
}

#' Extract search term from XML results
#'
#' @param xml_results XML query results from ADAMS
#' @param search_term Search term
#'
#' @return vector of search term results
#' @keywords Internal
extract_from_xml = function(xml_results, search_term) {
  xml_results |>
    xml2::xml_find_all(paste0("//", search_term)) |>
    xml2::as_list() |>
    unlist()
}


#' Makes a Formatted Tibble from ADAMS URL Search Results
#'
#' @param adams_url ADAMS search URL
#'
#' @source \url{https://www.nrc.gov/site-help/developers/wba-api-developer-guide.pdf}
#' @return vector of search term results
#' @keywords Internal
make_results_tibble = function(adams_url) {
  results = xml2::read_xml(adams_url)

  tibble::tibble(
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
    ULR = results |>
      nrcadams:::extract_from_xml("URI"),
    DocketNumber = results |>
      nrcadams:::extract_from_xml("DocketNumber")
  ) |>
    dplyr::mutate(`Publish Date` = `Publish Date` - 4*3600) |>
    dplyr::arrange(dplyr::desc(`Publish Date`))
}
