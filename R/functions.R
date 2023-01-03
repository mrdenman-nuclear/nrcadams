#' Conduct ADAMS Search on Docket Numbers
#'
#' @param DocketNumber dbl/vector: Docket number (or numbers) to be searched on ADAMS
#' @param days_back dbl: Length of time the search extends in days since the document was published on ADAMS? Default is all time (i.e, NULL)
#' @param search_term chr: Any search term desired. Default is nothing (i.e., NULL)
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
  days_back = NULL
) {
  if(all(DocketNumber |> is.double() ||  DocketNumber |> is.character())) {

    adams_docket = paste0(
      "properties_search_any:!(",
      paste0(
        "!(DocketNumber,eq,'", DocketNumber |> stringr::str_pad(8, pad = "0"), "','')"
        ) |> stringr::str_c(collapse = ","),
      ")"
    )
    if (is.null(days_back)) {
      adams_publish_date = ""
    } else {
      end_date = Sys.Date() |> lubridate::ymd()
      start_date = end_date - days_back

      # Advanced search and content search format the ADAMs publication date query differently.
      # days_back is only supported for content searches.
      mdy_fmt = paste0(
        paste(
          start_date |> lubridate::month(),
          start_date |> lubridate::day(),
          start_date |> lubridate::year(),
          sep = '/'
        ),
        '+12:00+AM'
      )

      adams_publish_date = paste0(
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

    url = paste0(
      nrcadams:::adams_search_head,
      adams_docket,
      adams_publish_date,
      adams_search_term,
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

  if(all(adams_tbl$DocketNumber |> is.na()) == FALSE) {
    return(adams_tbl)
  } else {
    message("Some docket numbers were returned as hybrid character and numeric strings (e.g., PROJ0792). These docket numbers were converted to NA's.")
    return(adams_tbl)
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

#' Tests for null returns
#'
#' @param adams_tbl
#'
#' @source \url{https://www.nrc.gov/site-help/developers/wba-api-developer-guide.pdf}
#' @return Logical. TRUE if rows exist, FALSE if rows dont.
#' @keywords Internal
test_for_results = function(adams_tbl) {


}
