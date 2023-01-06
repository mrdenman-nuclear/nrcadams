#' Conduct ADAMS Search on Docket Numbers
#'
#' @param DocketNumber dbl/vector: Docket number (or numbers) to be searched on ADAMS
#' @param search_term chr: Any search term desired. Default is nothing (i.e., NULL)
#' @param days_back dbl: Length of time the search extends in days since the document was published on ADAMS? Default is all time (i.e, NULL). Cannot be used with start_date or end_date.
#' @param start_date chr: The earliest date (ymd) search results should be returned. Cannot be used with days_back.
#' @param end_date chr: The latest date (ymd) search results should be returned. Cannot be used with days_back.
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
  search_term = NULL,
  days_back = NULL,
  start_date = NULL,
  end_date = NULL
) {
  if(all(DocketNumber |> is.double() ||  DocketNumber |> is.character())) {

    if(!is.null(days_back)) {
      if(!is.null(start_date)) warning("days_back and start_date are both defined. days_back is used.")
      if(!is.null(end_date)) warning("days_back and end_date are both defined. days_back is used.")
      start_date = Sys.Date() |> lubridate::ymd() - days_back
      end_date = NULL
    }

    url = paste0(
      nrcadams:::adams_search_head,
      nrcadams:::adams_docket_numbers(DocketNumber),
      nrcadams:::adams_interval(start_date, end_date),
      nrcadams:::adams_search_term(search_term),
      nrcadams:::adams_search_tail(!is.null(days_back))
    )

    paste("Searching with the following URL:\n", url) |>
      message()

    results = nrcadams:::make_results_tibble(url)

    if(results |> nrow() == 0) {
      stop("\nEither the search return no results or the search exceeded 1000 results, resulting in an ADAMS side error.\n")
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
      stop("\nEither the search return no results or the search exceeded 1000 results, resulting in an ADAMS side error.\n")
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
#'
#' @source \url{https://www.nrc.gov/site-help/developers/wba-api-developer-guide.pdf}
#' @return vector of search term results
#' @keywords Internal
make_results_tibble = function(adams_url) {
  results = xml2::read_xml(adams_url)

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
    DocketNumber = results |>
      nrcadams:::extract_from_xml("DocketNumber")
  ) |>
    tidyr::separate_rows(DocketNumber) |>
    dplyr::mutate(
      `Publish Date` = `Publish Date` - 4*3600,
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


#' First URL section for any ADAMS search
#'
#' @source \url{https://www.nrc.gov/site-help/developers/wba-api-developer-guide.pdf}
#' @return Starting script for a ADAMS search URL
#' @keywords Internal
adams_search_head =  "https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),"


#' Last URL section for any ADAMS search
#'
#' @param content_lgl Default TRUE.
#'  * TRUE: Content search supports search keywords.
#'  * FALSE: Advanced search returns results for greater than 1,000 entries.
#'
#' @source \url{https://www.nrc.gov/site-help/developers/wba-api-developer-guide.pdf}
#' @return Ending script for a ADAMS search URL
#' @keywords Internal
adams_search_tail = function(content_lgl = TRUE) {
  if(content_lgl) {
    "))&qn=New&tab=content-search-pars&z=0"
  } else {
    "))&qn=New&tab=advanced-search-pars&z=0"
  }
}


#' Adams Docket URL section for any ADAMS search
#'
#' @param docket_numbers dbl/vector: Docket number (or numbers) to be searched on ADAMS
#'
#' @source \url{https://www.nrc.gov/site-help/developers/wba-api-developer-guide.pdf}
#' @return script for a ADAMS search URL
#' @keywords Internal
adams_docket_numbers = function(docket_numbers = NULL) {
  if(!is.null(docket_numbers)) {
    paste0(
      "properties_search_any:!(",
      paste0(
        "!(DocketNumber,eq,'", docket_numbers |> stringr::str_pad(8, pad = "0"), "','')"
      ) |> stringr::str_c(collapse = ","),
      ")"
    )
  } else {
    ""
  }
}


#' ADAMS search term URL section for any ADAMS search
#'
#' @param search_term chr: Any search term desired. Default is nothing (i.e., NULL)
#'
#' @source \url{https://www.nrc.gov/site-help/developers/wba-api-developer-guide.pdf}
#' @return script for a ADAMS search URL
#' @keywords Internal
adams_search_term = function(search_term) {
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
}

#' ADAMS search posted date interval URL section for any ADAMS search
#'
#' @param start_date chr: The earliest date (ymd) search results should be returned.
#' @param end_date chr: The latest date (ymd) search results should be returned
#'
#' @source \url{https://www.nrc.gov/site-help/developers/wba-api-developer-guide.pdf}
#' @return script for a ADAMS search URL
#' @keywords Internal
adams_interval = function(start_date = NULL, end_date = NULL) {
  if (is.null(start_date) && is.null(end_date)) {
    interval = ''
  } else {
    # Advanced search and content search format the ADAMs publication date query differently.
    # days_back is only supported for content searches.

    paste0(
      ",properties_search:!(",
      nrcadams:::adams_start_or_end(start_date, FALSE),
      nrcadams:::adams_start_or_end(end_date),
      ")"
    )

  }
}

#' ADAMS search posted date interval URL section for any ADAMS search
#'
#' @param date_chr chr: The date (ymd)
#' @param end_lgl Logical: TRUE formats a search before this date.
#' FALSE formats a search after this date.
#'
#' @source \url{https://www.nrc.gov/site-help/developers/wba-api-developer-guide.pdf}
#' @return date for ADAMS search
#' @keywords Internal
#' @example nrcadams::adams_start_or_end()
adams_start_or_end = function(date = Sys.Date(), end_lgl = TRUE) {
  # If date is NULL, return nothing
  if(is.null(date)) {
    ""
  } else {
    if(end_lgl){term = 'lt'} else {term = 'gt'}
    paste0(
      "!(PublishDatePARS,",
      term,
      ",'",
      date |> nrcadams:::lubridate_date(),
      "','')"
    )
  }
}



#' Formats YMD date string into ADAMS search date using lubridate
#'
#' @param date chr: The date (ymd)
#'
#' @source \url{https://www.nrc.gov/site-help/developers/wba-api-developer-guide.pdf}
#' @return date for ADAMS search
#' @keywords Internal
#' @example nrcadams:::lubridate_date()
lubridate_date = function(date = Sys.Date()) {
  paste0(
    paste(
      date |> lubridate::month(),
      date |> lubridate::day(),
      date |> lubridate::year(),
      sep = '/'
    ),
    '+12:00+AM'
  )
}
