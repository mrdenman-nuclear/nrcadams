#' Conduct ADAMS Search on Docket Numbers
#'
#' @param DocketNumber dbl/vector: Docket number (or numbers) to be searched on ADAMS
#' @param search_term chr: Any search term desired. Default is nothing (i.e., NA)
#' @param days_back dbl: Length of time the search extends in days since the document was published on ADAMS? Default is all time (i.e, NA). Cannot be used with start_date or end_date.
#' @param start_date chr: The earliest date (ymd) search results should be returned. Cannot be used with days_back.
#' @param end_date chr: The latest date (ymd) search results should be returned. Cannot be used with days_back.
#' @param document_type chr: Type of ADAMS document
#'
#' @source \url{https://www.nrc.gov/site-help/developers/wba-api-developer-guide.pdf}
#' @return tibble of search results
#' @export
#'
#' @examples
#'   nrcadams::docket_codex |>
#'     dplyr::filter(Company == "ACU") |>
#'     dplyr::pull(DocketNumber) |>
#'     nrcadams::search_docket()
search_docket <- function(
  DocketNumber,
  search_term = NA,
  days_back = NA,
  start_date = NA,
  end_date = NA,
  document_type = NA
  ) {
  if(all(DocketNumber |> is.double() ||  DocketNumber |> is.character())) {

    if(!is.na(days_back)) {
      if(!is.na(start_date)) warning("days_back and start_date are both defined. days_back is used.")
      if(!is.na(end_date)) warning("days_back and end_date are both defined. days_back is used.")
      start_date = Sys.Date() |> lubridate::ymd() - days_back
      end_date = NA
    }

    url = paste0(
      nrcadams:::adams_search_head,
      nrcadams:::adams_docket_numbers(DocketNumber),
      nrcadams:::adams_all(document_type, start_date, end_date),
      nrcadams:::adams_search_term(search_term),
      nrcadams:::adams_search_tail(!is.na(search_term))
    )

    paste("Searching with the following URL:\n", url,"\n") |>
      tictoc::tic()
    results = nrcadams:::make_results_tibble(url)
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
  } else {
    stop(
      "Either no docket number was entered or the docket number was not formatted as either a double or character string."
      )
  }
}

#' Conduct ADAMS Search on ML numbers
#'
#' @param ML_number chr/vector: ML number (or numbers) to be searched on ADAMS.
#' All searches must start with ML but partial ML numbers can be searched for
#' in addition to full ML numbers.
#'
#' @source \url{https://www.nrc.gov/site-help/developers/wba-api-developer-guide.pdf}
#' @return tibble of search results
#' @export
#'
#' @examples
#' c("ML22179A346", "ML19211C119") |> nrcadams::search_ml()
search_ml <- function(ML_number) {
  if(all(ML_number |> stringr::str_starts("ML"))) {
    adams_ML = paste0(
      "properties_search_any:!(",
      paste0(
        "!(AccessionNumber,starts,", ML_number , ",'')"
      ) |> stringr::str_c(collapse = ","),
      ")"
    )

    url = paste0(
      nrcadams:::adams_search_head,
      adams_ML,
      nrcadams:::adams_search_tail()
    )

    paste("Searching with the following URL:\n", url) |>
      message()

    results = nrcadams:::make_results_tibble(url)
    if(results |> nrow() == 0) {
      warning("The search return no results.\n")
    }
    return(results)

  } else {
    stop("No ML number was entered.")
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
#' @param download Logical, if set to true, the file is downloaded before it is processed
#'
#' @source \url{https://www.nrc.gov/site-help/developers/wba-api-developer-guide.pdf}
#' @return vector of search term results
#' @keywords Internal
#' @examples
#' "https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search_any:!(!(DocketNumber,eq,'99902088','')),properties_search_all:!(!(PublishDatePARS,gt,'01/05/2023',''))))&qn=New&tab=advanced-search-pars&z=0" |>
#' nrcadams:::make_results_tibble()
make_results_tibble = function(adams_url, download = FALSE) {
  if(download) {
    temp = tempfile()
    download.file(adams_url, temp, method = "curl")
    results = xml2::read_xml(temp)
  } else {
    results = xml2::read_xml(adams_url)
  }


  if(results |> nrcadams:::extract_from_xml("count") |> as.integer() == 0) return(tibble::tibble())
 
  docket_number <- results |>
      nrcadams:::extract_from_xml("DocketNumber")

  if(is.null(docket_number)) docket_number = 1

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
    DocketNumber = docket_number,
    `ML Number` = results |>
      nrcadams:::extract_from_xml("AccessionNumber")
  ) |>
    tidyr::separate_rows(DocketNumber) |>
    dplyr::mutate(
      `Publish Date` = `Publish Date` - 4 * 3600,
      DocketNumber = DocketNumber |> as.double()
    ) |>
    dplyr::arrange(dplyr::desc(`Publish Date`)) |>
    suppressWarnings()

  if(adams_tbl |> dplyr::filter(is.na(DocketNumber)) |> nrow() == 0) {
    return(adams_tbl)
  } else {
    message("Some docket numbers were returned as hybrid character and numeric strings (e.g., PROJ0792). These docket numbers were filtered out.")
    return(adams_tbl |> dplyr::filter(!is.na(DocketNumber)))
  }
}






#' Conduct a lengthy search on Docket Numbers
#'
#' Individual ADAMS searches are limited to 1000 results, which can make
#' searches that are lengthy difficult. Additionally, long ADAMS searches can
#' take over 10 seconds to complete which may trigger a connection timeout
#' on some systems.
#'
#' To avoid these problems, this wrapper script conducts multiple searches from
#' today back to a starting point in time. The number of searches is set by the
#' num_interval. For example, if today is 2020/1/1 and the starting date is
#' 2010/1/1 and number_of_intervals is set to 2, this script will conduct two
#' searches, one from 2010 to 2015 and the other from 2015 to 2020. These
#' search results are then combined and output to the user.
#'
#' @param DocketNumber dbl/vector: Docket number (or numbers) to be searched on ADAMS
#' @param search_term chr: Any search term desired. Default is nothing (i.e., NA)
#' @param number_of_intervals dbl: The maximum number of searches to be conducted
#' @param start_date chr: The earliest date (ymd) search results should be returned.
#' @param document_type chr: Type of ADAMS document
#'
#' @source \url{https://www.nrc.gov/site-help/developers/wba-api-developer-guide.pdf}
#' @return tibble of search results
#' @export
#'
search_long_docket = function(
  DocketNumber,
  search_term = NA,
  number_of_intervals = 5,
  start_date = "2017-1-1",
  document_type = NA
  ) {

  search_duration = lubridate::interval(start_date |> lubridate::ymd(), Sys.Date() |> lubridate::ymd()) |>
    lubridate::as.duration() / number_of_intervals
  message(
    paste(
      "With", number_of_intervals,
      "starting on", start_date,
      "the duration of each search will be", search_duration
      )
    )
  start_date = start_date |> lubridate::ymd() + rep(0:(number_of_intervals-1)) * search_duration
  end_date = dplyr::lead(start_date)

  purrr::map2(start_date, end_date, ~nrcadams::search_docket(
      DocketNumber = DocketNumber,
      search_term = NA,
      start_date = .x,
      end_date = .y,
      document_type = document_type
    )) |>
    # Need to remove empty search results
    purrr::discard(\(z) nrow(z) == 0) |>
    purrr::reduce(dplyr::full_join) |>
    dplyr::distinct()
}



