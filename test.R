key <- Sys.getenv("ADAMS")
get <- "https://adams-api.nrc.gov/aps/api/search"
accept <- "application/json"

body <- list(
  q = "Safety valve",
  filters = list(
    list(field = "DocumentType", value = "Inspection Report", operator = "equals"),
    list(field = "DateAddedTimestamp", value = "(DocumentDate ge '2024-01-01')")
  ),
  anyFilters = list(),
  legacyLibFilter = TRUE,
  mainLibFilter = TRUE,
  sort = "",
  sortDirection = 1,
  skip = 0
)


req <- httr2::request(get) |>
  httr2::req_headers(
    "Accept" = accept,
    "Ocp-Apim-Subscription-Key" = key
  )  |>
  httr2::req_method("POST") |>
  httr2::req_body_json(body)

resp <- req |> httr2::req_perform() |>
  httr2::resp_body_json()

records <- if ("results" %in% names(resp)) resp$results else resp

clean_record <- function(x) {
  lapply(x, \(v) {
    if (is.null(v)) return(NA) # NULL -> NA
    if (is.atomic(v) && length(v) > 1) paste(v, collapse = ", ")
    # for lists or atomic vectors length > 1, wrap into a single list element
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
    dplyr::select(document)
}

tbl |>
  tidyr::unnest_wider(document) |>
  dplyr::mutate(dplyr::across(dplyr::where(is.list), ~ sapply(., toString))) |>
  dplyr::mutate(
    Title = DocumentTitle,
    `Document Date` = lubridate::ymd(DocumentDate),
    `Publish Date` = lubridate::ymd_hm(DateAddedTimestamp, tz = "EDT") -
      4 * 3600,
    Type = DocumentType,
    Affiliation = AddresseeAffiliation,
    URL = Url,
    DocketNumber = as.double(DocketNumber),
    `ML Number` = AccessionNumber
  ) |>
  dplyr::select(
    Title, `Document Date`, `Publish Date`,
    Type, Affiliation, URL, DocketNumber, `ML Number`
  )


DocketNumber |> nrcadams::search_docket(days_back = 45)


DocketNumber <- nrcadams::docket_codex |>
  dplyr::filter(stringr::str_detect(Project, "Hermes")) |>
  dplyr::pull(DocketNumber)

DocketNumber <- nrcadams::docket_codex |>
  dplyr::filter(Company == "TerraPower") |>
  dplyr::pull(DocketNumber)


results <- nrcadams::search_values(
  search_term = NA,
  author_affiliation = "NRC/ACRS",
  results_tag = NA,
  days_back = 30,
  skip_int = 0,
  max_returns = 1E6,
  verbosity = 0,
  adams_key = Sys.getenv("ADAMS")
)

  search_term = NA
  author_affiliation = "NRC/ACRS"
  results_tag = NA
  days_back = 30
  skip_int = 0
  max_returns = 1E6
  verbosity = 0
  adams_key = Sys.getenv("ADAMS")