#' Codex of Docket Numbers
#'
#' @description Docket numbers are hard to keep track of so let `nrcadams`
#' keep track of them for you! This exported tibble provides the project name,
#' company, and docket number for a selection of efforts.
#'
#' @format A tibble with columns for project name, compnay name, and docket number.
#'
#' @return tibble of docket numbers
#' @export
#' @examples nrcadams::docket_codex
docket_codex = tibble::tribble(
  ~Project, ~Company, ~Docket_Number,
  "MSRR Pre-Application", "ACU", 99902088,
  "MSRR Docket", "ACU", 05000610,
  "Shine Docket", "SHINE Medical Technologies", 05000608,
  "Xe-100 Pre-Application", "X-Energy", 99902071,
  "Natrium Pre-Application", "GE/TerraPower", 99902100,
  "UIUC HTGR Pre-Application", "UCUI", 99902094,
  "eVinci Pre-Application", "Westinghouse", 99902079,
  "IMSR Pre-Application", "Terrestrial Energy", 99902076,
  "BWRX-300 Pre-Application", "GE", 99900003,
  "SMR-160 Pre-Application", "Holtec", 99902049,
  "NuScale NPM Pre-Application", "NuScale", 99902078,
  "KP-X Pre-Application", "Kairos Power", 99902069,
  "Hermes Docket", "Kairos Power", 05007513
)
