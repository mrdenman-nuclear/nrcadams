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
  "MSRR Part 50", "ACU", 05000610, TRUE,
  "Shine Part 50", "SHINE Medical Technologies", 05000608, TRUE,
  "Shine Recycling Pre-Application", "SHINE Medical Technologies", 99902115, TRUE,
  "Xe-100 Pre-Application", "X-Energy", 99902071, TRUE,
  "TRISO-X Fab. Part 70", "X-Energy", 07007027, TRUE,
  "Long Mott Pre-Application", "X-Energy", 99902117, TRUE,
  "Long Mott Part 50", "X-Energy", 05000614, TRUE,
  "AP300", "Westinghouse", 99902111, FALSE,

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

  "Natrium Pre-Application", "TerraPower", 99902100, TRUE,
  "Natrium Part 50", "TerraPower", 05000613, TRUE,
  "USO SFR Owner Pre-Applicatoin","TerraPower", 99902150, TRUE,
  "UIUC HTGR Pre-Application", "UCUI", 99902094, TRUE,
  "eVinci Pre-Application", "Westinghouse", 99902079, TRUE,
  "IMSR Pre-Application", "Terrestrial Energy", 99902076, TRUE,
  "BWRX-300 Pre-Application", "GE", 99900003, FALSE,
  "SMR-300 Pre-Application", "Holtec", 99902049, FALSE,
  "NuScale 50 MWe Part 52", "NuScale", 05200048, FALSE,
  "NuScale 77 MWe Pre-Application", "NuScale", 99902078, FALSE,
  "NuScale 77 MWe Part 52", "NuScale", 5200050, FALSE,
  "Carbon Free Power Project", "NuScale", 99902052, FALSE,
  "KP Pre-Application", "Kairos Power", 99902069, TRUE,
  "Hermes Part 50", "Kairos Power", 05007513, TRUE,
  "Hermes 2 Part 50", "Kairos Power", 05000611, TRUE,
  "Hermes 2 Unit 2 Part 50", "Kairos Power", 05000612, TRUE,
  "Oklo Reactor Pre-Application", "Oklo", 99902095, TRUE,
  "Oklo Fuel Cycle Pre-Application", "Oklo", 99902101, TRUE,
  "Aurora Part 52", "Oklo", 05200049, TRUE,
  "Aalo-1 Pre-Application","Aalo", 99902128, TRUE,
  "RELLIS ESP Pre-Application", "TAMU", 99902136, FALSE,
  "Natura Pre-Application", "Natura Resources", 99902122, TRUE,
  "BWRX-300 Clinch River Pre-Application", "TVA", 99902056, FALSE,
  "BWRX-300 Clinch River Part 50", "TVA", 05000615, FALSE
)

#' Codex of Research and Test Reactor Docket Numbers
#'
#' @description Docket numbers are hard to keep track of so let `nrcadams`
#' keep track of them for you! This exported tibble provides the project name,
#'  and docket number for a selection of RTRs
#'
#' @format A tibble with columns for project names, docket numbers.
#'
#' @return tibble of docket numbers
#' @export
#' @examples nrcadams::docket_codex
RTR_docket_codex <- tibble::tribble(
    ~Project, ~DocketNumber,
    "Aerotest Operations Inc. (R-098)", 05000228,
    "Armed Forces Radiobiological Research Institute (R-084)", 05000170,
    "Dow Chemical Company (R-108)", 05000264,
    "General Electric Company (R-033)", 05000073,
    "Idaho State University (R-110)", 05000284,
    "Kansas State University (R-088)", 05000188,
    "Massachusetts Institute of Technology (R-037)", 05000020,
    "National Institute of Standards and Technology (TR-005)", 05000184,
    "North Carolina State University (R-120)", 05000297,
    "Oregon State University (R-106)", 05000243,
    "Penn State University (R-002)", 05000005,
    "Purdue University (R-087)", 05000182,
    "Reed College (R-112)", 05000288,
    "Rensselaer Polytechnic Institute (CX-022)", 05000225,
    "Rhode Island Atomic Energy Commission (R-095)", 05000193,
    "Texas A&M University AGN-201 (R-023)", 05000059,
    "Texas A&M University TRIGA (R-083)", 05000128,
    "The Ohio State University (R-075)", 05000150,
    "U.S. Geological Survey (R-113)", 05000274,
    "University of California-Davis (R-130)", 05000607,
    "University of California-Irvine (R-116)", 05000326,
    "University of Florida (R-056)", 05000083,
    "University of Maryland (R-070)", 05000166,
    "University of Massachusetts (R-125)", 05000223,
    "University of Missouri (R-103)", 05000186,
    "University of Missouri (R-079)", 05000123,
    "University of New Mexico (R-102)", 05000252,
    "University of Texas (R-129)", 05000602,
    "University of Utah (R-126)", 05000407,
    "University of Wisconsin (R-074)", 05000156,
    "Washington State University (R-076)", 05000027
)
