#' Advanced Reactor Docket Pull Prior to 2023
#'
#' This tibble contains a pre-pulled set of search results from the dockets
#' found in nrcadams::docket_codex using nrcadams::search_long_docket.
#'
#' During package develop, github actions experienced frequent connection timeouts
#' when pulling this entire dataset. By pre-exporting this dataset, the burden
#' on github actions searches should be reduced.
#'
#' @format tibble of ADAMS search results before Jan. 1 2023
"adv_reactor_dockets_lt_2023"
