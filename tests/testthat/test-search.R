testthat::test_that("ACU Docket Files can be found", {
  full_results = nrcadams::docket_codex |>
    dplyr::filter(Company == "ACU") |>
    dplyr::pull(DocketNumber)  |>
    nrcadams::search_docket()
  testthat::expect_true(full_results |> nrow() > 0)
})

testthat::test_that("ACU Docket Files can be found", {
  full_results = nrcadams::docket_codex |>
    dplyr::filter(Company == "ACU") |>
    dplyr::pull(DocketNumber)  |>
    nrcadams::search_docket()
  partial_results = nrcadams::docket_codex |>
    dplyr::filter(Company == "ACU") |>
    dplyr::pull(DocketNumber) |>
    nrcadams::search_docket(days_back = 40)
  testthat::expect_true(full_results |> nrow() > partial_results |> nrow())
})

testthat::test_that("Docket Search Works", {
  search_results = nrcadams::docket_codex |>
    dplyr::filter(Company == "ACU") |>
    dplyr::pull(DocketNumber) |>
    nrcadams::search_docket(search_term = "Acceptance")
  testthat::expect_true(search_results |> nrow() > 1)
})

testthat::test_that("ML Search Works", {
  search_results = c("ML22179A346", "ML19211C119") |> nrcadams::search_ml()
  testthat::expect_true(search_results |> nrow() == 2)
})

testthat::test_that("Searches with over 1000 entries at least return the 1000 entries", {
  search_results = nrcadams::docket_codex |>
    dplyr::filter(Company == "SHINE Medical Technologies") |>
    dplyr::pull(DocketNumber) |>
    nrcadams::search_docket() |> testthat::expect_warning()
  testthat::expect_true(search_results |> nrow() >= 1000)
})

testthat::test_that("Long search effectively pull the entire search history", {
  search_results = nrcadams::docket_codex |>
    dplyr::filter(NLWR) |>
    dplyr::pull(DocketNumber) |>
    nrcadams::search_long_docket(number_of_intervals = 10)
  testthat::expect_true(search_results |> nrow() >= 3000)
})

testthat::test_that("Topical Reports can be pulled", {
  search_results = nrcadams::docket_codex |>
    dplyr::filter(NLWR) |>
    dplyr::pull(DocketNumber) |>
    nrcadams::search_docket(document_type = "Topical Report")
  testthat::expect_true(search_results |> nrow() >= 50)
})


