# RSS Files

This page is updated Monday through Friday, hourly between 9AM ET and 5
PM ET. It presents RSS files for the various dockets tracked by the
`nrcadams` package. The last update was at 2026-01-26 15:24:55.527107
ET.

## Using the RSS Feeds

If you are unfamiliar with RSS readers, they are magical. Here is an
article that can point you to some of the best. I generally just use the
slack feed reader which is cool because it can enable easy conversations
within our team about key documents.

<https://www.theverge.com/24036427/rss-feed-reader-best>

## Making RSS files

The following code shows the user how they can generate RSS files to
help keep updated with their favorite ADAMS search results.

## Advanced Reactor Dockets

The RSS files generated on this page and updated by this site are
located at the URLs shown in the table below.

``` r
last_week_in_dockets = nrcadams::docket_codex |>
  dplyr::pull(DocketNumber) |>
  nrcadams::search_docket(days_back = 14) |>
  dplyr::left_join(nrcadams::docket_codex) |>
  dplyr::filter(!is.na(Project))
#> 
#>  This search returned: 94 files.
#> Joining with `by = join_by(DocketNumber)`


nrcadams::docket_codex |>
  dplyr::pull(Project) |>
  purrr::walk(\(.x) {
    last_week_in_dockets |>
      dplyr::filter(Project == .x) |>
      nrcadams::write_rss(
        file = here::here("docs", "RSS", paste0(
          .x |> stringr::str_replace_all(" ", "_"), ".rss")
          ),
        title = .x 
        )
  })
#> RSS feed created at: /home/runner/work/nrcadams/nrcadams/docs/RSS/MSRR_Pre-Application.rss 
#> RSS feed created at: /home/runner/work/nrcadams/nrcadams/docs/RSS/MSRR_Part_50.rss 
#> RSS feed created at: /home/runner/work/nrcadams/nrcadams/docs/RSS/Shine_Part_50.rss 
#> RSS feed created at: /home/runner/work/nrcadams/nrcadams/docs/RSS/Shine_Recycling_Pre-Application.rss 
#> RSS feed created at: /home/runner/work/nrcadams/nrcadams/docs/RSS/Xe-100_Pre-Application.rss 
#> RSS feed created at: /home/runner/work/nrcadams/nrcadams/docs/RSS/TRISO-X_Fab._Part_70.rss 
#> RSS feed created at: /home/runner/work/nrcadams/nrcadams/docs/RSS/Long_Mott_Pre-Application.rss 
#> RSS feed created at: /home/runner/work/nrcadams/nrcadams/docs/RSS/Long_Mott_Part_50.rss 
#> RSS feed created at: /home/runner/work/nrcadams/nrcadams/docs/RSS/AP300.rss 
#> RSS feed created at: /home/runner/work/nrcadams/nrcadams/docs/RSS/Natrium_Pre-Application.rss 
#> RSS feed created at: /home/runner/work/nrcadams/nrcadams/docs/RSS/Natrium_Part_50.rss 
#> RSS feed created at: /home/runner/work/nrcadams/nrcadams/docs/RSS/USO_SFR_Owner_Pre-Applicatoin.rss 
#> RSS feed created at: /home/runner/work/nrcadams/nrcadams/docs/RSS/UIUC_HTGR_Pre-Application.rss 
#> RSS feed created at: /home/runner/work/nrcadams/nrcadams/docs/RSS/eVinci_Pre-Application.rss 
#> RSS feed created at: /home/runner/work/nrcadams/nrcadams/docs/RSS/IMSR_Pre-Application.rss 
#> RSS feed created at: /home/runner/work/nrcadams/nrcadams/docs/RSS/BWRX-300_Pre-Application.rss 
#> RSS feed created at: /home/runner/work/nrcadams/nrcadams/docs/RSS/SMR-300_Pre-Application.rss 
#> RSS feed created at: /home/runner/work/nrcadams/nrcadams/docs/RSS/NuScale_50_MWe_Part_52.rss 
#> RSS feed created at: /home/runner/work/nrcadams/nrcadams/docs/RSS/NuScale_77_MWe_Pre-Application.rss 
#> RSS feed created at: /home/runner/work/nrcadams/nrcadams/docs/RSS/NuScale_77_MWe_Part_52.rss 
#> RSS feed created at: /home/runner/work/nrcadams/nrcadams/docs/RSS/Carbon_Free_Power_Project.rss 
#> RSS feed created at: /home/runner/work/nrcadams/nrcadams/docs/RSS/KP_Pre-Application.rss 
#> RSS feed created at: /home/runner/work/nrcadams/nrcadams/docs/RSS/Hermes_Part_50.rss 
#> RSS feed created at: /home/runner/work/nrcadams/nrcadams/docs/RSS/Hermes_2_Part_50.rss 
#> RSS feed created at: /home/runner/work/nrcadams/nrcadams/docs/RSS/Hermes_2_Unit_2_Part_50.rss 
#> RSS feed created at: /home/runner/work/nrcadams/nrcadams/docs/RSS/Oklo_Reactor_Pre-Application.rss 
#> RSS feed created at: /home/runner/work/nrcadams/nrcadams/docs/RSS/Oklo_Fuel_Cycle_Pre-Application.rss 
#> RSS feed created at: /home/runner/work/nrcadams/nrcadams/docs/RSS/Aurora_Part_52.rss 
#> RSS feed created at: /home/runner/work/nrcadams/nrcadams/docs/RSS/Aalo-1_Pre-Application.rss 
#> RSS feed created at: /home/runner/work/nrcadams/nrcadams/docs/RSS/RELLIS_ESP_Pre-Application.rss 
#> RSS feed created at: /home/runner/work/nrcadams/nrcadams/docs/RSS/Natura_Pre-Application.rss 
#> RSS feed created at: /home/runner/work/nrcadams/nrcadams/docs/RSS/BWRX-300_Clinch_River_Pre-Application.rss 
#> RSS feed created at: /home/runner/work/nrcadams/nrcadams/docs/RSS/BWRX-300_Clinch_River_Part_50.rss
  
last_week_in_dockets |> 
  nrcadams::write_rss(file = here::here("docs", "RSS", "dockets.rss")) 
#> RSS feed created at: /home/runner/work/nrcadams/nrcadams/docs/RSS/dockets.rss


nrcadams::docket_codex |>
  dplyr::select(Project) |>
  dplyr::mutate(
    `RSS File` = paste0(
      "https://mrdenman-nuclear.github.io/nrcadams/RSS/",
      Project |> stringr::str_replace_all(" ", "_"),
    ".rss"
  )) |>
  dplyr::add_row(
    Project = "All Dockets", 
    `RSS File` = "https://mrdenman-nuclear.github.io/nrcadams/RSS/dockets.rss"
    ) |>
  nrcadams::hyperlink_file_to_name(name_vct = `RSS File`, url_vct = `RSS File`)|>
  DT::datatable(escape = FALSE)
```

## Research and Test Reactors

And if you are more interested in tracking RTRs (no reason in
particular), these RSS files might help.

``` r
last_week_in_RTRs <- nrcadams::RTR_docket_codex |>
  dplyr::pull(DocketNumber) |>
  nrcadams::search_docket(days_back = 14)
#> 
#>  This search returned: 32 files.

if (length(last_week_in_RTRs) != 0) {
  last_week_in_RTRs <- last_week_in_RTRs |>
    dplyr::left_join(nrcadams::RTR_docket_codex) |>
    dplyr::filter(!is.na(Project))

  nrcadams::RTR_docket_codex |>
    dplyr::pull(Project) |>
    purrr::walk(\(.x) {
      last_week_in_RTRs |>
        dplyr::filter(Project == .x) |>
        nrcadams::write_rss(
          file = here::here("docs", "RSS", paste0(
            .x |> stringr::str_replace_all(" ", "_"), ".rss")
            ),
          title = .x 
          )
    })
}
#> Joining with `by = join_by(DocketNumber)`
#> RSS feed created at: /home/runner/work/nrcadams/nrcadams/docs/RSS/Aerotest_Operations_Inc._(R-098).rss 
#> RSS feed created at: /home/runner/work/nrcadams/nrcadams/docs/RSS/Armed_Forces_Radiobiological_Research_Institute_(R-084).rss 
#> RSS feed created at: /home/runner/work/nrcadams/nrcadams/docs/RSS/Dow_Chemical_Company_(R-108).rss 
#> RSS feed created at: /home/runner/work/nrcadams/nrcadams/docs/RSS/General_Electric_Company_(R-033).rss 
#> RSS feed created at: /home/runner/work/nrcadams/nrcadams/docs/RSS/Idaho_State_University_(R-110).rss 
#> RSS feed created at: /home/runner/work/nrcadams/nrcadams/docs/RSS/Kansas_State_University_(R-088).rss 
#> RSS feed created at: /home/runner/work/nrcadams/nrcadams/docs/RSS/Massachusetts_Institute_of_Technology_(R-037).rss 
#> RSS feed created at: /home/runner/work/nrcadams/nrcadams/docs/RSS/National_Institute_of_Standards_and_Technology_(TR-005).rss 
#> RSS feed created at: /home/runner/work/nrcadams/nrcadams/docs/RSS/North_Carolina_State_University_(R-120).rss 
#> RSS feed created at: /home/runner/work/nrcadams/nrcadams/docs/RSS/Oregon_State_University_(R-106).rss 
#> RSS feed created at: /home/runner/work/nrcadams/nrcadams/docs/RSS/Penn_State_University_(R-002).rss 
#> RSS feed created at: /home/runner/work/nrcadams/nrcadams/docs/RSS/Purdue_University_(R-087).rss 
#> RSS feed created at: /home/runner/work/nrcadams/nrcadams/docs/RSS/Reed_College_(R-112).rss 
#> RSS feed created at: /home/runner/work/nrcadams/nrcadams/docs/RSS/Rensselaer_Polytechnic_Institute_(CX-022).rss 
#> RSS feed created at: /home/runner/work/nrcadams/nrcadams/docs/RSS/Rhode_Island_Atomic_Energy_Commission_(R-095).rss 
#> RSS feed created at: /home/runner/work/nrcadams/nrcadams/docs/RSS/Texas_A&M_University_AGN-201_(R-023).rss 
#> RSS feed created at: /home/runner/work/nrcadams/nrcadams/docs/RSS/Texas_A&M_University_TRIGA_(R-083).rss 
#> RSS feed created at: /home/runner/work/nrcadams/nrcadams/docs/RSS/The_Ohio_State_University_(R-075).rss 
#> RSS feed created at: /home/runner/work/nrcadams/nrcadams/docs/RSS/U.S._Geological_Survey_(R-113).rss 
#> RSS feed created at: /home/runner/work/nrcadams/nrcadams/docs/RSS/University_of_California-Davis_(R-130).rss 
#> RSS feed created at: /home/runner/work/nrcadams/nrcadams/docs/RSS/University_of_California-Irvine_(R-116).rss 
#> RSS feed created at: /home/runner/work/nrcadams/nrcadams/docs/RSS/University_of_Florida_(R-056).rss 
#> RSS feed created at: /home/runner/work/nrcadams/nrcadams/docs/RSS/University_of_Maryland_(R-070).rss 
#> RSS feed created at: /home/runner/work/nrcadams/nrcadams/docs/RSS/University_of_Massachusetts_(R-125).rss 
#> RSS feed created at: /home/runner/work/nrcadams/nrcadams/docs/RSS/University_of_Missouri_(R-103).rss 
#> RSS feed created at: /home/runner/work/nrcadams/nrcadams/docs/RSS/University_of_Missouri_(R-079).rss 
#> RSS feed created at: /home/runner/work/nrcadams/nrcadams/docs/RSS/University_of_New_Mexico_(R-102).rss 
#> RSS feed created at: /home/runner/work/nrcadams/nrcadams/docs/RSS/University_of_Texas_(R-129).rss 
#> RSS feed created at: /home/runner/work/nrcadams/nrcadams/docs/RSS/University_of_Utah_(R-126).rss 
#> RSS feed created at: /home/runner/work/nrcadams/nrcadams/docs/RSS/University_of_Wisconsin_(R-074).rss 
#> RSS feed created at: /home/runner/work/nrcadams/nrcadams/docs/RSS/Washington_State_University_(R-076).rss

nrcadams::RTR_docket_codex |>
  dplyr::select(Project) |>
  dplyr::mutate(`RSS File` = paste0(
    "https://mrdenman-nuclear.github.io/nrcadams/RSS/",
    Project |> stringr::str_replace_all(" ", "_"),
    ".rss"
  )) |>
  dplyr::add_row(
    Project = "All Dockets", 
    `RSS File` = "https://mrdenman-nuclear.github.io/nrcadams/RSS/dockets-RTR.rss"
    ) |>
  nrcadams::hyperlink_file_to_name(name_vct = `RSS File`, url_vct = `RSS File`)|>
  DT::datatable(escape = FALSE)
```

## ACRS

``` r
ACRS <- nrcadams::search_values(
  days_back = 30,
  author_affiliation = "NRC/ACRS",
  results_tag = "ACRS"
  )

if (length(ACRS) != 0) {
  ACRS |>
    nrcadams::write_rss(
      file = here::here("docs", "RSS", paste0(
        "ACRS", ".rss")
      ),
      title = "ACRS"
    )
}
#> RSS feed created at: /home/runner/work/nrcadams/nrcadams/docs/RSS/ACRS.rss

tibble::tibble(Project = "ACRS") |>
  dplyr::mutate(`RSS File` = paste0(
    "https://mrdenman-nuclear.github.io/nrcadams/RSS/",
    Project,
    ".rss"
  )) |>
  nrcadams::hyperlink_file_to_name(name_vct = `RSS File`, url_vct = `RSS File`)|>
  DT::datatable(escape = FALSE)
```

## Undocketed Company Mentions (Experimental)

Do you want to know who else is talking about a company outside of a
docket? This list of RSS files searches for a company name that is not
also tagged with a docket number associated with that company.

``` r

toobigtotrack <- c("Holtec", "GE", "Westinghouse")

date <- nrcadams:::process_dates(days_back = 14)

burning_ears <- nrcadams::docket_codex |>
  dplyr::filter(!Company %in% toobigtotrack) |>
  dplyr::distinct(Company) |>
  dplyr::pull(Company) |>
  purrr::map_dfr(\(.x) {
    antidocket <- nrcadams::docket_codex |>
      dplyr::filter(Company  == .x) |>
      dplyr::mutate(DocketNumber = -DocketNumber) |>
      dplyr::pull(DocketNumber)

    nrcadams::search_public_ADAMS(
      search_term = paste0("'", .x, "'"),
      DocketNumber = antidocket,
      start_date = date$start,
      results_tag = .x
    )
  })
#> Warning in nrcadams::search_public_ADAMS(search_term = paste0("'", .x, "'"), :
#> Negative docket numbers detected. These will be used to excludedocuments from
#> the search results.
#> Warning in nrcadams::search_public_ADAMS(search_term = paste0("'", .x, "'"), :
#> Negative docket numbers detected. These will be used to excludedocuments from
#> the search results.
#> Warning in nrcadams::search_public_ADAMS(search_term = paste0("'", .x, "'"), :
#> Negative docket numbers detected. These will be used to excludedocuments from
#> the search results.
#> Warning: There was 1 warning in `dplyr::mutate()`.
#> i In argument: `DocketNumber = as.double(DocketNumber)`.
#> Caused by warning:
#> ! NAs introduced by coercion
#> Warning in nrcadams::search_public_ADAMS(search_term = paste0("'", .x, "'"), :
#> Negative docket numbers detected. These will be used to excludedocuments from
#> the search results.
#> Warning in nrcadams::search_public_ADAMS(search_term = paste0("'", .x, "'"), :
#> Negative docket numbers detected. These will be used to excludedocuments from
#> the search results.
#> Warning: Unknown or uninitialised column: `DocumentTitle`.
#> Warning in nrcadams:::decode_resp(resp): 
#> The search return no results.
#> Warning in nrcadams::search_public_ADAMS(search_term = paste0("'", .x, "'"), :
#> Negative docket numbers detected. These will be used to excludedocuments from
#> the search results.
#> Warning in nrcadams::search_public_ADAMS(search_term = paste0("'", .x, "'"), :
#> Negative docket numbers detected. These will be used to excludedocuments from
#> the search results.
#> Warning: There was 1 warning in `dplyr::mutate()`.
#> i In argument: `DocketNumber = as.double(DocketNumber)`.
#> Caused by warning:
#> ! NAs introduced by coercion
#> Warning in nrcadams::search_public_ADAMS(search_term = paste0("'", .x, "'"), :
#> Negative docket numbers detected. These will be used to excludedocuments from
#> the search results.
#> Warning in nrcadams::search_public_ADAMS(search_term = paste0("'", .x, "'"), :
#> Negative docket numbers detected. These will be used to excludedocuments from
#> the search results.
#> Warning in nrcadams::search_public_ADAMS(search_term = paste0("'", .x, "'"), :
#> Negative docket numbers detected. These will be used to excludedocuments from
#> the search results.
#> Warning in nrcadams::search_public_ADAMS(search_term = paste0("'", .x, "'"), :
#> Negative docket numbers detected. These will be used to excludedocuments from
#> the search results.
#> Warning in nrcadams::search_public_ADAMS(search_term = paste0("'", .x, "'"), :
#> Negative docket numbers detected. These will be used to excludedocuments from
#> the search results.
#> Warning in nrcadams::search_public_ADAMS(search_term = paste0("'", .x, "'"), :
#> Negative docket numbers detected. These will be used to excludedocuments from
#> the search results.

nrcadams::docket_codex |>
  dplyr::filter(!Company %in% toobigtotrack) |>
  dplyr::distinct(Company) |>
  dplyr::pull(Company) |>
  purrr::walk(\(.x) {
    burning_ears |>
      dplyr::filter(tag == .x) |>
      nrcadams::write_rss(
        file = here::here("docs", "RSS", paste0(
          .x |>
            stringr::str_replace_all(" ", "_") |>
            stringr::str_replace_all("/", "_"),
          ".rss"
        )),
        title = .x
      )
  })
#> RSS feed created at: /home/runner/work/nrcadams/nrcadams/docs/RSS/ACU.rss 
#> RSS feed created at: /home/runner/work/nrcadams/nrcadams/docs/RSS/SHINE_Medical_Technologies.rss 
#> RSS feed created at: /home/runner/work/nrcadams/nrcadams/docs/RSS/X-Energy.rss 
#> RSS feed created at: /home/runner/work/nrcadams/nrcadams/docs/RSS/TerraPower.rss 
#> RSS feed created at: /home/runner/work/nrcadams/nrcadams/docs/RSS/UCUI.rss 
#> RSS feed created at: /home/runner/work/nrcadams/nrcadams/docs/RSS/Terrestrial_Energy.rss 
#> RSS feed created at: /home/runner/work/nrcadams/nrcadams/docs/RSS/NuScale.rss 
#> RSS feed created at: /home/runner/work/nrcadams/nrcadams/docs/RSS/Kairos_Power.rss 
#> RSS feed created at: /home/runner/work/nrcadams/nrcadams/docs/RSS/Oklo.rss 
#> RSS feed created at: /home/runner/work/nrcadams/nrcadams/docs/RSS/Aalo.rss 
#> RSS feed created at: /home/runner/work/nrcadams/nrcadams/docs/RSS/TAMU.rss 
#> RSS feed created at: /home/runner/work/nrcadams/nrcadams/docs/RSS/Natura_Resources.rss 
#> RSS feed created at: /home/runner/work/nrcadams/nrcadams/docs/RSS/TVA.rss


nrcadams::docket_codex |>
  dplyr::filter(!Company %in% toobigtotrack) |>
  dplyr::distinct(Company) |>
  dplyr::mutate(`RSS File` = paste0(
    "https://mrdenman-nuclear.github.io/nrcadams/RSS/",
    Company |> stringr::str_replace_all(" ", "_"),
    ".rss"
  )) |>
  nrcadams::hyperlink_file_to_name(
    name_vct = `RSS File`,
    url_vct = `RSS File`
  )|>
  DT::datatable(escape = FALSE)
```

## NRC Source Term Codes

    #> Warning: Unknown or uninitialised column: `DocumentTitle`.
    #> Warning in nrcadams:::decode_resp(resp): 
    #> The search return no results.
    #> Warning: Unknown or uninitialised column: `count`.
    #> Warning in max(current_tbl$count): no non-missing arguments to max; returning
    #> -Inf
    #> Warning: Unknown or uninitialised column: `ML Number`.
    #> Warning: Unknown or uninitialised column: `DocumentTitle`.
    #> Warning in nrcadams:::decode_resp(resp): 
    #> The search return no results.
    #> Warning: Unknown or uninitialised column: `count`.
    #> Warning in max(current_tbl$count): no non-missing arguments to max; returning
    #> -Inf
    #> Warning: Unknown or uninitialised column: `ML Number`.
    #> Warning: Unknown or uninitialised column: `DocumentTitle`.
    #> Warning in nrcadams:::decode_resp(resp): 
    #> The search return no results.
    #> Warning: Unknown or uninitialised column: `count`.
    #> Warning in max(current_tbl$count): no non-missing arguments to max; returning
    #> -Inf
    #> Warning: Unknown or uninitialised column: `ML Number`.
    #> Warning: Unknown or uninitialised column: `DocumentTitle`.
    #> Warning in nrcadams:::decode_resp(resp): 
    #> The search return no results.
    #> Warning: Unknown or uninitialised column: `count`.
    #> Warning in max(current_tbl$count): no non-missing arguments to max; returning
    #> -Inf
    #> Warning: Unknown or uninitialised column: `ML Number`.
    #> Joining with `by = join_by(DocketNumber, `ML Number`, Title, `Document Date`,
    #> `Publish Date`, Type, Affiliation, URL, count, tag)`
    #> Joining with `by = join_by(DocketNumber, `ML Number`, Title, `Document Date`,
    #> `Publish Date`, Type, Affiliation, URL, count, tag)`

``` r
code_search |>
  dplyr::mutate(
    `RSS File` = paste0(
      "https://mrdenman-nuclear.github.io/nrcadams/RSS/",
      tag |> stringr::str_replace_all(" ", "_"),
      ".rss"
    )
  ) |>
  dplyr::add_row(
    tag = "All Codes",
    search = "Or Gate",
    `RSS File` = "https://mrdenman-nuclear.github.io/nrcadams/RSS/SourceTermCodes.rss"
    ) |>
  nrcadams::hyperlink_file_to_name(name_vct = `RSS File`, url_vct = `RSS File`) |>
  DT::datatable(escape = FALSE)
```
