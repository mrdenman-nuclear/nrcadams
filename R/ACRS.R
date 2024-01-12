#' Conduct ADAMS Search on ACRS Documents
#'
#' @param days_back dbl: Length of time the search extends in days since the document was published on ADAMS? Default is all time (i.e, NA). Cannot be used with start_date or end_date.
#'
#' @source \url{https://www.nrc.gov/site-help/developers/wba-api-developer-guide.pdf}
#' @return tibble of search results
#' @export
#'
search_ACRS <- function(
  days_back = 7
  ) {
    start_date = Sys.Date() |> lubridate::ymd() - days_back

    url = paste0(
      nrcadams:::adams_search_head,
      "properties_search_all:!(!(AuthorAffiliation,starts,NRC/ACRS,''),",
      nrcadams:::adams_start_or_end(start_date, FALSE),
      ")",
      nrcadams:::adams_search_tail(FALSE)
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
}
