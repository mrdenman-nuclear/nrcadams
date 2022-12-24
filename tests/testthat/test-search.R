testthat::test_that("ACU Docket Files can be found", {
  ACU_docket_numbers = c(05000610, 99902088)
  full_results = ACU_docket_numbers |>
    nrcadams::search_docket()
  testthat::expect_true(full_results |> length() > 0)
})

testthat::test_that("ACU Docket Files can be found", {
  ACU_docket_numbers = c(05000610, 99902088)
  full_results = ACU_docket_numbers |>
    nrcadams::search_docket()
  partial_results = ACU_docket_numbers |>
    nrcadams::search_docket(days_back = 40)
  testthat::expect_true(full_results$Title |> length() > partial_results$Title |> length())
})

testthat::test_that("Docket Search Works", {
  ACU_docket_numbers = c(05000610, 99902088)
  search_results = ACU_docket_numbers |>
    nrcadams::search_docket(search_term = "Acceptance")
  testthat::expect_true(search_results$Title |> length() > 1)
})
