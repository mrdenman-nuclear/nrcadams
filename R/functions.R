#' Conduct ADAMS Search on Docket Numbers
#'
#' @param DocketNumber dbl/vector: Docket number (or numbers)
#' to be searched on ADAMS
#' @param search_term chr: Any search term desired. Default is nothing
#' (i.e., NA)
#' @param days_back dbl: Length of time the search extends in days since
#' the document was published on ADAMS? Default is all time (i.e, NA).
#' Cannot be used with start_date or end_date.
#' @param start_date chr: The earliest date (ymd) search results should
#' be returned. Cannot be used with days_back.
#' @param end_date chr: The latest date (ymd) search results should be
#' returned. Cannot be used with days_back.
#' @param document_type chr: Type of ADAMS document, currently unsupported
#' @param skip_int: Number of records to skip in the search.
#' @param max_returns dbl: Maximum number of returns to pull when using REST
#' API.
#' @param verbosity dbl: Level of verbosity for REST API requests. Integer 0-3, 
#' with 0 being silent and 3 being most verbose.
#'
#' @source \url{https://www.nrc.gov/site-help/developers/wba-api-developer-guide.pdf}
#' @source \url{https://adams-search.nrc.gov/assets/APS-API-Guide.pdf}
#' @return tibble of search results
#' @export
search_docket <- function(
  DocketNumber,
  search_term = NA,
  days_back = NA,
  start_date = NA,
  end_date = NA,
  document_type = NA,
  skip_int = 0,
  max_returns = 1E6,
  verbosity = 0,
  adams_key = Sys.getenv("ADAMS")
) {
  # Error checking days_back input and adjustment of start_date and end_date
  date <- nrcadams:::process_dates(
    start_date = start_date,
    end_date = end_date,
    days_back = days_back
  )
  # Error Checking on docket number input
  if (!all(DocketNumber |> is.double() ||  DocketNumber |> is.character())) {
    stop(
      paste(
        "Either no docket number was entered or the docket number was",
        "not formatted as either a double or character string."
      )
    )
  }

  results <- tibble::tibble()
  more_searches <- TRUE
  count <- 0

  while (more_searches) {
    current_tbl <- nrcadams::search_public_ADAMS(
      DocketNumber = DocketNumber,
      search_term = search_term,
      start_date = date$start,
      end_date = date$end,
      skip_int = skip_int,
      verbosity = verbosity,
      adams_key = adams_key
    )
    records = list(
      max = current_tbl$count |> max(),
      current = count * 100 + length(unique(current_tbl$`ML Number`))
    )
    count = count + 1
    if (records$max <= records$current) {
      results <- dplyr::bind_rows(results, current_tbl)
      more_searches <- FALSE
    } else if (count == max_returns / 100) {
      results <- dplyr::bind_rows(results, current_tbl)
      more_searches <- FALSE
      warning(
        paste(
          "Results exceed the maximum number of returns:", max_returns,
          ". The search yeilded the following number of results:",
          records$max, ". Consider refining the search criteria."
        )
      )
    } else {
      skip_int <- skip_int + 100
      results <- dplyr::bind_rows(results, current_tbl)
    }
  }

  message(
    paste(
      "\n This search returned:",
      results |> dplyr::distinct() |> nrow(),
      "files."
    )
  )

  if(results |> nrow() == 0) {
    warning("\nThe search return no results.\n")
  }

  return(results)
}

#' Conduct ADAMS Search on ML numbers
#'
#' @param ML_number chr/vector: ML number (or numbers) to be searched on ADAMS.
#' All searches must start with ML but partial ML numbers can be searched for
#' in addition to full ML numbers. 
#'
#' @source \url{https://adams-search.nrc.gov/assets/APS-API-Guide.pdf}
#' @return tibble of search results
#' @export
#'
#' @examples
#' nrcadams::search_ml(ML_number = c("ML19211C119", "ML20014E642", "ML22179A346"))
search_ml <- function(ML_number, adams_key = Sys.getenv("ADAMS")) {
  if (all(ML_number |> stringr::str_starts("ML"))) {
    results <- tibble::tibble()
    for (ml in ML_number) {
      get <- paste0("https://adams-api.nrc.gov/aps/api/search/", ml)
      accept <- "application/json"

      req <- httr2::request(get) |>
        httr2::req_headers(
          "Accept" = accept,
          "Ocp-Apim-Subscription-Key" = adams_key
        )

      resp <- req |> httr2::req_perform() |> httr2::resp_body_json()

      current_tbl <- nrcadams:::decode_resp(resp)
      results <- dplyr::bind_rows(results, current_tbl)
    }
    return(results)
  } else {
    stop("No ML number was entered.")
  }
}

#' Process first and last dates.
#'
#' @param days_back dbl: Length of time the search extends in days since
#' the document was published on ADAMS? Default is all time (i.e, NA).
#' Cannot be used with start_date or end_date.
#' @param start_date chr: The earliest date (ymd) search results should
#' be returned. Cannot be used with days_back.
#' @param end_date chr: The latest date (ymd) search results should be
#' returned. Cannot be used with days_back.
#'
#' @return list of start and end dates
#' @keywords Internal
process_dates = function(start_date = NA, end_date = NA, days_back = NA) {
  if(!is.na(days_back)) {
    if(!is.na(start_date)) warning("days_back and start_date are both defined. days_back is used.")
    if(!is.na(end_date)) warning("days_back and end_date are both defined. days_back is used.")
    date = list(
      start = Sys.Date() |> lubridate::ymd() - days_back,
      end = NA
    )
  } else {
    date = list(
      start = start_date,
      end = end_date
    )
  }
}

#' Conducts a single ADAMS Search on Docket Numbers
#'
#' Maximum of 100 results per search, so multiple searches may be needed.
#' Please use search_docket() for most use cases.
#'
#' @param search_term chr: Any search term desired. Default is nothing
#' (i.e., NA)
#' @param DocketNumber dbl/vector: Docket number (or numbers)
#' to be searched on ADAMS
#' @param start_date chr: The earliest date (ymd) search results should
#' be returned. Cannot be used with days_back.
#' @param end_date chr: The latest date (ymd) search results should be
#' returned. Cannot be used with days_back.
#' @param skip_int: Number of records to skip in the search.
#' @param verbosity dbl: Level of verbosity for REST API requests.
#'
#' @source \url{https://adams-search.nrc.gov/assets/APS-API-Guide.pdf}
#' @return tibble of search results
#' @export
search_public_ADAMS <- function(
  search_term = NA,
  DocketNumber = NA,
  start_date = NA,
  author_affiliation = NA,
  document_type = NA,
  results_tag = NA,
  end_date = NA,
  skip_int = 0,
  verbosity = 0,
  adams_key = Sys.getenv("ADAMS")
) {
  # Perp REST API request
  get <- "https://adams-api.nrc.gov/aps/api/search"
  accept <- "application/json"

  # Create docket requests
  dockets <- list()
  antidockets <- list()
  if (length(DocketNumber) == 0) {
    DocketNumber <- NA
  }

  if (!any(is.na(DocketNumber))) {
    i <- 1
    j <- 1
    for (number in DocketNumber) {
      if (number >= 0) {
        dockets[[i]] <- list(
          field = "DocketNumber",
          value = number |> as.character(),
          operator = "contains"
        )
        i <- i + 1
      } else {
        antidockets[[j]] <- list(
          field = "DocketNumber",
          value = number |> as.character(),
          operator = "notcontains"
        )
        j <- j + 1
      }
    }
  }

  # Create date requests
  if (!is.na(start_date)) {
    start <- list(
      field = "DateAddedTimestamp",
      value = paste0("(DateAddedTimestamp ge '", start_date, "')")
    )
  }
  if (!is.na(end_date)) {
    end <- list(
      field = "DateAddedTimestamp",
      value = paste0("(DateAddedTimestamp le '", end_date, "')")
    )
  }
  if (is.na(start_date) && is.na(end_date)) {
    and_filters <- list()
  } else if (is.na(start_date)) {
    and_filters <- list(end)
  } else if (is.na(end_date)) {
    and_filters <- list(start)
  } else {
    and_filters <- list(start, end)
  }
  if (!is.na(author_affiliation)) {
    and_filters <- and_filters |> append(
      list(list(
        field = "AuthorAffiliation",
        value = author_affiliation,
        operator = "contains"
      ))
    )
  }
  if (length(antidockets) > 0) {
    warning(
      "Negative docket numbers detected. These will be used to exclude",
      "documents from the search results."
    )
    and_filters <- append(and_filters, antidockets)
  }
  # Pull together all requests
  body <- list(
    filters = and_filters, # AND gate
    anyFilters = dockets, # OR gate
    legacyLibFilter = TRUE,
    mainLibFilter = TRUE,
    sort = "DateAddedTimestamp",
    sortDirection = 1,
    skip = skip_int
  )
  print(body)
  if (!is.na(search_term)) {
    body$q <- search_term
  }

  req <- httr2::request(get) |>
    httr2::req_headers(
      "Accept" = accept,
      "Ocp-Apim-Subscription-Key" = adams_key
    )  |>
    httr2::req_method("POST") |>
    httr2::req_body_json(body)

  # Submit request and parse response
  resp <- req |>
    # httr2::req_perform(verbosity = 2) |>
    httr2::req_perform(verbosity = verbosity) |>
    httr2::resp_body_json()

  results <- nrcadams:::decode_resp(resp) |>
    dplyr::mutate(tag = results_tag)
}



#' Decodes the REST API response from ADAMS
#' 
#' Takes the response from the REST API and converts it into a tidy tibble.
#'
#' @param resp response from REST API
#'
#' @source \url{https://adams-search.nrc.gov/assets/APS-API-Guide.pdf}
#' @return tibble of search results
#' @keywords Internal
decode_resp <- function(resp) {

  clean_record <- function(x) {
    lapply(x, function(v) {
      if (is.null(v)) return(NA) # NULL -> NA
      if (is.atomic(v) && length(v) > 1) paste(v, collapse = ", ")
      # for lists or atomic vectors length > 1,
      # wrap into a single list element
      list(v)
    })
  }

  tbl <- if ("results" %in% names(resp)) {
    records <- resp$results

    if (length(records) == 0) {
      tibble::tibble()
    } else {
      records |>
        purrr::map_dfr(\(x) {
          tibble::as_tibble(clean_record(x))
        }) |>
        dplyr::select(document) |>
        tidyr::unnest_wider(document)
    }
  } else if ("document" %in% names(resp)) {
    tibble::as_tibble(clean_record(resp$document))
  }



  if (length(tbl$DocumentTitle) > 0) {
    results <- tbl |>
      dplyr::mutate(
        dplyr::across(dplyr::where(is.list), ~ sapply(., toString)),
        Title = DocumentTitle,
        `Document Date` = lubridate::ymd(DocumentDate),
        `Publish Date` = lubridate::ymd_hm(DateAddedTimestamp, tz = "EDT"),
        Type = DocumentType,
        Affiliation = AuthorAffiliation,
        URL = Url,
        DocketNumber = DocketNumber,
        `ML Number` = AccessionNumber,
        count = dplyr::case_when(
          is.null(resp$count) ~ 1,
          .default = resp$count
        )
      ) |>
      tidyr::separate_rows(DocketNumber) |>
      dplyr::select(
        DocketNumber, `ML Number`, Title, `Document Date`, `Publish Date`,
        Type, Affiliation, URL, count
      ) |>
      dplyr::mutate(DocketNumber = DocketNumber |> as.double())
  } else {
    warning("\nThe search return no results.\n")
    results <- tibble::tibble(
      DocketNumber = c(), `ML Number` = c(), Title = c(), `Document Date` = c(),
      `Publish Date` = c(), Type = c(), Affiliation = c(), URL = c(), count = c()
    )
  }
}



#' Conduct ADAMS Search on Author Affliation and Search Terms
#'
#' @param search_term chr: string with the search query
#' @param author_affiliation chr: string with the author affiliation
#' @param DocketNumber chr: string with the docket number
#' @param results_tag chr: string with the results tag
#' @param days_back dbl: Length of time the search extends in days since
#' the document was published on ADAMS? Default is 7 days.
#' @param skip_int dbl: Number of results to skip
#' @param max_returns dbl: Maximum number of results to return
#' @param verbosity dbl: Level of verbosity for the httr2 request
#' @param adams_key chr: ADAMS API key
#'
#' @source \url{https://adams-search.nrc.gov/assets/APS-API-Guide.pdf}
#' @return tibble of search results
#' @export
#'
search_values <- function(
  search_term = NA,
  author_affiliation = NA,
  DocketNumber = NA,
  results_tag = NA,
  days_back = 7,
  skip_int = 0,
  max_returns = 1E6,
  verbosity = 0,
  adams_key = Sys.getenv("ADAMS")
) {
  date <- nrcadams:::process_dates(days_back = days_back)
  results <- tibble::tibble()
  more_searches <- TRUE
  count <- 0

  while (more_searches) {
    current_tbl <- nrcadams::search_public_ADAMS(
      search_term = search_term,
      author_affiliation = author_affiliation,
      DocketNumber = DocketNumber,
      results_tag = results_tag,
      start_date = date$start,
      end_date = date$end,
      skip_int = skip_int,
      verbosity = verbosity,
      adams_key = adams_key
    )
    records = list(
      max = current_tbl$count |> max(),
      current = count * 100 + length(unique(current_tbl$`ML Number`))
    )
    count = count + 1
    if (records$max <= records$current) {
      results <- dplyr::bind_rows(results, current_tbl)
      more_searches <- FALSE
    } else if (count == max_returns / 100) {
      results <- dplyr::bind_rows(results, current_tbl)
      more_searches <- FALSE
      warning(
        paste(
          "Results exceed the maximum number of returns:", max_returns,
          ". The search yeilded the following number of results:",
          records$max, ". Consider refining the search criteria."
        )
      )
    } else {
      skip_int <- skip_int + 100
      results <- dplyr::bind_rows(results, current_tbl)
    }
  }
  return(results)
}