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
  

  adams_tbl = nrcadams:::make_results_tibble_no_docket(url, company)


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
