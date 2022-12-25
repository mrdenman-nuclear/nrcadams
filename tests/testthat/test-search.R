testthat::test_that("ACU Docket Files can be found", {
  full_results = nrcadams::docket_codex |>
    dplyr::filter(Company == "ACU") |>
    dplyr::pull(Docket_Number)  |>
    nrcadams::search_docket()
  testthat::expect_true(full_results |> length() > 0)
})

testthat::test_that("ACU Docket Files can be found", {
  full_results = nrcadams::docket_codex |>
    dplyr::filter(Company == "ACU") |>
    dplyr::pull(Docket_Number)  |>
    nrcadams::search_docket()
  partial_results = nrcadams::docket_codex |>
    dplyr::filter(Company == "ACU") |>
    dplyr::pull(Docket_Number) |>
    nrcadams::search_docket(days_back = 40)
  testthat::expect_true(full_results$Title |> length() > partial_results$Title |> length())
})

testthat::test_that("Docket Search Works", {
  search_results = nrcadams::docket_codex |>
    dplyr::filter(Company == "ACU") |>
    dplyr::pull(Docket_Number) |>
    nrcadams::search_docket(search_term = "Acceptance")
  testthat::expect_true(search_results$Title |> length() > 1)
})

testthat::test_that("ML Search Works", {
  search_results = c("ML22179A346", "ML19211C119") |> nrcadams::search_ml()
  testthat::expect_true(search_results$Title |> length() == 2)
})
