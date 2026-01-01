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
#' @param rest_api logical: If TRUE, use the REST API to conduct the search.
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
  document_type = NA,
  rest_api = FALSE,
  skip_int = 0,
  max_returns = 1E6,
  verbosity = 0
) {
  # Error checking days_back input and adjustment of start_date and end_date
  if(!is.na(days_back)) {
    if(!is.na(start_date)) warning("days_back and start_date are both defined. days_back is used.")
    if(!is.na(end_date)) warning("days_back and end_date are both defined. days_back is used.")
    start_date = Sys.Date() |> lubridate::ymd() - days_back
    end_date = Sys.Date() |> lubridate::ymd() + 1
  }
  # Error Checking on docket number input
  if (!all(DocketNumber |> is.double() ||  DocketNumber |> is.character())) {
    stop(
      paste(
        "Either no docket number was entered or the docket number was",
        "not formatted as either a double or character string."
      )
    )
  }

  if (rest_api) {
    results <- tibble::tibble()
    more_searches <- TRUE
    count <- 0

    while (more_searches) {
      current_tbl <- nrcadams::search_public_ADAMS(
        DocketNumber = DocketNumber,
        search_term = search_term,
        start_date = start_date,
        end_date = end_date,
        skip_int = skip_int,
        verbosity = verbosity
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
  } else {

    url = paste0(
      nrcadams:::adams_search_head,
      nrcadams:::adams_docket_numbers(DocketNumber),
      nrcadams:::adams_all(document_type, start_date, end_date),
      nrcadams:::adams_search_term(search_term),
      nrcadams:::adams_search_tail(!is.na(search_term))
    )

    paste("Searching with the following URL:\n", url, "\n") |>
      tictoc::tic()
    results <- nrcadams:::make_results_tibble(url)
    tictoc::toc()

    if(results |> nrow() >= 1000) {
      warning(
        "\nThis search returned more than 1000 results and thus may be incomplete. As a result, the search should be refined.\n"
      )
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
search_ml <- function(ML_number) {
  rm(results) |> suppressWarnings()
  if (all(ML_number |> stringr::str_starts("ML"))) {
    for (ml in ML_number) {
      print(ml)
      key <- Sys.getenv("ADAMS")
      get <- paste0("https://adams-api.nrc.gov/aps/api/search/", ml)
      accept <- "application/json"

      req <- httr2::request(get) |>
        httr2::req_headers(
          "Accept" = accept,
          "Ocp-Apim-Subscription-Key" = key
        )

      resp <- req |> httr2::req_perform() |> httr2::resp_body_json()

      file <- resp$document

      adams_tbl <- tibble::tibble(
        Title = file$DocumentTitle,
        `Document Date` = file$DocumentDate |>
          lubridate::ymd(),
        `Publish Date` = file$DateAddedTimestamp |>
          lubridate::ymd_hm(tz = "EDT"),
        Type = nrcadams:::collapse_list(file$DocumentType),
        Affiliation = nrcadams:::collapse_list(file$AddresseeAffiliation),
        URL = file$Url,
        DocketNumber = nrcadams:::collapse_list(file$DocketNumber),
        `ML Number` = file$AccessionNumber
      ) |>
        dplyr::mutate(DocketNumber = DocketNumber |> as.double()) |>
        suppressWarnings()

      if (!exists("results")) {
        results <- adams_tbl
      } else {
        results <- results |>
          dplyr::full_join(adams_tbl)
      }
    }
    results <- results |>
      dplyr::arrange(dplyr::desc(`Publish Date`))

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

#' Collapse List
#'
#' @param list_to_collapse list to be compressed
#'
#' @return vector of listed object
#' @keywords Internal
collapse_list = function(list_to_collapse) {
  if (length(list_to_collapse) == 0) {
    result = "NA"
  } else {
    result = paste0(list_to_collapse, collapse = "; ")
  }
  return(result)
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

  if(is.null(docket_number)) docket_number <- 1

  adams_tbl <- tibble::tibble(
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



#' Conducts a single ADAMS Search on Docket Numbers
#' 
#' Maximum of 100 results per search, so multiple searches may be needed.
#' Please use search_docket() for most use cases.
#'
#' @param DocketNumber dbl/vector: Docket number (or numbers)
#' to be searched on ADAMS
#' @param search_term chr: Any search term desired. Default is nothing
#' (i.e., NA)
#' @param start_date chr: The earliest date (ymd) search results should
#' be returned. Cannot be used with days_back.
#' @param end_date chr: The latest date (ymd) search results should be
#' returned. Cannot be used with days_back.
#' @param rest_api logical: If TRUE, use the REST API to conduct the search.
#' @param skip_int: Number of records to skip in the search.
#' @param verbosity dbl: Level of verbosity for REST API requests.
#'
#' @source \url{https://adams-search.nrc.gov/assets/APS-API-Guide.pdf}
#' @return tibble of search results
#' @export
search_public_ADAMS <- function(
  DocketNumber,
  search_term,
  start_date,
  end_date,
  skip_int,
  verbosity = 0
) {
  # Perp REST API request
  key <- Sys.getenv("ADAMS")
  get <- "https://adams-api.nrc.gov/aps/api/search"
  accept <- "application/json"

  # Create docket requests
  dockets <- list()
  i <- 1
  for (number in DocketNumber) {
    dockets[[i]] <- list(
      field = "DocketNumber",
      value = number |> as.character(),
      operator = "contains"
    )
    i <- i + 1
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
    dates <- list()
  } else if (is.na(start_date)) {
    dates <- list(end)
  } else {
    dates <- list(start)
  }

  # Pull together all requests
  body <- list(
    filters = dates, # AND gate
    anyFilters = dockets, # OR gate
    legacyLibFilter = TRUE,
    mainLibFilter = TRUE,
    sort = "DateAddedTimestamp",
    sortDirection = 1,
    skip = skip_int
  )
  if (!is.na(search_term)) {
    body$q <- search_term
  }

  req <- httr2::request(get) |>
    httr2::req_headers(
      "Accept" = accept,
      "Ocp-Apim-Subscription-Key" = key
    )  |>
    httr2::req_method("POST") |>
    httr2::req_body_json(body)

  # Submit request and parse response
  resp <- req |>
    httr2::req_perform(verbosity = 0) |>
    httr2::resp_body_json()

  records <- if ("results" %in% names(resp)) resp$results else resp

  clean_record <- function(x) {
    lapply(x, function(v) {
      if (is.null(v)) return(NA) # NULL -> NA
      if (is.atomic(v) && length(v) > 1) paste(v, collapse = ", ")
      # for lists or atomic vectors length > 1,
      # wrap into a single list element
      list(v)
    })
  }

  if (length(records) == 0) {
    tbl <- tibble::tibble()
  } else {
    tbl <- records |>
      purrr::map_dfr(function(x) {
        tibble::as_tibble(clean_record(x))
      }) |>
      dplyr::select(document) |>
      tidyr::unnest_wider(document)
  }

  results <- tbl |>
    dplyr::mutate(
      dplyr::across(dplyr::where(is.list), ~ sapply(., toString)),
      Title = DocumentTitle,
      `Document Date` = lubridate::ymd(DocumentDate),
      `Publish Date` = lubridate::ymd_hm(DateAddedTimestamp, tz = "EDT"),
      Type = DocumentType,
      Affiliation = AddresseeAffiliation,
      URL = Url,
      DocketNumber = DocketNumber,
      `ML Number` = AccessionNumber,
      count = resp$count
    ) |>
    tidyr::separate_rows(DocketNumber) |>
    dplyr::select(
      DocketNumber, `ML Number`, Title, `Document Date`, `Publish Date`,
      Type, Affiliation, URL, count
    ) |>
    dplyr::mutate(DocketNumber = DocketNumber |> as.double())
  # print(results)
  # return(results)
}
