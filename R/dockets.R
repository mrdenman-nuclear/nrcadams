#' Codex of Docket Numbers
#'
#' @description Docket numbers are hard to keep track of so let `nrcadams`
#' keep track of them for you! This exported tibble provides the project name,
#' company, and docket number for a selection of efforts.
#'
#' @format A tibble with columns for project names, company names, docket numbers, and logical flag for NLWR applications.
#'
#' @return tibble of docket numbers
#' @export
#' @examples nrcadams::docket_codex
docket_codex = tibble::tribble(
  ~Project, ~Company, ~DocketNumber, ~NLWR,
  "MSRR Pre-Application", "ACU", 99902088, TRUE,
  "MSRR Docket", "ACU", 05000610, TRUE,
  "Shine Docket", "SHINE Medical Technologies", 05000608, TRUE,
  "Shine Pre-Application", "Shine Medical Technologies", 99902034, TRUE,
  "Xe-100 Pre-Application", "X-Energy", 99902071, TRUE,
  "TRISO-X Fab. Docket", "X-Energy", 07007027, TRUE,

  # # The following docket numbers were assigned to one prop withholding form...
  # "X-Energy", "Entergy",  5000313, FALSE,
  # "X-Energy", "Entergy",  5000368, FALSE,
  # "X-Energy", "Entergy",  5000382, FALSE,
  # "X-Energy", "Entergy",  5000416, FALSE,
  # "X-Energy", "Entergy",  5000458, FALSE,
  # "X-Energy", "Entergy",  7200013, FALSE,
  # "X-Energy", "Entergy",  7200049, FALSE,
  # "X-Energy", "Entergy",  7200050, FALSE,
  # "X-Energy", "Entergy",  7200075, FALSE,

  "Natrium Pre-Application", "GE/TerraPower", 99902100, TRUE,
  "UIUC HTGR Pre-Application", "UCUI", 99902094, TRUE,
  "eVinci Pre-Application", "Westinghouse", 99902079, TRUE,
  "IMSR Pre-Application", "Terrestrial Energy", 99902076, TRUE,
  "BWRX-300 Pre-Application", "GE", 99900003, FALSE,
  "SMR-160 Pre-Application", "Holtec", 99902049, FALSE,
  "NuScale NPM Pre-Application", "NuScale", 99902078, FALSE,
  "KP-X Pre-Application", "Kairos Power", 99902069, TRUE,
  "Hermes Docket", "Kairos Power", 05007513, TRUE,
  "Oklo Pre-Application", "Oklo", 99902095, TRUE,
  "Aurora Docket", "Oklo", 05200049, TRUE
)
