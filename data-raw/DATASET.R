adv_reactor_dockets_lt_2023 = nrcadams::docket_codex |>
  dplyr::pull(DocketNumber) |>
  nrcadams::search_long_docket(number_of_intervals = 30) |>
  dplyr::left_join(nrcadams::docket_codex) |>
  dplyr::filter(
    !is.na(Project),
    `Publish Date` < lubridate::ymd("2023-01-01")
    )

usethis::use_data(adv_reactor_dockets_lt_2023, overwrite = TRUE)
