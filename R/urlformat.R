

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
#' @return url segment for docket searches
#' @keywords Internal
adams_docket_numbers = function(docket_numbers = NA) {
  if(!all(is.na(docket_numbers))) {
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
#' @param search_term chr: Any search term desired. Default is nothing (i.e., NA)
#'
#' @source \url{https://www.nrc.gov/site-help/developers/wba-api-developer-guide.pdf}
#' @return url segment for content searches
#' @keywords Internal
adams_search_term = function(search_term) {
  if (is.na(search_term)) {
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
#' @param start_date chr: The earliest date (ymd) search results should be returned
#' @param end_date chr: The latest date (ymd) search results should be returned
#'
#' @source \url{https://www.nrc.gov/site-help/developers/wba-api-developer-guide.pdf}
#' @return script for a ADAMS search URL
#' @keywords Internal
adams_interval = function(start_date = NA, end_date = NA) {
  if (is.na(start_date) && is.na(end_date)) {
    interval = ''
  } else {
    paste0(
      nrcadams:::adams_start_or_end(start_date, FALSE),
      if(is.na(end_date)) {
        ""
      } else {
        paste0(
          ",", nrcadams:::adams_start_or_end(end_date)
        )
      }
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
#' @return url segment for publish date searches
#' @keywords Internal
adams_start_or_end = function(date = Sys.Date(), end_lgl = TRUE) {
  # If date is NA, return nothing
  # print(date)

  if(end_lgl){term = 'lt'} else {term = 'gt'}
  paste0(
    "!(PublishDatePARS,",
    term,
    ",'",
    date |> nrcadams:::lubridate_date(),
    "','')"
  )
}



#' Formats YMD date string into ADAMS search date using lubridate
#'
#' @param date chr: The date (ymd)
#'
#' @source \url{https://www.nrc.gov/site-help/developers/wba-api-developer-guide.pdf}
#' @return date for ADAMS search
#' @keywords Internal
lubridate_date = function(date = Sys.Date()) {
  paste0(
    paste(
      date |> lubridate::month() |> stringr::str_pad(2, pad = "0"),
      date |> lubridate::day() |> stringr::str_pad(2, pad = "0"),
      date |> lubridate::year(),
      sep = '/'
    )
  )
}

#' ADAMS search type URL section for any ADAMS search
#'
#' @param type_chr chr: Type of ADAMS document
#'
#' @source \url{https://www.nrc.gov/site-help/developers/wba-api-developer-guide.pdf}
#' @return url segment for type searches
#' @keywords Internal
adams_type = function(type_chr = NA) {
  if (is.na(type_chr)) {
    type = ''
  } else {
    paste0(
      "!(DocumentType,contains,'",
      type_chr |> stringr::str_replace(" " ,"+"),
      "','')"
    )
  }
}

#' ADAMS all criteria searches URL section for any ADAMS search
#'
#' @param type_chr chr: Type of ADAMS document
#' @param start_date chr: The earliest date (ymd) search results should be returned
#' @param end_date chr: The latest date (ymd) search results should be returned
#'
#' @source \url{https://www.nrc.gov/site-help/developers/wba-api-developer-guide.pdf}
#' @return url segment for all criteria searches
#' @keywords Internal
adams_all = function(
  type_chr = NA,
  start_date = NA,
  end_date = NA
  ) {
  if (is.na(start_date) && is.na(end_date) && is.na(type_chr)) {
    ''
  } else {
    paste0(
      ",properties_search_all:!(",
      nrcadams:::adams_type(type_chr),
      if(!is.na(type_chr) && (!is.na(start_date) || !is.na(end_date))) {
        paste0(",", nrcadams:::adams_interval(start_date, end_date), ")")
      } else {
        paste0(nrcadams:::adams_interval(start_date, end_date), ")")
      }
    )
  }
}

