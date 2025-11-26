# RSS Files

This page is updated Monday through Friday, hourly between 9AM ET and 5
PM ET. It presents RSS files for the various dockets tracked by the
`nrcadams` package. The last update was at 2025-11-26 15:19:59.337128
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
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search_any:!(!(DocketNumber,eq,'99902088',''),!(DocketNumber,eq,'05000610',''),!(DocketNumber,eq,'05000608',''),!(DocketNumber,eq,'99902115',''),!(DocketNumber,eq,'99902071',''),!(DocketNumber,eq,'07007027',''),!(DocketNumber,eq,'99902117',''),!(DocketNumber,eq,'99902111',''),!(DocketNumber,eq,'99902100',''),!(DocketNumber,eq,'05000613',''),!(DocketNumber,eq,'99902150',''),!(DocketNumber,eq,'99902094',''),!(DocketNumber,eq,'99902079',''),!(DocketNumber,eq,'99902076',''),!(DocketNumber,eq,'99900003',''),!(DocketNumber,eq,'99902049',''),!(DocketNumber,eq,'05200048',''),!(DocketNumber,eq,'99902078',''),!(DocketNumber,eq,'05200050',''),!(DocketNumber,eq,'99902052',''),!(DocketNumber,eq,'99902069',''),!(DocketNumber,eq,'05007513',''),!(DocketNumber,eq,'05000611',''),!(DocketNumber,eq,'05000612',''),!(DocketNumber,eq,'99902095',''),!(DocketNumber,eq,'99902101',''),!(DocketNumber,eq,'05200049',''),!(DocketNumber,eq,'99902128',''),!(DocketNumber,eq,'99902136',''),!(DocketNumber,eq,'99902122',''),!(DocketNumber,eq,'99902056',''),!(DocketNumber,eq,'05000615','')),properties_search_all:!(!(PublishDatePARS,gt,'11/12/2025',''))))&qn=New&tab=advanced-search-pars&z=0 
#> : 0.361 sec elapsed
#> 
#>  This search returned: 64 files.
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
#> RSS feed created at: /Users/runner/work/nrcadams/nrcadams/docs/RSS/MSRR_Pre-Application.rss 
#> RSS feed created at: /Users/runner/work/nrcadams/nrcadams/docs/RSS/MSRR_Part_50.rss 
#> RSS feed created at: /Users/runner/work/nrcadams/nrcadams/docs/RSS/Shine_Part_50.rss 
#> RSS feed created at: /Users/runner/work/nrcadams/nrcadams/docs/RSS/Shine_Recycling_Pre-Application.rss
#> Warning in as.POSIXlt.POSIXct(x, tz): unknown timezone 'EDT'
#> RSS feed created at: /Users/runner/work/nrcadams/nrcadams/docs/RSS/Xe-100_Pre-Application.rss
#> Warning in as.POSIXlt.POSIXct(x, tz): unknown timezone 'EDT'
#> RSS feed created at: /Users/runner/work/nrcadams/nrcadams/docs/RSS/TRISO-X_Fab._Part_70.rss 
#> RSS feed created at: /Users/runner/work/nrcadams/nrcadams/docs/RSS/Long_Mott_Pre-Application.rss
#> Warning in as.POSIXlt.POSIXct(x, tz): unknown timezone 'EDT'
#> RSS feed created at: /Users/runner/work/nrcadams/nrcadams/docs/RSS/AP300.rss
#> Warning in as.POSIXlt.POSIXct(x, tz): unknown timezone 'EDT'
#> RSS feed created at: /Users/runner/work/nrcadams/nrcadams/docs/RSS/Natrium_Pre-Application.rss
#> Warning in as.POSIXlt.POSIXct(x, tz): unknown timezone 'EDT'
#> RSS feed created at: /Users/runner/work/nrcadams/nrcadams/docs/RSS/Natrium_Part_50.rss 
#> RSS feed created at: /Users/runner/work/nrcadams/nrcadams/docs/RSS/USO_SFR_Owner_Pre-Applicatoin.rss 
#> RSS feed created at: /Users/runner/work/nrcadams/nrcadams/docs/RSS/UIUC_HTGR_Pre-Application.rss 
#> RSS feed created at: /Users/runner/work/nrcadams/nrcadams/docs/RSS/eVinci_Pre-Application.rss
#> Warning in as.POSIXlt.POSIXct(x, tz): unknown timezone 'EDT'
#> RSS feed created at: /Users/runner/work/nrcadams/nrcadams/docs/RSS/IMSR_Pre-Application.rss
#> Warning in as.POSIXlt.POSIXct(x, tz): unknown timezone 'EDT'
#> RSS feed created at: /Users/runner/work/nrcadams/nrcadams/docs/RSS/BWRX-300_Pre-Application.rss
#> Warning in as.POSIXlt.POSIXct(x, tz): unknown timezone 'EDT'
#> RSS feed created at: /Users/runner/work/nrcadams/nrcadams/docs/RSS/SMR-300_Pre-Application.rss 
#> RSS feed created at: /Users/runner/work/nrcadams/nrcadams/docs/RSS/NuScale_50_MWe_Part_52.rss 
#> RSS feed created at: /Users/runner/work/nrcadams/nrcadams/docs/RSS/NuScale_77_MWe_Pre-Application.rss 
#> RSS feed created at: /Users/runner/work/nrcadams/nrcadams/docs/RSS/NuScale_77_MWe_Part_52.rss 
#> RSS feed created at: /Users/runner/work/nrcadams/nrcadams/docs/RSS/Carbon_Free_Power_Project.rss
#> Warning in as.POSIXlt.POSIXct(x, tz): unknown timezone 'EDT'
#> RSS feed created at: /Users/runner/work/nrcadams/nrcadams/docs/RSS/KP_Pre-Application.rss
#> Warning in as.POSIXlt.POSIXct(x, tz): unknown timezone 'EDT'
#> RSS feed created at: /Users/runner/work/nrcadams/nrcadams/docs/RSS/Hermes_Part_50.rss
#> Warning in as.POSIXlt.POSIXct(x, tz): unknown timezone 'EDT'
#> RSS feed created at: /Users/runner/work/nrcadams/nrcadams/docs/RSS/Hermes_2_Part_50.rss
#> Warning in as.POSIXlt.POSIXct(x, tz): unknown timezone 'EDT'
#> RSS feed created at: /Users/runner/work/nrcadams/nrcadams/docs/RSS/Hermes_2_Unit_2_Part_50.rss
#> Warning in as.POSIXlt.POSIXct(x, tz): unknown timezone 'EDT'
#> RSS feed created at: /Users/runner/work/nrcadams/nrcadams/docs/RSS/Oklo_Reactor_Pre-Application.rss 
#> RSS feed created at: /Users/runner/work/nrcadams/nrcadams/docs/RSS/Oklo_Fuel_Cycle_Pre-Application.rss 
#> RSS feed created at: /Users/runner/work/nrcadams/nrcadams/docs/RSS/Aurora_Part_52.rss
#> Warning in as.POSIXlt.POSIXct(x, tz): unknown timezone 'EDT'
#> RSS feed created at: /Users/runner/work/nrcadams/nrcadams/docs/RSS/Aalo-1_Pre-Application.rss 
#> RSS feed created at: /Users/runner/work/nrcadams/nrcadams/docs/RSS/RELLIS_ESP_Pre-Application.rss 
#> RSS feed created at: /Users/runner/work/nrcadams/nrcadams/docs/RSS/Natura_Pre-Application.rss
#> Warning in as.POSIXlt.POSIXct(x, tz): unknown timezone 'EDT'
#> RSS feed created at: /Users/runner/work/nrcadams/nrcadams/docs/RSS/BWRX-300_Clinch_River_Pre-Application.rss
#> Warning in as.POSIXlt.POSIXct(x, tz): unknown timezone 'EDT'
#> RSS feed created at: /Users/runner/work/nrcadams/nrcadams/docs/RSS/BWRX-300_Clinch_River_Part_50.rss
  
last_week_in_dockets |> nrcadams::write_rss(file = here::here("docs", "RSS", "dockets.rss")) 
#> Warning in as.POSIXlt.POSIXct(x, tz): unknown timezone 'EDT'
#> RSS feed created at: /Users/runner/work/nrcadams/nrcadams/docs/RSS/dockets.rss


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
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search_any:!(!(DocketNumber,eq,'05000228',''),!(DocketNumber,eq,'05000170',''),!(DocketNumber,eq,'05000264',''),!(DocketNumber,eq,'05000073',''),!(DocketNumber,eq,'05000284',''),!(DocketNumber,eq,'05000188',''),!(DocketNumber,eq,'05000020',''),!(DocketNumber,eq,'05000184',''),!(DocketNumber,eq,'05000297',''),!(DocketNumber,eq,'05000243',''),!(DocketNumber,eq,'05000005',''),!(DocketNumber,eq,'05000182',''),!(DocketNumber,eq,'05000288',''),!(DocketNumber,eq,'05000225',''),!(DocketNumber,eq,'05000193',''),!(DocketNumber,eq,'05000059',''),!(DocketNumber,eq,'05000128',''),!(DocketNumber,eq,'05000150',''),!(DocketNumber,eq,'05000274',''),!(DocketNumber,eq,'05000607',''),!(DocketNumber,eq,'05000326',''),!(DocketNumber,eq,'05000083',''),!(DocketNumber,eq,'05000166',''),!(DocketNumber,eq,'05000223',''),!(DocketNumber,eq,'05000186',''),!(DocketNumber,eq,'05000123',''),!(DocketNumber,eq,'05000252',''),!(DocketNumber,eq,'05000602',''),!(DocketNumber,eq,'05000407',''),!(DocketNumber,eq,'05000156',''),!(DocketNumber,eq,'05000027','')),properties_search_all:!(!(PublishDatePARS,gt,'11/12/2025',''))))&qn=New&tab=advanced-search-pars&z=0 
#> : 0.193 sec elapsed
#> 
#>  This search returned: 13 files.

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
#> RSS feed created at: /Users/runner/work/nrcadams/nrcadams/docs/RSS/Aerotest_Operations_Inc._(R-098).rss 
#> RSS feed created at: /Users/runner/work/nrcadams/nrcadams/docs/RSS/Armed_Forces_Radiobiological_Research_Institute_(R-084).rss 
#> RSS feed created at: /Users/runner/work/nrcadams/nrcadams/docs/RSS/Dow_Chemical_Company_(R-108).rss
#> Warning in as.POSIXlt.POSIXct(x, tz): unknown timezone 'EDT'
#> RSS feed created at: /Users/runner/work/nrcadams/nrcadams/docs/RSS/General_Electric_Company_(R-033).rss
#> Warning in as.POSIXlt.POSIXct(x, tz): unknown timezone 'EDT'
#> RSS feed created at: /Users/runner/work/nrcadams/nrcadams/docs/RSS/Idaho_State_University_(R-110).rss 
#> RSS feed created at: /Users/runner/work/nrcadams/nrcadams/docs/RSS/Kansas_State_University_(R-088).rss 
#> RSS feed created at: /Users/runner/work/nrcadams/nrcadams/docs/RSS/Massachusetts_Institute_of_Technology_(R-037).rss 
#> RSS feed created at: /Users/runner/work/nrcadams/nrcadams/docs/RSS/National_Institute_of_Standards_and_Technology_(TR-005).rss 
#> RSS feed created at: /Users/runner/work/nrcadams/nrcadams/docs/RSS/North_Carolina_State_University_(R-120).rss 
#> RSS feed created at: /Users/runner/work/nrcadams/nrcadams/docs/RSS/Oregon_State_University_(R-106).rss
#> Warning in as.POSIXlt.POSIXct(x, tz): unknown timezone 'EDT'
#> RSS feed created at: /Users/runner/work/nrcadams/nrcadams/docs/RSS/Penn_State_University_(R-002).rss 
#> RSS feed created at: /Users/runner/work/nrcadams/nrcadams/docs/RSS/Purdue_University_(R-087).rss 
#> RSS feed created at: /Users/runner/work/nrcadams/nrcadams/docs/RSS/Reed_College_(R-112).rss 
#> RSS feed created at: /Users/runner/work/nrcadams/nrcadams/docs/RSS/Rensselaer_Polytechnic_Institute_(CX-022).rss 
#> RSS feed created at: /Users/runner/work/nrcadams/nrcadams/docs/RSS/Rhode_Island_Atomic_Energy_Commission_(R-095).rss 
#> RSS feed created at: /Users/runner/work/nrcadams/nrcadams/docs/RSS/Texas_A&M_University_AGN-201_(R-023).rss 
#> RSS feed created at: /Users/runner/work/nrcadams/nrcadams/docs/RSS/Texas_A&M_University_TRIGA_(R-083).rss 
#> RSS feed created at: /Users/runner/work/nrcadams/nrcadams/docs/RSS/The_Ohio_State_University_(R-075).rss 
#> RSS feed created at: /Users/runner/work/nrcadams/nrcadams/docs/RSS/U.S._Geological_Survey_(R-113).rss 
#> RSS feed created at: /Users/runner/work/nrcadams/nrcadams/docs/RSS/University_of_California-Davis_(R-130).rss 
#> RSS feed created at: /Users/runner/work/nrcadams/nrcadams/docs/RSS/University_of_California-Irvine_(R-116).rss 
#> RSS feed created at: /Users/runner/work/nrcadams/nrcadams/docs/RSS/University_of_Florida_(R-056).rss
#> Warning in as.POSIXlt.POSIXct(x, tz): unknown timezone 'EDT'
#> RSS feed created at: /Users/runner/work/nrcadams/nrcadams/docs/RSS/University_of_Maryland_(R-070).rss 
#> RSS feed created at: /Users/runner/work/nrcadams/nrcadams/docs/RSS/University_of_Massachusetts_(R-125).rss
#> Warning in as.POSIXlt.POSIXct(x, tz): unknown timezone 'EDT'
#> RSS feed created at: /Users/runner/work/nrcadams/nrcadams/docs/RSS/University_of_Missouri_(R-103).rss 
#> RSS feed created at: /Users/runner/work/nrcadams/nrcadams/docs/RSS/University_of_Missouri_(R-079).rss
#> Warning in as.POSIXlt.POSIXct(x, tz): unknown timezone 'EDT'
#> RSS feed created at: /Users/runner/work/nrcadams/nrcadams/docs/RSS/University_of_New_Mexico_(R-102).rss 
#> RSS feed created at: /Users/runner/work/nrcadams/nrcadams/docs/RSS/University_of_Texas_(R-129).rss 
#> RSS feed created at: /Users/runner/work/nrcadams/nrcadams/docs/RSS/University_of_Utah_(R-126).rss 
#> RSS feed created at: /Users/runner/work/nrcadams/nrcadams/docs/RSS/University_of_Wisconsin_(R-074).rss 
#> RSS feed created at: /Users/runner/work/nrcadams/nrcadams/docs/RSS/Washington_State_University_(R-076).rss

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
ACRS <- nrcadams::search_ACRS(days_back = 14)
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search_all:!(!(AuthorAffiliation,starts,NRC/ACRS,''),!(PublishDatePARS,gt,'11/12/2025',''))))&qn=New&tab=advanced-search-pars&z=0 
#> : 0.085 sec elapsed
#> 
#>  This search returned: 11 files.

if (length(ACRS) != 0) {
  ACRS |>
    nrcadams::write_rss(
      file = here::here("docs", "RSS", paste0(
        "ACRS", ".rss")
        ),
      title = "ACRS"
      )  
}
#> Warning in as.POSIXlt.POSIXct(x, tz): unknown timezone 'EDT'
#> RSS feed created at: /Users/runner/work/nrcadams/nrcadams/docs/RSS/ACRS.rss

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

burning_ears = nrcadams::docket_codex |>
  dplyr::filter(!Company %in% toobigtotrack) |>
  dplyr::distinct(Company) |>
  dplyr::pull(Company) |>
  purrr::map_dfr(\(.x) {
    nrcadams::search_undocketed(.x, days_back = 14) 
    }
  )
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search:!(!(DocketNumber,not,'99902088',''),!(DocketNumber,not,'05000610',''),!(PublishDatePARS,gt,'11/12/2025','')),single_content_search:'ACU'))&qn=New&tab=content-search-pars&z=0 
#> : 0.136 sec elapsed
#> 
#>  This search returned: 0 files.
#> Warning in nrcadams::search_undocketed(.x, days_back = 14): 
#> The search return no results.
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search:!(!(DocketNumber,not,'05000608',''),!(DocketNumber,not,'99902115',''),!(PublishDatePARS,gt,'11/12/2025','')),single_content_search:'SHINE+Medical+Technologies'))&qn=New&tab=content-search-pars&z=0 
#> : 0.168 sec elapsed
#> 
#>  This search returned: 2 files.
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search:!(!(DocketNumber,not,'99902071',''),!(DocketNumber,not,'07007027',''),!(DocketNumber,not,'99902117',''),!(PublishDatePARS,gt,'11/12/2025','')),single_content_search:'X-Energy'))&qn=New&tab=content-search-pars&z=0 
#> : 0.159 sec elapsed
#> 
#>  This search returned: 7 files.
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search:!(!(DocketNumber,not,'99902100',''),!(DocketNumber,not,'05000613',''),!(DocketNumber,not,'99902150',''),!(PublishDatePARS,gt,'11/12/2025','')),single_content_search:'TerraPower'))&qn=New&tab=content-search-pars&z=0 
#> : 0.17 sec elapsed
#> 
#>  This search returned: 4 files.
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search:!(!(DocketNumber,not,'99902094',''),!(PublishDatePARS,gt,'11/12/2025','')),single_content_search:'UCUI'))&qn=New&tab=content-search-pars&z=0 
#> : 0.136 sec elapsed
#> 
#>  This search returned: 0 files.
#> Warning in nrcadams::search_undocketed(.x, days_back = 14): 
#> The search return no results.
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search:!(!(DocketNumber,not,'99902076',''),!(PublishDatePARS,gt,'11/12/2025','')),single_content_search:'Terrestrial+Energy'))&qn=New&tab=content-search-pars&z=0 
#> : 0.146 sec elapsed
#> 
#>  This search returned: 15 files.
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search:!(!(DocketNumber,not,'05200048',''),!(DocketNumber,not,'99902078',''),!(DocketNumber,not,'05200050',''),!(DocketNumber,not,'99902052',''),!(PublishDatePARS,gt,'11/12/2025','')),single_content_search:'NuScale'))&qn=New&tab=content-search-pars&z=0 
#> : 0.167 sec elapsed
#> 
#>  This search returned: 5 files.
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search:!(!(DocketNumber,not,'99902069',''),!(DocketNumber,not,'05007513',''),!(DocketNumber,not,'05000611',''),!(DocketNumber,not,'05000612',''),!(PublishDatePARS,gt,'11/12/2025','')),single_content_search:'Kairos+Power'))&qn=New&tab=content-search-pars&z=0 
#> : 0.165 sec elapsed
#> 
#>  This search returned: 6 files.
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search:!(!(DocketNumber,not,'99902095',''),!(DocketNumber,not,'99902101',''),!(DocketNumber,not,'05200049',''),!(PublishDatePARS,gt,'11/12/2025','')),single_content_search:'Oklo'))&qn=New&tab=content-search-pars&z=0 
#> : 0.18 sec elapsed
#> 
#>  This search returned: 8 files.
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search:!(!(DocketNumber,not,'99902128',''),!(PublishDatePARS,gt,'11/12/2025','')),single_content_search:'Aalo'))&qn=New&tab=content-search-pars&z=0 
#> : 0.101 sec elapsed
#> 
#>  This search returned: 0 files.
#> Warning in nrcadams::search_undocketed(.x, days_back = 14): 
#> The search return no results.
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search:!(!(DocketNumber,not,'99902136',''),!(PublishDatePARS,gt,'11/12/2025','')),single_content_search:'TAMU'))&qn=New&tab=content-search-pars&z=0 
#> : 0.095 sec elapsed
#> 
#>  This search returned: 0 files.
#> Warning in nrcadams::search_undocketed(.x, days_back = 14): 
#> The search return no results.
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search:!(!(DocketNumber,not,'99902122',''),!(PublishDatePARS,gt,'11/12/2025','')),single_content_search:'Natura+Resources'))&qn=New&tab=content-search-pars&z=0 
#> : 0.104 sec elapsed
#> 
#>  This search returned: 0 files.
#> Warning in nrcadams::search_undocketed(.x, days_back = 14): 
#> The search return no results.
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search:!(!(DocketNumber,not,'99902056',''),!(DocketNumber,not,'05000615',''),!(PublishDatePARS,gt,'11/12/2025','')),single_content_search:'TVA'))&qn=New&tab=content-search-pars&z=0 
#> : 0.184 sec elapsed
#> 
#>  This search returned: 10 files.

nrcadams::docket_codex |>
  dplyr::filter(!Company %in% toobigtotrack) |>
  dplyr::distinct(Company) |>
  dplyr::pull(Company) |>
  purrr::walk(\(.x) {
    burning_ears |>
      dplyr::filter(Tag == .x) |>
      nrcadams::write_rss(
        file = here::here("docs", "RSS", paste0(
          .x |> stringr::str_replace_all(" ", "_")|> stringr::str_replace_all("/", "_"), ".rss")
          ),
        title = .x 
        )
  })
#> RSS feed created at: /Users/runner/work/nrcadams/nrcadams/docs/RSS/ACU.rss
#> Warning in as.POSIXlt.POSIXct(x, tz): unknown timezone 'EDT'
#> RSS feed created at: /Users/runner/work/nrcadams/nrcadams/docs/RSS/SHINE_Medical_Technologies.rss
#> Warning in as.POSIXlt.POSIXct(x, tz): unknown timezone 'EDT'
#> RSS feed created at: /Users/runner/work/nrcadams/nrcadams/docs/RSS/X-Energy.rss
#> Warning in as.POSIXlt.POSIXct(x, tz): unknown timezone 'EDT'
#> RSS feed created at: /Users/runner/work/nrcadams/nrcadams/docs/RSS/TerraPower.rss 
#> RSS feed created at: /Users/runner/work/nrcadams/nrcadams/docs/RSS/UCUI.rss
#> Warning in as.POSIXlt.POSIXct(x, tz): unknown timezone 'EDT'
#> RSS feed created at: /Users/runner/work/nrcadams/nrcadams/docs/RSS/Terrestrial_Energy.rss
#> Warning in as.POSIXlt.POSIXct(x, tz): unknown timezone 'EDT'
#> RSS feed created at: /Users/runner/work/nrcadams/nrcadams/docs/RSS/NuScale.rss
#> Warning in as.POSIXlt.POSIXct(x, tz): unknown timezone 'EDT'
#> RSS feed created at: /Users/runner/work/nrcadams/nrcadams/docs/RSS/Kairos_Power.rss
#> Warning in as.POSIXlt.POSIXct(x, tz): unknown timezone 'EDT'
#> RSS feed created at: /Users/runner/work/nrcadams/nrcadams/docs/RSS/Oklo.rss 
#> RSS feed created at: /Users/runner/work/nrcadams/nrcadams/docs/RSS/Aalo.rss 
#> RSS feed created at: /Users/runner/work/nrcadams/nrcadams/docs/RSS/TAMU.rss 
#> RSS feed created at: /Users/runner/work/nrcadams/nrcadams/docs/RSS/Natura_Resources.rss
#> Warning in as.POSIXlt.POSIXct(x, tz): unknown timezone 'EDT'
#> RSS feed created at: /Users/runner/work/nrcadams/nrcadams/docs/RSS/TVA.rss


nrcadams::docket_codex |>
  dplyr::filter(!Company %in% toobigtotrack) |>
  dplyr::distinct(Company) |>
  dplyr::mutate(`RSS File` = paste0(
    "https://mrdenman-nuclear.github.io/nrcadams/RSS/",
    Company |> stringr::str_replace_all(" ", "_"),
    ".rss"
  )) |>
  nrcadams::hyperlink_file_to_name(name_vct = `RSS File`, url_vct = `RSS File`)|>
  DT::datatable(escape = FALSE)
```

## NRC Source Term Codes

    #> 
    #>  This search returned: 3 files.
    #> 
    #>  This search returned: 2 files.
    #> 
    #>  This search returned: 2 files.
    #> 
    #>  This search returned: 0 files.
    #> Warning in nrcadams::search_advanced(search_field = paste0("single_content_search:", : 
    #> The search return no results.
    #> 
    #>  This search returned: 5 files.
    #> 
    #>  This search returned: 0 files.
    #> Warning in nrcadams::search_advanced(search_field = paste0("single_content_search:", : 
    #> The search return no results.
    #> 
    #>  This search returned: 0 files.
    #> Warning in nrcadams::search_advanced(search_field = paste0("single_content_search:", : 
    #> The search return no results.
    #> Joining with `by = join_by(Title, `Document Date`, `Publish Date`, Type,
    #> Affiliation, URL, `ML Number`, Tag)`
    #> Joining with `by = join_by(Title, `Document Date`, `Publish Date`, Type,
    #> Affiliation, URL, `ML Number`, Tag)`
    #> Joining with `by = join_by(Title, `Document Date`, `Publish Date`, Type,
    #> Affiliation, URL, `ML Number`, Tag)`
    #> Warning in as.POSIXlt.POSIXct(x, tz): unknown timezone 'EDT'
    #> Warning in as.POSIXlt.POSIXct(x, tz): unknown timezone 'EDT'
    #> Warning in as.POSIXlt.POSIXct(x, tz): unknown timezone 'EDT'
    #> Warning in as.POSIXlt.POSIXct(x, tz): unknown timezone 'EDT'
    #> Warning in as.POSIXlt.POSIXct(x, tz): unknown timezone 'EDT'
    #> 
    #>  This search returned: 1 files.
    #> Warning in as.POSIXlt.POSIXct(x, tz): unknown timezone 'EDT'
    #> 
    #>  This search returned: 1 files.
    #> Warning in as.POSIXlt.POSIXct(x, tz): unknown timezone 'EDT'

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
