# Docket Analytics and Reports

This page provides preliminary data analytics on various advanced
reactor dockets. Note that ADAMS assigned multiple docket numbers to
some reports. The results presented here should be interpreted with
these limitations.

This page is updated Monday through Friday, hourly between 9AM ET and 5
PM ET. The last update was at 2025-12-04 16:16:24.771602 ET.

## Pulling Advanced Reactor Docket Files

Because the entire docket is being pulled for each project, the 1,000
document per search limit would be exceeded if all the dockets were
pulled in one request. To reduce the impact of this limit, the
[`nrcadams::search_long_docket`](https://mrdenman-nuclear.github.io/nrcadams/reference/search_long_docket.md)
is used to break the one long search into many smaller searches.

``` r
combined_dockets = nrcadams::docket_codex |>
  dplyr::pull(DocketNumber) |>
  nrcadams::search_long_docket(number_of_intervals = 75) |>
  nrcadams::hyperlink_file_to_name() |>
  dplyr::left_join(nrcadams::docket_codex) |>
  dplyr::select(-c(Company, DocketNumber, `ML Number`)) |>
  dplyr::filter(!is.na(Project)) |>
  dplyr::mutate(Project = stringr::str_replace(Project, "Application", "App."))
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search_any:!(!(DocketNumber,eq,'99902088',''),!(DocketNumber,eq,'05000610',''),!(DocketNumber,eq,'05000608',''),!(DocketNumber,eq,'99902115',''),!(DocketNumber,eq,'99902071',''),!(DocketNumber,eq,'07007027',''),!(DocketNumber,eq,'99902117',''),!(DocketNumber,eq,'99902111',''),!(DocketNumber,eq,'99902100',''),!(DocketNumber,eq,'05000613',''),!(DocketNumber,eq,'99902150',''),!(DocketNumber,eq,'99902094',''),!(DocketNumber,eq,'99902079',''),!(DocketNumber,eq,'99902076',''),!(DocketNumber,eq,'99900003',''),!(DocketNumber,eq,'99902049',''),!(DocketNumber,eq,'05200048',''),!(DocketNumber,eq,'99902078',''),!(DocketNumber,eq,'05200050',''),!(DocketNumber,eq,'99902052',''),!(DocketNumber,eq,'99902069',''),!(DocketNumber,eq,'05007513',''),!(DocketNumber,eq,'05000611',''),!(DocketNumber,eq,'05000612',''),!(DocketNumber,eq,'99902095',''),!(DocketNumber,eq,'99902101',''),!(DocketNumber,eq,'05200049',''),!(DocketNumber,eq,'99902128',''),!(DocketNumber,eq,'99902136',''),!(DocketNumber,eq,'99902122',''),!(DocketNumber,eq,'99902056',''),!(DocketNumber,eq,'05000615','')),properties_search_all:!(!(PublishDatePARS,gt,'01/01/2017',''),!(PublishDatePARS,lt,'02/13/2017',''))))&qn=New&tab=advanced-search-pars&z=0 
#> : 0.546 sec elapsed
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search_any:!(!(DocketNumber,eq,'99902088',''),!(DocketNumber,eq,'05000610',''),!(DocketNumber,eq,'05000608',''),!(DocketNumber,eq,'99902115',''),!(DocketNumber,eq,'99902071',''),!(DocketNumber,eq,'07007027',''),!(DocketNumber,eq,'99902117',''),!(DocketNumber,eq,'99902111',''),!(DocketNumber,eq,'99902100',''),!(DocketNumber,eq,'05000613',''),!(DocketNumber,eq,'99902150',''),!(DocketNumber,eq,'99902094',''),!(DocketNumber,eq,'99902079',''),!(DocketNumber,eq,'99902076',''),!(DocketNumber,eq,'99900003',''),!(DocketNumber,eq,'99902049',''),!(DocketNumber,eq,'05200048',''),!(DocketNumber,eq,'99902078',''),!(DocketNumber,eq,'05200050',''),!(DocketNumber,eq,'99902052',''),!(DocketNumber,eq,'99902069',''),!(DocketNumber,eq,'05007513',''),!(DocketNumber,eq,'05000611',''),!(DocketNumber,eq,'05000612',''),!(DocketNumber,eq,'99902095',''),!(DocketNumber,eq,'99902101',''),!(DocketNumber,eq,'05200049',''),!(DocketNumber,eq,'99902128',''),!(DocketNumber,eq,'99902136',''),!(DocketNumber,eq,'99902122',''),!(DocketNumber,eq,'99902056',''),!(DocketNumber,eq,'05000615','')),properties_search_all:!(!(PublishDatePARS,gt,'02/13/2017',''),!(PublishDatePARS,lt,'03/28/2017',''))))&qn=New&tab=advanced-search-pars&z=0 
#> : 1.083 sec elapsed
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search_any:!(!(DocketNumber,eq,'99902088',''),!(DocketNumber,eq,'05000610',''),!(DocketNumber,eq,'05000608',''),!(DocketNumber,eq,'99902115',''),!(DocketNumber,eq,'99902071',''),!(DocketNumber,eq,'07007027',''),!(DocketNumber,eq,'99902117',''),!(DocketNumber,eq,'99902111',''),!(DocketNumber,eq,'99902100',''),!(DocketNumber,eq,'05000613',''),!(DocketNumber,eq,'99902150',''),!(DocketNumber,eq,'99902094',''),!(DocketNumber,eq,'99902079',''),!(DocketNumber,eq,'99902076',''),!(DocketNumber,eq,'99900003',''),!(DocketNumber,eq,'99902049',''),!(DocketNumber,eq,'05200048',''),!(DocketNumber,eq,'99902078',''),!(DocketNumber,eq,'05200050',''),!(DocketNumber,eq,'99902052',''),!(DocketNumber,eq,'99902069',''),!(DocketNumber,eq,'05007513',''),!(DocketNumber,eq,'05000611',''),!(DocketNumber,eq,'05000612',''),!(DocketNumber,eq,'99902095',''),!(DocketNumber,eq,'99902101',''),!(DocketNumber,eq,'05200049',''),!(DocketNumber,eq,'99902128',''),!(DocketNumber,eq,'99902136',''),!(DocketNumber,eq,'99902122',''),!(DocketNumber,eq,'99902056',''),!(DocketNumber,eq,'05000615','')),properties_search_all:!(!(PublishDatePARS,gt,'03/28/2017',''),!(PublishDatePARS,lt,'05/11/2017',''))))&qn=New&tab=advanced-search-pars&z=0 
#> : 0.925 sec elapsed
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search_any:!(!(DocketNumber,eq,'99902088',''),!(DocketNumber,eq,'05000610',''),!(DocketNumber,eq,'05000608',''),!(DocketNumber,eq,'99902115',''),!(DocketNumber,eq,'99902071',''),!(DocketNumber,eq,'07007027',''),!(DocketNumber,eq,'99902117',''),!(DocketNumber,eq,'99902111',''),!(DocketNumber,eq,'99902100',''),!(DocketNumber,eq,'05000613',''),!(DocketNumber,eq,'99902150',''),!(DocketNumber,eq,'99902094',''),!(DocketNumber,eq,'99902079',''),!(DocketNumber,eq,'99902076',''),!(DocketNumber,eq,'99900003',''),!(DocketNumber,eq,'99902049',''),!(DocketNumber,eq,'05200048',''),!(DocketNumber,eq,'99902078',''),!(DocketNumber,eq,'05200050',''),!(DocketNumber,eq,'99902052',''),!(DocketNumber,eq,'99902069',''),!(DocketNumber,eq,'05007513',''),!(DocketNumber,eq,'05000611',''),!(DocketNumber,eq,'05000612',''),!(DocketNumber,eq,'99902095',''),!(DocketNumber,eq,'99902101',''),!(DocketNumber,eq,'05200049',''),!(DocketNumber,eq,'99902128',''),!(DocketNumber,eq,'99902136',''),!(DocketNumber,eq,'99902122',''),!(DocketNumber,eq,'99902056',''),!(DocketNumber,eq,'05000615','')),properties_search_all:!(!(PublishDatePARS,gt,'05/11/2017',''),!(PublishDatePARS,lt,'06/23/2017',''))))&qn=New&tab=advanced-search-pars&z=0 
#> : 3.388 sec elapsed
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search_any:!(!(DocketNumber,eq,'99902088',''),!(DocketNumber,eq,'05000610',''),!(DocketNumber,eq,'05000608',''),!(DocketNumber,eq,'99902115',''),!(DocketNumber,eq,'99902071',''),!(DocketNumber,eq,'07007027',''),!(DocketNumber,eq,'99902117',''),!(DocketNumber,eq,'99902111',''),!(DocketNumber,eq,'99902100',''),!(DocketNumber,eq,'05000613',''),!(DocketNumber,eq,'99902150',''),!(DocketNumber,eq,'99902094',''),!(DocketNumber,eq,'99902079',''),!(DocketNumber,eq,'99902076',''),!(DocketNumber,eq,'99900003',''),!(DocketNumber,eq,'99902049',''),!(DocketNumber,eq,'05200048',''),!(DocketNumber,eq,'99902078',''),!(DocketNumber,eq,'05200050',''),!(DocketNumber,eq,'99902052',''),!(DocketNumber,eq,'99902069',''),!(DocketNumber,eq,'05007513',''),!(DocketNumber,eq,'05000611',''),!(DocketNumber,eq,'05000612',''),!(DocketNumber,eq,'99902095',''),!(DocketNumber,eq,'99902101',''),!(DocketNumber,eq,'05200049',''),!(DocketNumber,eq,'99902128',''),!(DocketNumber,eq,'99902136',''),!(DocketNumber,eq,'99902122',''),!(DocketNumber,eq,'99902056',''),!(DocketNumber,eq,'05000615','')),properties_search_all:!(!(PublishDatePARS,gt,'06/23/2017',''),!(PublishDatePARS,lt,'08/06/2017',''))))&qn=New&tab=advanced-search-pars&z=0 
#> : 2.358 sec elapsed
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search_any:!(!(DocketNumber,eq,'99902088',''),!(DocketNumber,eq,'05000610',''),!(DocketNumber,eq,'05000608',''),!(DocketNumber,eq,'99902115',''),!(DocketNumber,eq,'99902071',''),!(DocketNumber,eq,'07007027',''),!(DocketNumber,eq,'99902117',''),!(DocketNumber,eq,'99902111',''),!(DocketNumber,eq,'99902100',''),!(DocketNumber,eq,'05000613',''),!(DocketNumber,eq,'99902150',''),!(DocketNumber,eq,'99902094',''),!(DocketNumber,eq,'99902079',''),!(DocketNumber,eq,'99902076',''),!(DocketNumber,eq,'99900003',''),!(DocketNumber,eq,'99902049',''),!(DocketNumber,eq,'05200048',''),!(DocketNumber,eq,'99902078',''),!(DocketNumber,eq,'05200050',''),!(DocketNumber,eq,'99902052',''),!(DocketNumber,eq,'99902069',''),!(DocketNumber,eq,'05007513',''),!(DocketNumber,eq,'05000611',''),!(DocketNumber,eq,'05000612',''),!(DocketNumber,eq,'99902095',''),!(DocketNumber,eq,'99902101',''),!(DocketNumber,eq,'05200049',''),!(DocketNumber,eq,'99902128',''),!(DocketNumber,eq,'99902136',''),!(DocketNumber,eq,'99902122',''),!(DocketNumber,eq,'99902056',''),!(DocketNumber,eq,'05000615','')),properties_search_all:!(!(PublishDatePARS,gt,'08/06/2017',''),!(PublishDatePARS,lt,'09/18/2017',''))))&qn=New&tab=advanced-search-pars&z=0 
#> : 1.772 sec elapsed
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search_any:!(!(DocketNumber,eq,'99902088',''),!(DocketNumber,eq,'05000610',''),!(DocketNumber,eq,'05000608',''),!(DocketNumber,eq,'99902115',''),!(DocketNumber,eq,'99902071',''),!(DocketNumber,eq,'07007027',''),!(DocketNumber,eq,'99902117',''),!(DocketNumber,eq,'99902111',''),!(DocketNumber,eq,'99902100',''),!(DocketNumber,eq,'05000613',''),!(DocketNumber,eq,'99902150',''),!(DocketNumber,eq,'99902094',''),!(DocketNumber,eq,'99902079',''),!(DocketNumber,eq,'99902076',''),!(DocketNumber,eq,'99900003',''),!(DocketNumber,eq,'99902049',''),!(DocketNumber,eq,'05200048',''),!(DocketNumber,eq,'99902078',''),!(DocketNumber,eq,'05200050',''),!(DocketNumber,eq,'99902052',''),!(DocketNumber,eq,'99902069',''),!(DocketNumber,eq,'05007513',''),!(DocketNumber,eq,'05000611',''),!(DocketNumber,eq,'05000612',''),!(DocketNumber,eq,'99902095',''),!(DocketNumber,eq,'99902101',''),!(DocketNumber,eq,'05200049',''),!(DocketNumber,eq,'99902128',''),!(DocketNumber,eq,'99902136',''),!(DocketNumber,eq,'99902122',''),!(DocketNumber,eq,'99902056',''),!(DocketNumber,eq,'05000615','')),properties_search_all:!(!(PublishDatePARS,gt,'09/18/2017',''),!(PublishDatePARS,lt,'11/01/2017',''))))&qn=New&tab=advanced-search-pars&z=0 
#> : 1.689 sec elapsed
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search_any:!(!(DocketNumber,eq,'99902088',''),!(DocketNumber,eq,'05000610',''),!(DocketNumber,eq,'05000608',''),!(DocketNumber,eq,'99902115',''),!(DocketNumber,eq,'99902071',''),!(DocketNumber,eq,'07007027',''),!(DocketNumber,eq,'99902117',''),!(DocketNumber,eq,'99902111',''),!(DocketNumber,eq,'99902100',''),!(DocketNumber,eq,'05000613',''),!(DocketNumber,eq,'99902150',''),!(DocketNumber,eq,'99902094',''),!(DocketNumber,eq,'99902079',''),!(DocketNumber,eq,'99902076',''),!(DocketNumber,eq,'99900003',''),!(DocketNumber,eq,'99902049',''),!(DocketNumber,eq,'05200048',''),!(DocketNumber,eq,'99902078',''),!(DocketNumber,eq,'05200050',''),!(DocketNumber,eq,'99902052',''),!(DocketNumber,eq,'99902069',''),!(DocketNumber,eq,'05007513',''),!(DocketNumber,eq,'05000611',''),!(DocketNumber,eq,'05000612',''),!(DocketNumber,eq,'99902095',''),!(DocketNumber,eq,'99902101',''),!(DocketNumber,eq,'05200049',''),!(DocketNumber,eq,'99902128',''),!(DocketNumber,eq,'99902136',''),!(DocketNumber,eq,'99902122',''),!(DocketNumber,eq,'99902056',''),!(DocketNumber,eq,'05000615','')),properties_search_all:!(!(PublishDatePARS,gt,'11/01/2017',''),!(PublishDatePARS,lt,'12/14/2017',''))))&qn=New&tab=advanced-search-pars&z=0 
#> : 1.413 sec elapsed
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search_any:!(!(DocketNumber,eq,'99902088',''),!(DocketNumber,eq,'05000610',''),!(DocketNumber,eq,'05000608',''),!(DocketNumber,eq,'99902115',''),!(DocketNumber,eq,'99902071',''),!(DocketNumber,eq,'07007027',''),!(DocketNumber,eq,'99902117',''),!(DocketNumber,eq,'99902111',''),!(DocketNumber,eq,'99902100',''),!(DocketNumber,eq,'05000613',''),!(DocketNumber,eq,'99902150',''),!(DocketNumber,eq,'99902094',''),!(DocketNumber,eq,'99902079',''),!(DocketNumber,eq,'99902076',''),!(DocketNumber,eq,'99900003',''),!(DocketNumber,eq,'99902049',''),!(DocketNumber,eq,'05200048',''),!(DocketNumber,eq,'99902078',''),!(DocketNumber,eq,'05200050',''),!(DocketNumber,eq,'99902052',''),!(DocketNumber,eq,'99902069',''),!(DocketNumber,eq,'05007513',''),!(DocketNumber,eq,'05000611',''),!(DocketNumber,eq,'05000612',''),!(DocketNumber,eq,'99902095',''),!(DocketNumber,eq,'99902101',''),!(DocketNumber,eq,'05200049',''),!(DocketNumber,eq,'99902128',''),!(DocketNumber,eq,'99902136',''),!(DocketNumber,eq,'99902122',''),!(DocketNumber,eq,'99902056',''),!(DocketNumber,eq,'05000615','')),properties_search_all:!(!(PublishDatePARS,gt,'12/14/2017',''),!(PublishDatePARS,lt,'01/27/2018',''))))&qn=New&tab=advanced-search-pars&z=0 
#> : 1.573 sec elapsed
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search_any:!(!(DocketNumber,eq,'99902088',''),!(DocketNumber,eq,'05000610',''),!(DocketNumber,eq,'05000608',''),!(DocketNumber,eq,'99902115',''),!(DocketNumber,eq,'99902071',''),!(DocketNumber,eq,'07007027',''),!(DocketNumber,eq,'99902117',''),!(DocketNumber,eq,'99902111',''),!(DocketNumber,eq,'99902100',''),!(DocketNumber,eq,'05000613',''),!(DocketNumber,eq,'99902150',''),!(DocketNumber,eq,'99902094',''),!(DocketNumber,eq,'99902079',''),!(DocketNumber,eq,'99902076',''),!(DocketNumber,eq,'99900003',''),!(DocketNumber,eq,'99902049',''),!(DocketNumber,eq,'05200048',''),!(DocketNumber,eq,'99902078',''),!(DocketNumber,eq,'05200050',''),!(DocketNumber,eq,'99902052',''),!(DocketNumber,eq,'99902069',''),!(DocketNumber,eq,'05007513',''),!(DocketNumber,eq,'05000611',''),!(DocketNumber,eq,'05000612',''),!(DocketNumber,eq,'99902095',''),!(DocketNumber,eq,'99902101',''),!(DocketNumber,eq,'05200049',''),!(DocketNumber,eq,'99902128',''),!(DocketNumber,eq,'99902136',''),!(DocketNumber,eq,'99902122',''),!(DocketNumber,eq,'99902056',''),!(DocketNumber,eq,'05000615','')),properties_search_all:!(!(PublishDatePARS,gt,'01/27/2018',''),!(PublishDatePARS,lt,'03/11/2018',''))))&qn=New&tab=advanced-search-pars&z=0 
#> : 1.566 sec elapsed
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search_any:!(!(DocketNumber,eq,'99902088',''),!(DocketNumber,eq,'05000610',''),!(DocketNumber,eq,'05000608',''),!(DocketNumber,eq,'99902115',''),!(DocketNumber,eq,'99902071',''),!(DocketNumber,eq,'07007027',''),!(DocketNumber,eq,'99902117',''),!(DocketNumber,eq,'99902111',''),!(DocketNumber,eq,'99902100',''),!(DocketNumber,eq,'05000613',''),!(DocketNumber,eq,'99902150',''),!(DocketNumber,eq,'99902094',''),!(DocketNumber,eq,'99902079',''),!(DocketNumber,eq,'99902076',''),!(DocketNumber,eq,'99900003',''),!(DocketNumber,eq,'99902049',''),!(DocketNumber,eq,'05200048',''),!(DocketNumber,eq,'99902078',''),!(DocketNumber,eq,'05200050',''),!(DocketNumber,eq,'99902052',''),!(DocketNumber,eq,'99902069',''),!(DocketNumber,eq,'05007513',''),!(DocketNumber,eq,'05000611',''),!(DocketNumber,eq,'05000612',''),!(DocketNumber,eq,'99902095',''),!(DocketNumber,eq,'99902101',''),!(DocketNumber,eq,'05200049',''),!(DocketNumber,eq,'99902128',''),!(DocketNumber,eq,'99902136',''),!(DocketNumber,eq,'99902122',''),!(DocketNumber,eq,'99902056',''),!(DocketNumber,eq,'05000615','')),properties_search_all:!(!(PublishDatePARS,gt,'03/11/2018',''),!(PublishDatePARS,lt,'04/23/2018',''))))&qn=New&tab=advanced-search-pars&z=0 
#> : 1.497 sec elapsed
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search_any:!(!(DocketNumber,eq,'99902088',''),!(DocketNumber,eq,'05000610',''),!(DocketNumber,eq,'05000608',''),!(DocketNumber,eq,'99902115',''),!(DocketNumber,eq,'99902071',''),!(DocketNumber,eq,'07007027',''),!(DocketNumber,eq,'99902117',''),!(DocketNumber,eq,'99902111',''),!(DocketNumber,eq,'99902100',''),!(DocketNumber,eq,'05000613',''),!(DocketNumber,eq,'99902150',''),!(DocketNumber,eq,'99902094',''),!(DocketNumber,eq,'99902079',''),!(DocketNumber,eq,'99902076',''),!(DocketNumber,eq,'99900003',''),!(DocketNumber,eq,'99902049',''),!(DocketNumber,eq,'05200048',''),!(DocketNumber,eq,'99902078',''),!(DocketNumber,eq,'05200050',''),!(DocketNumber,eq,'99902052',''),!(DocketNumber,eq,'99902069',''),!(DocketNumber,eq,'05007513',''),!(DocketNumber,eq,'05000611',''),!(DocketNumber,eq,'05000612',''),!(DocketNumber,eq,'99902095',''),!(DocketNumber,eq,'99902101',''),!(DocketNumber,eq,'05200049',''),!(DocketNumber,eq,'99902128',''),!(DocketNumber,eq,'99902136',''),!(DocketNumber,eq,'99902122',''),!(DocketNumber,eq,'99902056',''),!(DocketNumber,eq,'05000615','')),properties_search_all:!(!(PublishDatePARS,gt,'04/23/2018',''),!(PublishDatePARS,lt,'06/06/2018',''))))&qn=New&tab=advanced-search-pars&z=0 
#> : 1.688 sec elapsed
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search_any:!(!(DocketNumber,eq,'99902088',''),!(DocketNumber,eq,'05000610',''),!(DocketNumber,eq,'05000608',''),!(DocketNumber,eq,'99902115',''),!(DocketNumber,eq,'99902071',''),!(DocketNumber,eq,'07007027',''),!(DocketNumber,eq,'99902117',''),!(DocketNumber,eq,'99902111',''),!(DocketNumber,eq,'99902100',''),!(DocketNumber,eq,'05000613',''),!(DocketNumber,eq,'99902150',''),!(DocketNumber,eq,'99902094',''),!(DocketNumber,eq,'99902079',''),!(DocketNumber,eq,'99902076',''),!(DocketNumber,eq,'99900003',''),!(DocketNumber,eq,'99902049',''),!(DocketNumber,eq,'05200048',''),!(DocketNumber,eq,'99902078',''),!(DocketNumber,eq,'05200050',''),!(DocketNumber,eq,'99902052',''),!(DocketNumber,eq,'99902069',''),!(DocketNumber,eq,'05007513',''),!(DocketNumber,eq,'05000611',''),!(DocketNumber,eq,'05000612',''),!(DocketNumber,eq,'99902095',''),!(DocketNumber,eq,'99902101',''),!(DocketNumber,eq,'05200049',''),!(DocketNumber,eq,'99902128',''),!(DocketNumber,eq,'99902136',''),!(DocketNumber,eq,'99902122',''),!(DocketNumber,eq,'99902056',''),!(DocketNumber,eq,'05000615','')),properties_search_all:!(!(PublishDatePARS,gt,'06/06/2018',''),!(PublishDatePARS,lt,'07/19/2018',''))))&qn=New&tab=advanced-search-pars&z=0 
#> : 1.999 sec elapsed
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search_any:!(!(DocketNumber,eq,'99902088',''),!(DocketNumber,eq,'05000610',''),!(DocketNumber,eq,'05000608',''),!(DocketNumber,eq,'99902115',''),!(DocketNumber,eq,'99902071',''),!(DocketNumber,eq,'07007027',''),!(DocketNumber,eq,'99902117',''),!(DocketNumber,eq,'99902111',''),!(DocketNumber,eq,'99902100',''),!(DocketNumber,eq,'05000613',''),!(DocketNumber,eq,'99902150',''),!(DocketNumber,eq,'99902094',''),!(DocketNumber,eq,'99902079',''),!(DocketNumber,eq,'99902076',''),!(DocketNumber,eq,'99900003',''),!(DocketNumber,eq,'99902049',''),!(DocketNumber,eq,'05200048',''),!(DocketNumber,eq,'99902078',''),!(DocketNumber,eq,'05200050',''),!(DocketNumber,eq,'99902052',''),!(DocketNumber,eq,'99902069',''),!(DocketNumber,eq,'05007513',''),!(DocketNumber,eq,'05000611',''),!(DocketNumber,eq,'05000612',''),!(DocketNumber,eq,'99902095',''),!(DocketNumber,eq,'99902101',''),!(DocketNumber,eq,'05200049',''),!(DocketNumber,eq,'99902128',''),!(DocketNumber,eq,'99902136',''),!(DocketNumber,eq,'99902122',''),!(DocketNumber,eq,'99902056',''),!(DocketNumber,eq,'05000615','')),properties_search_all:!(!(PublishDatePARS,gt,'07/19/2018',''),!(PublishDatePARS,lt,'09/01/2018',''))))&qn=New&tab=advanced-search-pars&z=0 
#> : 1.421 sec elapsed
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search_any:!(!(DocketNumber,eq,'99902088',''),!(DocketNumber,eq,'05000610',''),!(DocketNumber,eq,'05000608',''),!(DocketNumber,eq,'99902115',''),!(DocketNumber,eq,'99902071',''),!(DocketNumber,eq,'07007027',''),!(DocketNumber,eq,'99902117',''),!(DocketNumber,eq,'99902111',''),!(DocketNumber,eq,'99902100',''),!(DocketNumber,eq,'05000613',''),!(DocketNumber,eq,'99902150',''),!(DocketNumber,eq,'99902094',''),!(DocketNumber,eq,'99902079',''),!(DocketNumber,eq,'99902076',''),!(DocketNumber,eq,'99900003',''),!(DocketNumber,eq,'99902049',''),!(DocketNumber,eq,'05200048',''),!(DocketNumber,eq,'99902078',''),!(DocketNumber,eq,'05200050',''),!(DocketNumber,eq,'99902052',''),!(DocketNumber,eq,'99902069',''),!(DocketNumber,eq,'05007513',''),!(DocketNumber,eq,'05000611',''),!(DocketNumber,eq,'05000612',''),!(DocketNumber,eq,'99902095',''),!(DocketNumber,eq,'99902101',''),!(DocketNumber,eq,'05200049',''),!(DocketNumber,eq,'99902128',''),!(DocketNumber,eq,'99902136',''),!(DocketNumber,eq,'99902122',''),!(DocketNumber,eq,'99902056',''),!(DocketNumber,eq,'05000615','')),properties_search_all:!(!(PublishDatePARS,gt,'09/01/2018',''),!(PublishDatePARS,lt,'10/14/2018',''))))&qn=New&tab=advanced-search-pars&z=0 
#> : 1.324 sec elapsed
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search_any:!(!(DocketNumber,eq,'99902088',''),!(DocketNumber,eq,'05000610',''),!(DocketNumber,eq,'05000608',''),!(DocketNumber,eq,'99902115',''),!(DocketNumber,eq,'99902071',''),!(DocketNumber,eq,'07007027',''),!(DocketNumber,eq,'99902117',''),!(DocketNumber,eq,'99902111',''),!(DocketNumber,eq,'99902100',''),!(DocketNumber,eq,'05000613',''),!(DocketNumber,eq,'99902150',''),!(DocketNumber,eq,'99902094',''),!(DocketNumber,eq,'99902079',''),!(DocketNumber,eq,'99902076',''),!(DocketNumber,eq,'99900003',''),!(DocketNumber,eq,'99902049',''),!(DocketNumber,eq,'05200048',''),!(DocketNumber,eq,'99902078',''),!(DocketNumber,eq,'05200050',''),!(DocketNumber,eq,'99902052',''),!(DocketNumber,eq,'99902069',''),!(DocketNumber,eq,'05007513',''),!(DocketNumber,eq,'05000611',''),!(DocketNumber,eq,'05000612',''),!(DocketNumber,eq,'99902095',''),!(DocketNumber,eq,'99902101',''),!(DocketNumber,eq,'05200049',''),!(DocketNumber,eq,'99902128',''),!(DocketNumber,eq,'99902136',''),!(DocketNumber,eq,'99902122',''),!(DocketNumber,eq,'99902056',''),!(DocketNumber,eq,'05000615','')),properties_search_all:!(!(PublishDatePARS,gt,'10/14/2018',''),!(PublishDatePARS,lt,'11/27/2018',''))))&qn=New&tab=advanced-search-pars&z=0 
#> : 1.492 sec elapsed
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search_any:!(!(DocketNumber,eq,'99902088',''),!(DocketNumber,eq,'05000610',''),!(DocketNumber,eq,'05000608',''),!(DocketNumber,eq,'99902115',''),!(DocketNumber,eq,'99902071',''),!(DocketNumber,eq,'07007027',''),!(DocketNumber,eq,'99902117',''),!(DocketNumber,eq,'99902111',''),!(DocketNumber,eq,'99902100',''),!(DocketNumber,eq,'05000613',''),!(DocketNumber,eq,'99902150',''),!(DocketNumber,eq,'99902094',''),!(DocketNumber,eq,'99902079',''),!(DocketNumber,eq,'99902076',''),!(DocketNumber,eq,'99900003',''),!(DocketNumber,eq,'99902049',''),!(DocketNumber,eq,'05200048',''),!(DocketNumber,eq,'99902078',''),!(DocketNumber,eq,'05200050',''),!(DocketNumber,eq,'99902052',''),!(DocketNumber,eq,'99902069',''),!(DocketNumber,eq,'05007513',''),!(DocketNumber,eq,'05000611',''),!(DocketNumber,eq,'05000612',''),!(DocketNumber,eq,'99902095',''),!(DocketNumber,eq,'99902101',''),!(DocketNumber,eq,'05200049',''),!(DocketNumber,eq,'99902128',''),!(DocketNumber,eq,'99902136',''),!(DocketNumber,eq,'99902122',''),!(DocketNumber,eq,'99902056',''),!(DocketNumber,eq,'05000615','')),properties_search_all:!(!(PublishDatePARS,gt,'11/27/2018',''),!(PublishDatePARS,lt,'01/09/2019',''))))&qn=New&tab=advanced-search-pars&z=0 
#> : 1.228 sec elapsed
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search_any:!(!(DocketNumber,eq,'99902088',''),!(DocketNumber,eq,'05000610',''),!(DocketNumber,eq,'05000608',''),!(DocketNumber,eq,'99902115',''),!(DocketNumber,eq,'99902071',''),!(DocketNumber,eq,'07007027',''),!(DocketNumber,eq,'99902117',''),!(DocketNumber,eq,'99902111',''),!(DocketNumber,eq,'99902100',''),!(DocketNumber,eq,'05000613',''),!(DocketNumber,eq,'99902150',''),!(DocketNumber,eq,'99902094',''),!(DocketNumber,eq,'99902079',''),!(DocketNumber,eq,'99902076',''),!(DocketNumber,eq,'99900003',''),!(DocketNumber,eq,'99902049',''),!(DocketNumber,eq,'05200048',''),!(DocketNumber,eq,'99902078',''),!(DocketNumber,eq,'05200050',''),!(DocketNumber,eq,'99902052',''),!(DocketNumber,eq,'99902069',''),!(DocketNumber,eq,'05007513',''),!(DocketNumber,eq,'05000611',''),!(DocketNumber,eq,'05000612',''),!(DocketNumber,eq,'99902095',''),!(DocketNumber,eq,'99902101',''),!(DocketNumber,eq,'05200049',''),!(DocketNumber,eq,'99902128',''),!(DocketNumber,eq,'99902136',''),!(DocketNumber,eq,'99902122',''),!(DocketNumber,eq,'99902056',''),!(DocketNumber,eq,'05000615','')),properties_search_all:!(!(PublishDatePARS,gt,'01/09/2019',''),!(PublishDatePARS,lt,'02/22/2019',''))))&qn=New&tab=advanced-search-pars&z=0 
#> : 1.368 sec elapsed
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search_any:!(!(DocketNumber,eq,'99902088',''),!(DocketNumber,eq,'05000610',''),!(DocketNumber,eq,'05000608',''),!(DocketNumber,eq,'99902115',''),!(DocketNumber,eq,'99902071',''),!(DocketNumber,eq,'07007027',''),!(DocketNumber,eq,'99902117',''),!(DocketNumber,eq,'99902111',''),!(DocketNumber,eq,'99902100',''),!(DocketNumber,eq,'05000613',''),!(DocketNumber,eq,'99902150',''),!(DocketNumber,eq,'99902094',''),!(DocketNumber,eq,'99902079',''),!(DocketNumber,eq,'99902076',''),!(DocketNumber,eq,'99900003',''),!(DocketNumber,eq,'99902049',''),!(DocketNumber,eq,'05200048',''),!(DocketNumber,eq,'99902078',''),!(DocketNumber,eq,'05200050',''),!(DocketNumber,eq,'99902052',''),!(DocketNumber,eq,'99902069',''),!(DocketNumber,eq,'05007513',''),!(DocketNumber,eq,'05000611',''),!(DocketNumber,eq,'05000612',''),!(DocketNumber,eq,'99902095',''),!(DocketNumber,eq,'99902101',''),!(DocketNumber,eq,'05200049',''),!(DocketNumber,eq,'99902128',''),!(DocketNumber,eq,'99902136',''),!(DocketNumber,eq,'99902122',''),!(DocketNumber,eq,'99902056',''),!(DocketNumber,eq,'05000615','')),properties_search_all:!(!(PublishDatePARS,gt,'02/22/2019',''),!(PublishDatePARS,lt,'04/06/2019',''))))&qn=New&tab=advanced-search-pars&z=0 
#> : 1.304 sec elapsed
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search_any:!(!(DocketNumber,eq,'99902088',''),!(DocketNumber,eq,'05000610',''),!(DocketNumber,eq,'05000608',''),!(DocketNumber,eq,'99902115',''),!(DocketNumber,eq,'99902071',''),!(DocketNumber,eq,'07007027',''),!(DocketNumber,eq,'99902117',''),!(DocketNumber,eq,'99902111',''),!(DocketNumber,eq,'99902100',''),!(DocketNumber,eq,'05000613',''),!(DocketNumber,eq,'99902150',''),!(DocketNumber,eq,'99902094',''),!(DocketNumber,eq,'99902079',''),!(DocketNumber,eq,'99902076',''),!(DocketNumber,eq,'99900003',''),!(DocketNumber,eq,'99902049',''),!(DocketNumber,eq,'05200048',''),!(DocketNumber,eq,'99902078',''),!(DocketNumber,eq,'05200050',''),!(DocketNumber,eq,'99902052',''),!(DocketNumber,eq,'99902069',''),!(DocketNumber,eq,'05007513',''),!(DocketNumber,eq,'05000611',''),!(DocketNumber,eq,'05000612',''),!(DocketNumber,eq,'99902095',''),!(DocketNumber,eq,'99902101',''),!(DocketNumber,eq,'05200049',''),!(DocketNumber,eq,'99902128',''),!(DocketNumber,eq,'99902136',''),!(DocketNumber,eq,'99902122',''),!(DocketNumber,eq,'99902056',''),!(DocketNumber,eq,'05000615','')),properties_search_all:!(!(PublishDatePARS,gt,'04/06/2019',''),!(PublishDatePARS,lt,'05/20/2019',''))))&qn=New&tab=advanced-search-pars&z=0 
#> : 1.457 sec elapsed
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search_any:!(!(DocketNumber,eq,'99902088',''),!(DocketNumber,eq,'05000610',''),!(DocketNumber,eq,'05000608',''),!(DocketNumber,eq,'99902115',''),!(DocketNumber,eq,'99902071',''),!(DocketNumber,eq,'07007027',''),!(DocketNumber,eq,'99902117',''),!(DocketNumber,eq,'99902111',''),!(DocketNumber,eq,'99902100',''),!(DocketNumber,eq,'05000613',''),!(DocketNumber,eq,'99902150',''),!(DocketNumber,eq,'99902094',''),!(DocketNumber,eq,'99902079',''),!(DocketNumber,eq,'99902076',''),!(DocketNumber,eq,'99900003',''),!(DocketNumber,eq,'99902049',''),!(DocketNumber,eq,'05200048',''),!(DocketNumber,eq,'99902078',''),!(DocketNumber,eq,'05200050',''),!(DocketNumber,eq,'99902052',''),!(DocketNumber,eq,'99902069',''),!(DocketNumber,eq,'05007513',''),!(DocketNumber,eq,'05000611',''),!(DocketNumber,eq,'05000612',''),!(DocketNumber,eq,'99902095',''),!(DocketNumber,eq,'99902101',''),!(DocketNumber,eq,'05200049',''),!(DocketNumber,eq,'99902128',''),!(DocketNumber,eq,'99902136',''),!(DocketNumber,eq,'99902122',''),!(DocketNumber,eq,'99902056',''),!(DocketNumber,eq,'05000615','')),properties_search_all:!(!(PublishDatePARS,gt,'05/20/2019',''),!(PublishDatePARS,lt,'07/02/2019',''))))&qn=New&tab=advanced-search-pars&z=0 
#> : 1.056 sec elapsed
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search_any:!(!(DocketNumber,eq,'99902088',''),!(DocketNumber,eq,'05000610',''),!(DocketNumber,eq,'05000608',''),!(DocketNumber,eq,'99902115',''),!(DocketNumber,eq,'99902071',''),!(DocketNumber,eq,'07007027',''),!(DocketNumber,eq,'99902117',''),!(DocketNumber,eq,'99902111',''),!(DocketNumber,eq,'99902100',''),!(DocketNumber,eq,'05000613',''),!(DocketNumber,eq,'99902150',''),!(DocketNumber,eq,'99902094',''),!(DocketNumber,eq,'99902079',''),!(DocketNumber,eq,'99902076',''),!(DocketNumber,eq,'99900003',''),!(DocketNumber,eq,'99902049',''),!(DocketNumber,eq,'05200048',''),!(DocketNumber,eq,'99902078',''),!(DocketNumber,eq,'05200050',''),!(DocketNumber,eq,'99902052',''),!(DocketNumber,eq,'99902069',''),!(DocketNumber,eq,'05007513',''),!(DocketNumber,eq,'05000611',''),!(DocketNumber,eq,'05000612',''),!(DocketNumber,eq,'99902095',''),!(DocketNumber,eq,'99902101',''),!(DocketNumber,eq,'05200049',''),!(DocketNumber,eq,'99902128',''),!(DocketNumber,eq,'99902136',''),!(DocketNumber,eq,'99902122',''),!(DocketNumber,eq,'99902056',''),!(DocketNumber,eq,'05000615','')),properties_search_all:!(!(PublishDatePARS,gt,'07/02/2019',''),!(PublishDatePARS,lt,'08/14/2019',''))))&qn=New&tab=advanced-search-pars&z=0 
#> : 1.081 sec elapsed
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search_any:!(!(DocketNumber,eq,'99902088',''),!(DocketNumber,eq,'05000610',''),!(DocketNumber,eq,'05000608',''),!(DocketNumber,eq,'99902115',''),!(DocketNumber,eq,'99902071',''),!(DocketNumber,eq,'07007027',''),!(DocketNumber,eq,'99902117',''),!(DocketNumber,eq,'99902111',''),!(DocketNumber,eq,'99902100',''),!(DocketNumber,eq,'05000613',''),!(DocketNumber,eq,'99902150',''),!(DocketNumber,eq,'99902094',''),!(DocketNumber,eq,'99902079',''),!(DocketNumber,eq,'99902076',''),!(DocketNumber,eq,'99900003',''),!(DocketNumber,eq,'99902049',''),!(DocketNumber,eq,'05200048',''),!(DocketNumber,eq,'99902078',''),!(DocketNumber,eq,'05200050',''),!(DocketNumber,eq,'99902052',''),!(DocketNumber,eq,'99902069',''),!(DocketNumber,eq,'05007513',''),!(DocketNumber,eq,'05000611',''),!(DocketNumber,eq,'05000612',''),!(DocketNumber,eq,'99902095',''),!(DocketNumber,eq,'99902101',''),!(DocketNumber,eq,'05200049',''),!(DocketNumber,eq,'99902128',''),!(DocketNumber,eq,'99902136',''),!(DocketNumber,eq,'99902122',''),!(DocketNumber,eq,'99902056',''),!(DocketNumber,eq,'05000615','')),properties_search_all:!(!(PublishDatePARS,gt,'08/14/2019',''),!(PublishDatePARS,lt,'09/27/2019',''))))&qn=New&tab=advanced-search-pars&z=0 
#> : 1.113 sec elapsed
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search_any:!(!(DocketNumber,eq,'99902088',''),!(DocketNumber,eq,'05000610',''),!(DocketNumber,eq,'05000608',''),!(DocketNumber,eq,'99902115',''),!(DocketNumber,eq,'99902071',''),!(DocketNumber,eq,'07007027',''),!(DocketNumber,eq,'99902117',''),!(DocketNumber,eq,'99902111',''),!(DocketNumber,eq,'99902100',''),!(DocketNumber,eq,'05000613',''),!(DocketNumber,eq,'99902150',''),!(DocketNumber,eq,'99902094',''),!(DocketNumber,eq,'99902079',''),!(DocketNumber,eq,'99902076',''),!(DocketNumber,eq,'99900003',''),!(DocketNumber,eq,'99902049',''),!(DocketNumber,eq,'05200048',''),!(DocketNumber,eq,'99902078',''),!(DocketNumber,eq,'05200050',''),!(DocketNumber,eq,'99902052',''),!(DocketNumber,eq,'99902069',''),!(DocketNumber,eq,'05007513',''),!(DocketNumber,eq,'05000611',''),!(DocketNumber,eq,'05000612',''),!(DocketNumber,eq,'99902095',''),!(DocketNumber,eq,'99902101',''),!(DocketNumber,eq,'05200049',''),!(DocketNumber,eq,'99902128',''),!(DocketNumber,eq,'99902136',''),!(DocketNumber,eq,'99902122',''),!(DocketNumber,eq,'99902056',''),!(DocketNumber,eq,'05000615','')),properties_search_all:!(!(PublishDatePARS,gt,'09/27/2019',''),!(PublishDatePARS,lt,'11/09/2019',''))))&qn=New&tab=advanced-search-pars&z=0 
#> : 0.93 sec elapsed
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search_any:!(!(DocketNumber,eq,'99902088',''),!(DocketNumber,eq,'05000610',''),!(DocketNumber,eq,'05000608',''),!(DocketNumber,eq,'99902115',''),!(DocketNumber,eq,'99902071',''),!(DocketNumber,eq,'07007027',''),!(DocketNumber,eq,'99902117',''),!(DocketNumber,eq,'99902111',''),!(DocketNumber,eq,'99902100',''),!(DocketNumber,eq,'05000613',''),!(DocketNumber,eq,'99902150',''),!(DocketNumber,eq,'99902094',''),!(DocketNumber,eq,'99902079',''),!(DocketNumber,eq,'99902076',''),!(DocketNumber,eq,'99900003',''),!(DocketNumber,eq,'99902049',''),!(DocketNumber,eq,'05200048',''),!(DocketNumber,eq,'99902078',''),!(DocketNumber,eq,'05200050',''),!(DocketNumber,eq,'99902052',''),!(DocketNumber,eq,'99902069',''),!(DocketNumber,eq,'05007513',''),!(DocketNumber,eq,'05000611',''),!(DocketNumber,eq,'05000612',''),!(DocketNumber,eq,'99902095',''),!(DocketNumber,eq,'99902101',''),!(DocketNumber,eq,'05200049',''),!(DocketNumber,eq,'99902128',''),!(DocketNumber,eq,'99902136',''),!(DocketNumber,eq,'99902122',''),!(DocketNumber,eq,'99902056',''),!(DocketNumber,eq,'05000615','')),properties_search_all:!(!(PublishDatePARS,gt,'11/09/2019',''),!(PublishDatePARS,lt,'12/23/2019',''))))&qn=New&tab=advanced-search-pars&z=0 
#> : 1.11 sec elapsed
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search_any:!(!(DocketNumber,eq,'99902088',''),!(DocketNumber,eq,'05000610',''),!(DocketNumber,eq,'05000608',''),!(DocketNumber,eq,'99902115',''),!(DocketNumber,eq,'99902071',''),!(DocketNumber,eq,'07007027',''),!(DocketNumber,eq,'99902117',''),!(DocketNumber,eq,'99902111',''),!(DocketNumber,eq,'99902100',''),!(DocketNumber,eq,'05000613',''),!(DocketNumber,eq,'99902150',''),!(DocketNumber,eq,'99902094',''),!(DocketNumber,eq,'99902079',''),!(DocketNumber,eq,'99902076',''),!(DocketNumber,eq,'99900003',''),!(DocketNumber,eq,'99902049',''),!(DocketNumber,eq,'05200048',''),!(DocketNumber,eq,'99902078',''),!(DocketNumber,eq,'05200050',''),!(DocketNumber,eq,'99902052',''),!(DocketNumber,eq,'99902069',''),!(DocketNumber,eq,'05007513',''),!(DocketNumber,eq,'05000611',''),!(DocketNumber,eq,'05000612',''),!(DocketNumber,eq,'99902095',''),!(DocketNumber,eq,'99902101',''),!(DocketNumber,eq,'05200049',''),!(DocketNumber,eq,'99902128',''),!(DocketNumber,eq,'99902136',''),!(DocketNumber,eq,'99902122',''),!(DocketNumber,eq,'99902056',''),!(DocketNumber,eq,'05000615','')),properties_search_all:!(!(PublishDatePARS,gt,'12/23/2019',''),!(PublishDatePARS,lt,'02/04/2020',''))))&qn=New&tab=advanced-search-pars&z=0 
#> : 0.879 sec elapsed
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search_any:!(!(DocketNumber,eq,'99902088',''),!(DocketNumber,eq,'05000610',''),!(DocketNumber,eq,'05000608',''),!(DocketNumber,eq,'99902115',''),!(DocketNumber,eq,'99902071',''),!(DocketNumber,eq,'07007027',''),!(DocketNumber,eq,'99902117',''),!(DocketNumber,eq,'99902111',''),!(DocketNumber,eq,'99902100',''),!(DocketNumber,eq,'05000613',''),!(DocketNumber,eq,'99902150',''),!(DocketNumber,eq,'99902094',''),!(DocketNumber,eq,'99902079',''),!(DocketNumber,eq,'99902076',''),!(DocketNumber,eq,'99900003',''),!(DocketNumber,eq,'99902049',''),!(DocketNumber,eq,'05200048',''),!(DocketNumber,eq,'99902078',''),!(DocketNumber,eq,'05200050',''),!(DocketNumber,eq,'99902052',''),!(DocketNumber,eq,'99902069',''),!(DocketNumber,eq,'05007513',''),!(DocketNumber,eq,'05000611',''),!(DocketNumber,eq,'05000612',''),!(DocketNumber,eq,'99902095',''),!(DocketNumber,eq,'99902101',''),!(DocketNumber,eq,'05200049',''),!(DocketNumber,eq,'99902128',''),!(DocketNumber,eq,'99902136',''),!(DocketNumber,eq,'99902122',''),!(DocketNumber,eq,'99902056',''),!(DocketNumber,eq,'05000615','')),properties_search_all:!(!(PublishDatePARS,gt,'02/04/2020',''),!(PublishDatePARS,lt,'03/19/2020',''))))&qn=New&tab=advanced-search-pars&z=0 
#> : 1.13 sec elapsed
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search_any:!(!(DocketNumber,eq,'99902088',''),!(DocketNumber,eq,'05000610',''),!(DocketNumber,eq,'05000608',''),!(DocketNumber,eq,'99902115',''),!(DocketNumber,eq,'99902071',''),!(DocketNumber,eq,'07007027',''),!(DocketNumber,eq,'99902117',''),!(DocketNumber,eq,'99902111',''),!(DocketNumber,eq,'99902100',''),!(DocketNumber,eq,'05000613',''),!(DocketNumber,eq,'99902150',''),!(DocketNumber,eq,'99902094',''),!(DocketNumber,eq,'99902079',''),!(DocketNumber,eq,'99902076',''),!(DocketNumber,eq,'99900003',''),!(DocketNumber,eq,'99902049',''),!(DocketNumber,eq,'05200048',''),!(DocketNumber,eq,'99902078',''),!(DocketNumber,eq,'05200050',''),!(DocketNumber,eq,'99902052',''),!(DocketNumber,eq,'99902069',''),!(DocketNumber,eq,'05007513',''),!(DocketNumber,eq,'05000611',''),!(DocketNumber,eq,'05000612',''),!(DocketNumber,eq,'99902095',''),!(DocketNumber,eq,'99902101',''),!(DocketNumber,eq,'05200049',''),!(DocketNumber,eq,'99902128',''),!(DocketNumber,eq,'99902136',''),!(DocketNumber,eq,'99902122',''),!(DocketNumber,eq,'99902056',''),!(DocketNumber,eq,'05000615','')),properties_search_all:!(!(PublishDatePARS,gt,'03/19/2020',''),!(PublishDatePARS,lt,'05/01/2020',''))))&qn=New&tab=advanced-search-pars&z=0 
#> : 1.076 sec elapsed
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search_any:!(!(DocketNumber,eq,'99902088',''),!(DocketNumber,eq,'05000610',''),!(DocketNumber,eq,'05000608',''),!(DocketNumber,eq,'99902115',''),!(DocketNumber,eq,'99902071',''),!(DocketNumber,eq,'07007027',''),!(DocketNumber,eq,'99902117',''),!(DocketNumber,eq,'99902111',''),!(DocketNumber,eq,'99902100',''),!(DocketNumber,eq,'05000613',''),!(DocketNumber,eq,'99902150',''),!(DocketNumber,eq,'99902094',''),!(DocketNumber,eq,'99902079',''),!(DocketNumber,eq,'99902076',''),!(DocketNumber,eq,'99900003',''),!(DocketNumber,eq,'99902049',''),!(DocketNumber,eq,'05200048',''),!(DocketNumber,eq,'99902078',''),!(DocketNumber,eq,'05200050',''),!(DocketNumber,eq,'99902052',''),!(DocketNumber,eq,'99902069',''),!(DocketNumber,eq,'05007513',''),!(DocketNumber,eq,'05000611',''),!(DocketNumber,eq,'05000612',''),!(DocketNumber,eq,'99902095',''),!(DocketNumber,eq,'99902101',''),!(DocketNumber,eq,'05200049',''),!(DocketNumber,eq,'99902128',''),!(DocketNumber,eq,'99902136',''),!(DocketNumber,eq,'99902122',''),!(DocketNumber,eq,'99902056',''),!(DocketNumber,eq,'05000615','')),properties_search_all:!(!(PublishDatePARS,gt,'05/01/2020',''),!(PublishDatePARS,lt,'06/14/2020',''))))&qn=New&tab=advanced-search-pars&z=0 
#> : 0.836 sec elapsed
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search_any:!(!(DocketNumber,eq,'99902088',''),!(DocketNumber,eq,'05000610',''),!(DocketNumber,eq,'05000608',''),!(DocketNumber,eq,'99902115',''),!(DocketNumber,eq,'99902071',''),!(DocketNumber,eq,'07007027',''),!(DocketNumber,eq,'99902117',''),!(DocketNumber,eq,'99902111',''),!(DocketNumber,eq,'99902100',''),!(DocketNumber,eq,'05000613',''),!(DocketNumber,eq,'99902150',''),!(DocketNumber,eq,'99902094',''),!(DocketNumber,eq,'99902079',''),!(DocketNumber,eq,'99902076',''),!(DocketNumber,eq,'99900003',''),!(DocketNumber,eq,'99902049',''),!(DocketNumber,eq,'05200048',''),!(DocketNumber,eq,'99902078',''),!(DocketNumber,eq,'05200050',''),!(DocketNumber,eq,'99902052',''),!(DocketNumber,eq,'99902069',''),!(DocketNumber,eq,'05007513',''),!(DocketNumber,eq,'05000611',''),!(DocketNumber,eq,'05000612',''),!(DocketNumber,eq,'99902095',''),!(DocketNumber,eq,'99902101',''),!(DocketNumber,eq,'05200049',''),!(DocketNumber,eq,'99902128',''),!(DocketNumber,eq,'99902136',''),!(DocketNumber,eq,'99902122',''),!(DocketNumber,eq,'99902056',''),!(DocketNumber,eq,'05000615','')),properties_search_all:!(!(PublishDatePARS,gt,'06/14/2020',''),!(PublishDatePARS,lt,'07/27/2020',''))))&qn=New&tab=advanced-search-pars&z=0 
#> : 1.153 sec elapsed
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search_any:!(!(DocketNumber,eq,'99902088',''),!(DocketNumber,eq,'05000610',''),!(DocketNumber,eq,'05000608',''),!(DocketNumber,eq,'99902115',''),!(DocketNumber,eq,'99902071',''),!(DocketNumber,eq,'07007027',''),!(DocketNumber,eq,'99902117',''),!(DocketNumber,eq,'99902111',''),!(DocketNumber,eq,'99902100',''),!(DocketNumber,eq,'05000613',''),!(DocketNumber,eq,'99902150',''),!(DocketNumber,eq,'99902094',''),!(DocketNumber,eq,'99902079',''),!(DocketNumber,eq,'99902076',''),!(DocketNumber,eq,'99900003',''),!(DocketNumber,eq,'99902049',''),!(DocketNumber,eq,'05200048',''),!(DocketNumber,eq,'99902078',''),!(DocketNumber,eq,'05200050',''),!(DocketNumber,eq,'99902052',''),!(DocketNumber,eq,'99902069',''),!(DocketNumber,eq,'05007513',''),!(DocketNumber,eq,'05000611',''),!(DocketNumber,eq,'05000612',''),!(DocketNumber,eq,'99902095',''),!(DocketNumber,eq,'99902101',''),!(DocketNumber,eq,'05200049',''),!(DocketNumber,eq,'99902128',''),!(DocketNumber,eq,'99902136',''),!(DocketNumber,eq,'99902122',''),!(DocketNumber,eq,'99902056',''),!(DocketNumber,eq,'05000615','')),properties_search_all:!(!(PublishDatePARS,gt,'07/27/2020',''),!(PublishDatePARS,lt,'09/09/2020',''))))&qn=New&tab=advanced-search-pars&z=0 
#> : 1.632 sec elapsed
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search_any:!(!(DocketNumber,eq,'99902088',''),!(DocketNumber,eq,'05000610',''),!(DocketNumber,eq,'05000608',''),!(DocketNumber,eq,'99902115',''),!(DocketNumber,eq,'99902071',''),!(DocketNumber,eq,'07007027',''),!(DocketNumber,eq,'99902117',''),!(DocketNumber,eq,'99902111',''),!(DocketNumber,eq,'99902100',''),!(DocketNumber,eq,'05000613',''),!(DocketNumber,eq,'99902150',''),!(DocketNumber,eq,'99902094',''),!(DocketNumber,eq,'99902079',''),!(DocketNumber,eq,'99902076',''),!(DocketNumber,eq,'99900003',''),!(DocketNumber,eq,'99902049',''),!(DocketNumber,eq,'05200048',''),!(DocketNumber,eq,'99902078',''),!(DocketNumber,eq,'05200050',''),!(DocketNumber,eq,'99902052',''),!(DocketNumber,eq,'99902069',''),!(DocketNumber,eq,'05007513',''),!(DocketNumber,eq,'05000611',''),!(DocketNumber,eq,'05000612',''),!(DocketNumber,eq,'99902095',''),!(DocketNumber,eq,'99902101',''),!(DocketNumber,eq,'05200049',''),!(DocketNumber,eq,'99902128',''),!(DocketNumber,eq,'99902136',''),!(DocketNumber,eq,'99902122',''),!(DocketNumber,eq,'99902056',''),!(DocketNumber,eq,'05000615','')),properties_search_all:!(!(PublishDatePARS,gt,'09/09/2020',''),!(PublishDatePARS,lt,'10/22/2020',''))))&qn=New&tab=advanced-search-pars&z=0 
#> : 8.385 sec elapsed
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search_any:!(!(DocketNumber,eq,'99902088',''),!(DocketNumber,eq,'05000610',''),!(DocketNumber,eq,'05000608',''),!(DocketNumber,eq,'99902115',''),!(DocketNumber,eq,'99902071',''),!(DocketNumber,eq,'07007027',''),!(DocketNumber,eq,'99902117',''),!(DocketNumber,eq,'99902111',''),!(DocketNumber,eq,'99902100',''),!(DocketNumber,eq,'05000613',''),!(DocketNumber,eq,'99902150',''),!(DocketNumber,eq,'99902094',''),!(DocketNumber,eq,'99902079',''),!(DocketNumber,eq,'99902076',''),!(DocketNumber,eq,'99900003',''),!(DocketNumber,eq,'99902049',''),!(DocketNumber,eq,'05200048',''),!(DocketNumber,eq,'99902078',''),!(DocketNumber,eq,'05200050',''),!(DocketNumber,eq,'99902052',''),!(DocketNumber,eq,'99902069',''),!(DocketNumber,eq,'05007513',''),!(DocketNumber,eq,'05000611',''),!(DocketNumber,eq,'05000612',''),!(DocketNumber,eq,'99902095',''),!(DocketNumber,eq,'99902101',''),!(DocketNumber,eq,'05200049',''),!(DocketNumber,eq,'99902128',''),!(DocketNumber,eq,'99902136',''),!(DocketNumber,eq,'99902122',''),!(DocketNumber,eq,'99902056',''),!(DocketNumber,eq,'05000615','')),properties_search_all:!(!(PublishDatePARS,gt,'10/22/2020',''),!(PublishDatePARS,lt,'12/04/2020',''))))&qn=New&tab=advanced-search-pars&z=0 
#> : 0.896 sec elapsed
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search_any:!(!(DocketNumber,eq,'99902088',''),!(DocketNumber,eq,'05000610',''),!(DocketNumber,eq,'05000608',''),!(DocketNumber,eq,'99902115',''),!(DocketNumber,eq,'99902071',''),!(DocketNumber,eq,'07007027',''),!(DocketNumber,eq,'99902117',''),!(DocketNumber,eq,'99902111',''),!(DocketNumber,eq,'99902100',''),!(DocketNumber,eq,'05000613',''),!(DocketNumber,eq,'99902150',''),!(DocketNumber,eq,'99902094',''),!(DocketNumber,eq,'99902079',''),!(DocketNumber,eq,'99902076',''),!(DocketNumber,eq,'99900003',''),!(DocketNumber,eq,'99902049',''),!(DocketNumber,eq,'05200048',''),!(DocketNumber,eq,'99902078',''),!(DocketNumber,eq,'05200050',''),!(DocketNumber,eq,'99902052',''),!(DocketNumber,eq,'99902069',''),!(DocketNumber,eq,'05007513',''),!(DocketNumber,eq,'05000611',''),!(DocketNumber,eq,'05000612',''),!(DocketNumber,eq,'99902095',''),!(DocketNumber,eq,'99902101',''),!(DocketNumber,eq,'05200049',''),!(DocketNumber,eq,'99902128',''),!(DocketNumber,eq,'99902136',''),!(DocketNumber,eq,'99902122',''),!(DocketNumber,eq,'99902056',''),!(DocketNumber,eq,'05000615','')),properties_search_all:!(!(PublishDatePARS,gt,'12/04/2020',''),!(PublishDatePARS,lt,'01/17/2021',''))))&qn=New&tab=advanced-search-pars&z=0 
#> : 0.943 sec elapsed
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search_any:!(!(DocketNumber,eq,'99902088',''),!(DocketNumber,eq,'05000610',''),!(DocketNumber,eq,'05000608',''),!(DocketNumber,eq,'99902115',''),!(DocketNumber,eq,'99902071',''),!(DocketNumber,eq,'07007027',''),!(DocketNumber,eq,'99902117',''),!(DocketNumber,eq,'99902111',''),!(DocketNumber,eq,'99902100',''),!(DocketNumber,eq,'05000613',''),!(DocketNumber,eq,'99902150',''),!(DocketNumber,eq,'99902094',''),!(DocketNumber,eq,'99902079',''),!(DocketNumber,eq,'99902076',''),!(DocketNumber,eq,'99900003',''),!(DocketNumber,eq,'99902049',''),!(DocketNumber,eq,'05200048',''),!(DocketNumber,eq,'99902078',''),!(DocketNumber,eq,'05200050',''),!(DocketNumber,eq,'99902052',''),!(DocketNumber,eq,'99902069',''),!(DocketNumber,eq,'05007513',''),!(DocketNumber,eq,'05000611',''),!(DocketNumber,eq,'05000612',''),!(DocketNumber,eq,'99902095',''),!(DocketNumber,eq,'99902101',''),!(DocketNumber,eq,'05200049',''),!(DocketNumber,eq,'99902128',''),!(DocketNumber,eq,'99902136',''),!(DocketNumber,eq,'99902122',''),!(DocketNumber,eq,'99902056',''),!(DocketNumber,eq,'05000615','')),properties_search_all:!(!(PublishDatePARS,gt,'01/17/2021',''),!(PublishDatePARS,lt,'03/01/2021',''))))&qn=New&tab=advanced-search-pars&z=0 
#> : 0.846 sec elapsed
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search_any:!(!(DocketNumber,eq,'99902088',''),!(DocketNumber,eq,'05000610',''),!(DocketNumber,eq,'05000608',''),!(DocketNumber,eq,'99902115',''),!(DocketNumber,eq,'99902071',''),!(DocketNumber,eq,'07007027',''),!(DocketNumber,eq,'99902117',''),!(DocketNumber,eq,'99902111',''),!(DocketNumber,eq,'99902100',''),!(DocketNumber,eq,'05000613',''),!(DocketNumber,eq,'99902150',''),!(DocketNumber,eq,'99902094',''),!(DocketNumber,eq,'99902079',''),!(DocketNumber,eq,'99902076',''),!(DocketNumber,eq,'99900003',''),!(DocketNumber,eq,'99902049',''),!(DocketNumber,eq,'05200048',''),!(DocketNumber,eq,'99902078',''),!(DocketNumber,eq,'05200050',''),!(DocketNumber,eq,'99902052',''),!(DocketNumber,eq,'99902069',''),!(DocketNumber,eq,'05007513',''),!(DocketNumber,eq,'05000611',''),!(DocketNumber,eq,'05000612',''),!(DocketNumber,eq,'99902095',''),!(DocketNumber,eq,'99902101',''),!(DocketNumber,eq,'05200049',''),!(DocketNumber,eq,'99902128',''),!(DocketNumber,eq,'99902136',''),!(DocketNumber,eq,'99902122',''),!(DocketNumber,eq,'99902056',''),!(DocketNumber,eq,'05000615','')),properties_search_all:!(!(PublishDatePARS,gt,'03/01/2021',''),!(PublishDatePARS,lt,'04/14/2021',''))))&qn=New&tab=advanced-search-pars&z=0 
#> : 1.049 sec elapsed
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search_any:!(!(DocketNumber,eq,'99902088',''),!(DocketNumber,eq,'05000610',''),!(DocketNumber,eq,'05000608',''),!(DocketNumber,eq,'99902115',''),!(DocketNumber,eq,'99902071',''),!(DocketNumber,eq,'07007027',''),!(DocketNumber,eq,'99902117',''),!(DocketNumber,eq,'99902111',''),!(DocketNumber,eq,'99902100',''),!(DocketNumber,eq,'05000613',''),!(DocketNumber,eq,'99902150',''),!(DocketNumber,eq,'99902094',''),!(DocketNumber,eq,'99902079',''),!(DocketNumber,eq,'99902076',''),!(DocketNumber,eq,'99900003',''),!(DocketNumber,eq,'99902049',''),!(DocketNumber,eq,'05200048',''),!(DocketNumber,eq,'99902078',''),!(DocketNumber,eq,'05200050',''),!(DocketNumber,eq,'99902052',''),!(DocketNumber,eq,'99902069',''),!(DocketNumber,eq,'05007513',''),!(DocketNumber,eq,'05000611',''),!(DocketNumber,eq,'05000612',''),!(DocketNumber,eq,'99902095',''),!(DocketNumber,eq,'99902101',''),!(DocketNumber,eq,'05200049',''),!(DocketNumber,eq,'99902128',''),!(DocketNumber,eq,'99902136',''),!(DocketNumber,eq,'99902122',''),!(DocketNumber,eq,'99902056',''),!(DocketNumber,eq,'05000615','')),properties_search_all:!(!(PublishDatePARS,gt,'04/14/2021',''),!(PublishDatePARS,lt,'05/27/2021',''))))&qn=New&tab=advanced-search-pars&z=0 
#> : 0.921 sec elapsed
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search_any:!(!(DocketNumber,eq,'99902088',''),!(DocketNumber,eq,'05000610',''),!(DocketNumber,eq,'05000608',''),!(DocketNumber,eq,'99902115',''),!(DocketNumber,eq,'99902071',''),!(DocketNumber,eq,'07007027',''),!(DocketNumber,eq,'99902117',''),!(DocketNumber,eq,'99902111',''),!(DocketNumber,eq,'99902100',''),!(DocketNumber,eq,'05000613',''),!(DocketNumber,eq,'99902150',''),!(DocketNumber,eq,'99902094',''),!(DocketNumber,eq,'99902079',''),!(DocketNumber,eq,'99902076',''),!(DocketNumber,eq,'99900003',''),!(DocketNumber,eq,'99902049',''),!(DocketNumber,eq,'05200048',''),!(DocketNumber,eq,'99902078',''),!(DocketNumber,eq,'05200050',''),!(DocketNumber,eq,'99902052',''),!(DocketNumber,eq,'99902069',''),!(DocketNumber,eq,'05007513',''),!(DocketNumber,eq,'05000611',''),!(DocketNumber,eq,'05000612',''),!(DocketNumber,eq,'99902095',''),!(DocketNumber,eq,'99902101',''),!(DocketNumber,eq,'05200049',''),!(DocketNumber,eq,'99902128',''),!(DocketNumber,eq,'99902136',''),!(DocketNumber,eq,'99902122',''),!(DocketNumber,eq,'99902056',''),!(DocketNumber,eq,'05000615','')),properties_search_all:!(!(PublishDatePARS,gt,'05/27/2021',''),!(PublishDatePARS,lt,'07/10/2021',''))))&qn=New&tab=advanced-search-pars&z=0 
#> : 0.77 sec elapsed
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search_any:!(!(DocketNumber,eq,'99902088',''),!(DocketNumber,eq,'05000610',''),!(DocketNumber,eq,'05000608',''),!(DocketNumber,eq,'99902115',''),!(DocketNumber,eq,'99902071',''),!(DocketNumber,eq,'07007027',''),!(DocketNumber,eq,'99902117',''),!(DocketNumber,eq,'99902111',''),!(DocketNumber,eq,'99902100',''),!(DocketNumber,eq,'05000613',''),!(DocketNumber,eq,'99902150',''),!(DocketNumber,eq,'99902094',''),!(DocketNumber,eq,'99902079',''),!(DocketNumber,eq,'99902076',''),!(DocketNumber,eq,'99900003',''),!(DocketNumber,eq,'99902049',''),!(DocketNumber,eq,'05200048',''),!(DocketNumber,eq,'99902078',''),!(DocketNumber,eq,'05200050',''),!(DocketNumber,eq,'99902052',''),!(DocketNumber,eq,'99902069',''),!(DocketNumber,eq,'05007513',''),!(DocketNumber,eq,'05000611',''),!(DocketNumber,eq,'05000612',''),!(DocketNumber,eq,'99902095',''),!(DocketNumber,eq,'99902101',''),!(DocketNumber,eq,'05200049',''),!(DocketNumber,eq,'99902128',''),!(DocketNumber,eq,'99902136',''),!(DocketNumber,eq,'99902122',''),!(DocketNumber,eq,'99902056',''),!(DocketNumber,eq,'05000615','')),properties_search_all:!(!(PublishDatePARS,gt,'07/10/2021',''),!(PublishDatePARS,lt,'08/22/2021',''))))&qn=New&tab=advanced-search-pars&z=0 
#> : 0.782 sec elapsed
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search_any:!(!(DocketNumber,eq,'99902088',''),!(DocketNumber,eq,'05000610',''),!(DocketNumber,eq,'05000608',''),!(DocketNumber,eq,'99902115',''),!(DocketNumber,eq,'99902071',''),!(DocketNumber,eq,'07007027',''),!(DocketNumber,eq,'99902117',''),!(DocketNumber,eq,'99902111',''),!(DocketNumber,eq,'99902100',''),!(DocketNumber,eq,'05000613',''),!(DocketNumber,eq,'99902150',''),!(DocketNumber,eq,'99902094',''),!(DocketNumber,eq,'99902079',''),!(DocketNumber,eq,'99902076',''),!(DocketNumber,eq,'99900003',''),!(DocketNumber,eq,'99902049',''),!(DocketNumber,eq,'05200048',''),!(DocketNumber,eq,'99902078',''),!(DocketNumber,eq,'05200050',''),!(DocketNumber,eq,'99902052',''),!(DocketNumber,eq,'99902069',''),!(DocketNumber,eq,'05007513',''),!(DocketNumber,eq,'05000611',''),!(DocketNumber,eq,'05000612',''),!(DocketNumber,eq,'99902095',''),!(DocketNumber,eq,'99902101',''),!(DocketNumber,eq,'05200049',''),!(DocketNumber,eq,'99902128',''),!(DocketNumber,eq,'99902136',''),!(DocketNumber,eq,'99902122',''),!(DocketNumber,eq,'99902056',''),!(DocketNumber,eq,'05000615','')),properties_search_all:!(!(PublishDatePARS,gt,'08/22/2021',''),!(PublishDatePARS,lt,'10/05/2021',''))))&qn=New&tab=advanced-search-pars&z=0 
#> : 0.848 sec elapsed
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search_any:!(!(DocketNumber,eq,'99902088',''),!(DocketNumber,eq,'05000610',''),!(DocketNumber,eq,'05000608',''),!(DocketNumber,eq,'99902115',''),!(DocketNumber,eq,'99902071',''),!(DocketNumber,eq,'07007027',''),!(DocketNumber,eq,'99902117',''),!(DocketNumber,eq,'99902111',''),!(DocketNumber,eq,'99902100',''),!(DocketNumber,eq,'05000613',''),!(DocketNumber,eq,'99902150',''),!(DocketNumber,eq,'99902094',''),!(DocketNumber,eq,'99902079',''),!(DocketNumber,eq,'99902076',''),!(DocketNumber,eq,'99900003',''),!(DocketNumber,eq,'99902049',''),!(DocketNumber,eq,'05200048',''),!(DocketNumber,eq,'99902078',''),!(DocketNumber,eq,'05200050',''),!(DocketNumber,eq,'99902052',''),!(DocketNumber,eq,'99902069',''),!(DocketNumber,eq,'05007513',''),!(DocketNumber,eq,'05000611',''),!(DocketNumber,eq,'05000612',''),!(DocketNumber,eq,'99902095',''),!(DocketNumber,eq,'99902101',''),!(DocketNumber,eq,'05200049',''),!(DocketNumber,eq,'99902128',''),!(DocketNumber,eq,'99902136',''),!(DocketNumber,eq,'99902122',''),!(DocketNumber,eq,'99902056',''),!(DocketNumber,eq,'05000615','')),properties_search_all:!(!(PublishDatePARS,gt,'10/05/2021',''),!(PublishDatePARS,lt,'11/17/2021',''))))&qn=New&tab=advanced-search-pars&z=0 
#> : 0.946 sec elapsed
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search_any:!(!(DocketNumber,eq,'99902088',''),!(DocketNumber,eq,'05000610',''),!(DocketNumber,eq,'05000608',''),!(DocketNumber,eq,'99902115',''),!(DocketNumber,eq,'99902071',''),!(DocketNumber,eq,'07007027',''),!(DocketNumber,eq,'99902117',''),!(DocketNumber,eq,'99902111',''),!(DocketNumber,eq,'99902100',''),!(DocketNumber,eq,'05000613',''),!(DocketNumber,eq,'99902150',''),!(DocketNumber,eq,'99902094',''),!(DocketNumber,eq,'99902079',''),!(DocketNumber,eq,'99902076',''),!(DocketNumber,eq,'99900003',''),!(DocketNumber,eq,'99902049',''),!(DocketNumber,eq,'05200048',''),!(DocketNumber,eq,'99902078',''),!(DocketNumber,eq,'05200050',''),!(DocketNumber,eq,'99902052',''),!(DocketNumber,eq,'99902069',''),!(DocketNumber,eq,'05007513',''),!(DocketNumber,eq,'05000611',''),!(DocketNumber,eq,'05000612',''),!(DocketNumber,eq,'99902095',''),!(DocketNumber,eq,'99902101',''),!(DocketNumber,eq,'05200049',''),!(DocketNumber,eq,'99902128',''),!(DocketNumber,eq,'99902136',''),!(DocketNumber,eq,'99902122',''),!(DocketNumber,eq,'99902056',''),!(DocketNumber,eq,'05000615','')),properties_search_all:!(!(PublishDatePARS,gt,'11/17/2021',''),!(PublishDatePARS,lt,'12/31/2021',''))))&qn=New&tab=advanced-search-pars&z=0 
#> : 0.9 sec elapsed
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search_any:!(!(DocketNumber,eq,'99902088',''),!(DocketNumber,eq,'05000610',''),!(DocketNumber,eq,'05000608',''),!(DocketNumber,eq,'99902115',''),!(DocketNumber,eq,'99902071',''),!(DocketNumber,eq,'07007027',''),!(DocketNumber,eq,'99902117',''),!(DocketNumber,eq,'99902111',''),!(DocketNumber,eq,'99902100',''),!(DocketNumber,eq,'05000613',''),!(DocketNumber,eq,'99902150',''),!(DocketNumber,eq,'99902094',''),!(DocketNumber,eq,'99902079',''),!(DocketNumber,eq,'99902076',''),!(DocketNumber,eq,'99900003',''),!(DocketNumber,eq,'99902049',''),!(DocketNumber,eq,'05200048',''),!(DocketNumber,eq,'99902078',''),!(DocketNumber,eq,'05200050',''),!(DocketNumber,eq,'99902052',''),!(DocketNumber,eq,'99902069',''),!(DocketNumber,eq,'05007513',''),!(DocketNumber,eq,'05000611',''),!(DocketNumber,eq,'05000612',''),!(DocketNumber,eq,'99902095',''),!(DocketNumber,eq,'99902101',''),!(DocketNumber,eq,'05200049',''),!(DocketNumber,eq,'99902128',''),!(DocketNumber,eq,'99902136',''),!(DocketNumber,eq,'99902122',''),!(DocketNumber,eq,'99902056',''),!(DocketNumber,eq,'05000615','')),properties_search_all:!(!(PublishDatePARS,gt,'12/31/2021',''),!(PublishDatePARS,lt,'02/12/2022',''))))&qn=New&tab=advanced-search-pars&z=0 
#> : 0.97 sec elapsed
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search_any:!(!(DocketNumber,eq,'99902088',''),!(DocketNumber,eq,'05000610',''),!(DocketNumber,eq,'05000608',''),!(DocketNumber,eq,'99902115',''),!(DocketNumber,eq,'99902071',''),!(DocketNumber,eq,'07007027',''),!(DocketNumber,eq,'99902117',''),!(DocketNumber,eq,'99902111',''),!(DocketNumber,eq,'99902100',''),!(DocketNumber,eq,'05000613',''),!(DocketNumber,eq,'99902150',''),!(DocketNumber,eq,'99902094',''),!(DocketNumber,eq,'99902079',''),!(DocketNumber,eq,'99902076',''),!(DocketNumber,eq,'99900003',''),!(DocketNumber,eq,'99902049',''),!(DocketNumber,eq,'05200048',''),!(DocketNumber,eq,'99902078',''),!(DocketNumber,eq,'05200050',''),!(DocketNumber,eq,'99902052',''),!(DocketNumber,eq,'99902069',''),!(DocketNumber,eq,'05007513',''),!(DocketNumber,eq,'05000611',''),!(DocketNumber,eq,'05000612',''),!(DocketNumber,eq,'99902095',''),!(DocketNumber,eq,'99902101',''),!(DocketNumber,eq,'05200049',''),!(DocketNumber,eq,'99902128',''),!(DocketNumber,eq,'99902136',''),!(DocketNumber,eq,'99902122',''),!(DocketNumber,eq,'99902056',''),!(DocketNumber,eq,'05000615','')),properties_search_all:!(!(PublishDatePARS,gt,'02/12/2022',''),!(PublishDatePARS,lt,'03/27/2022',''))))&qn=New&tab=advanced-search-pars&z=0 
#> : 1.113 sec elapsed
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search_any:!(!(DocketNumber,eq,'99902088',''),!(DocketNumber,eq,'05000610',''),!(DocketNumber,eq,'05000608',''),!(DocketNumber,eq,'99902115',''),!(DocketNumber,eq,'99902071',''),!(DocketNumber,eq,'07007027',''),!(DocketNumber,eq,'99902117',''),!(DocketNumber,eq,'99902111',''),!(DocketNumber,eq,'99902100',''),!(DocketNumber,eq,'05000613',''),!(DocketNumber,eq,'99902150',''),!(DocketNumber,eq,'99902094',''),!(DocketNumber,eq,'99902079',''),!(DocketNumber,eq,'99902076',''),!(DocketNumber,eq,'99900003',''),!(DocketNumber,eq,'99902049',''),!(DocketNumber,eq,'05200048',''),!(DocketNumber,eq,'99902078',''),!(DocketNumber,eq,'05200050',''),!(DocketNumber,eq,'99902052',''),!(DocketNumber,eq,'99902069',''),!(DocketNumber,eq,'05007513',''),!(DocketNumber,eq,'05000611',''),!(DocketNumber,eq,'05000612',''),!(DocketNumber,eq,'99902095',''),!(DocketNumber,eq,'99902101',''),!(DocketNumber,eq,'05200049',''),!(DocketNumber,eq,'99902128',''),!(DocketNumber,eq,'99902136',''),!(DocketNumber,eq,'99902122',''),!(DocketNumber,eq,'99902056',''),!(DocketNumber,eq,'05000615','')),properties_search_all:!(!(PublishDatePARS,gt,'03/27/2022',''),!(PublishDatePARS,lt,'05/10/2022',''))))&qn=New&tab=advanced-search-pars&z=0 
#> : 1.142 sec elapsed
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search_any:!(!(DocketNumber,eq,'99902088',''),!(DocketNumber,eq,'05000610',''),!(DocketNumber,eq,'05000608',''),!(DocketNumber,eq,'99902115',''),!(DocketNumber,eq,'99902071',''),!(DocketNumber,eq,'07007027',''),!(DocketNumber,eq,'99902117',''),!(DocketNumber,eq,'99902111',''),!(DocketNumber,eq,'99902100',''),!(DocketNumber,eq,'05000613',''),!(DocketNumber,eq,'99902150',''),!(DocketNumber,eq,'99902094',''),!(DocketNumber,eq,'99902079',''),!(DocketNumber,eq,'99902076',''),!(DocketNumber,eq,'99900003',''),!(DocketNumber,eq,'99902049',''),!(DocketNumber,eq,'05200048',''),!(DocketNumber,eq,'99902078',''),!(DocketNumber,eq,'05200050',''),!(DocketNumber,eq,'99902052',''),!(DocketNumber,eq,'99902069',''),!(DocketNumber,eq,'05007513',''),!(DocketNumber,eq,'05000611',''),!(DocketNumber,eq,'05000612',''),!(DocketNumber,eq,'99902095',''),!(DocketNumber,eq,'99902101',''),!(DocketNumber,eq,'05200049',''),!(DocketNumber,eq,'99902128',''),!(DocketNumber,eq,'99902136',''),!(DocketNumber,eq,'99902122',''),!(DocketNumber,eq,'99902056',''),!(DocketNumber,eq,'05000615','')),properties_search_all:!(!(PublishDatePARS,gt,'05/10/2022',''),!(PublishDatePARS,lt,'06/22/2022',''))))&qn=New&tab=advanced-search-pars&z=0 
#> : 0.999 sec elapsed
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search_any:!(!(DocketNumber,eq,'99902088',''),!(DocketNumber,eq,'05000610',''),!(DocketNumber,eq,'05000608',''),!(DocketNumber,eq,'99902115',''),!(DocketNumber,eq,'99902071',''),!(DocketNumber,eq,'07007027',''),!(DocketNumber,eq,'99902117',''),!(DocketNumber,eq,'99902111',''),!(DocketNumber,eq,'99902100',''),!(DocketNumber,eq,'05000613',''),!(DocketNumber,eq,'99902150',''),!(DocketNumber,eq,'99902094',''),!(DocketNumber,eq,'99902079',''),!(DocketNumber,eq,'99902076',''),!(DocketNumber,eq,'99900003',''),!(DocketNumber,eq,'99902049',''),!(DocketNumber,eq,'05200048',''),!(DocketNumber,eq,'99902078',''),!(DocketNumber,eq,'05200050',''),!(DocketNumber,eq,'99902052',''),!(DocketNumber,eq,'99902069',''),!(DocketNumber,eq,'05007513',''),!(DocketNumber,eq,'05000611',''),!(DocketNumber,eq,'05000612',''),!(DocketNumber,eq,'99902095',''),!(DocketNumber,eq,'99902101',''),!(DocketNumber,eq,'05200049',''),!(DocketNumber,eq,'99902128',''),!(DocketNumber,eq,'99902136',''),!(DocketNumber,eq,'99902122',''),!(DocketNumber,eq,'99902056',''),!(DocketNumber,eq,'05000615','')),properties_search_all:!(!(PublishDatePARS,gt,'06/22/2022',''),!(PublishDatePARS,lt,'08/05/2022',''))))&qn=New&tab=advanced-search-pars&z=0 
#> : 1.018 sec elapsed
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search_any:!(!(DocketNumber,eq,'99902088',''),!(DocketNumber,eq,'05000610',''),!(DocketNumber,eq,'05000608',''),!(DocketNumber,eq,'99902115',''),!(DocketNumber,eq,'99902071',''),!(DocketNumber,eq,'07007027',''),!(DocketNumber,eq,'99902117',''),!(DocketNumber,eq,'99902111',''),!(DocketNumber,eq,'99902100',''),!(DocketNumber,eq,'05000613',''),!(DocketNumber,eq,'99902150',''),!(DocketNumber,eq,'99902094',''),!(DocketNumber,eq,'99902079',''),!(DocketNumber,eq,'99902076',''),!(DocketNumber,eq,'99900003',''),!(DocketNumber,eq,'99902049',''),!(DocketNumber,eq,'05200048',''),!(DocketNumber,eq,'99902078',''),!(DocketNumber,eq,'05200050',''),!(DocketNumber,eq,'99902052',''),!(DocketNumber,eq,'99902069',''),!(DocketNumber,eq,'05007513',''),!(DocketNumber,eq,'05000611',''),!(DocketNumber,eq,'05000612',''),!(DocketNumber,eq,'99902095',''),!(DocketNumber,eq,'99902101',''),!(DocketNumber,eq,'05200049',''),!(DocketNumber,eq,'99902128',''),!(DocketNumber,eq,'99902136',''),!(DocketNumber,eq,'99902122',''),!(DocketNumber,eq,'99902056',''),!(DocketNumber,eq,'05000615','')),properties_search_all:!(!(PublishDatePARS,gt,'08/05/2022',''),!(PublishDatePARS,lt,'09/17/2022',''))))&qn=New&tab=advanced-search-pars&z=0 
#> : 1.175 sec elapsed
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search_any:!(!(DocketNumber,eq,'99902088',''),!(DocketNumber,eq,'05000610',''),!(DocketNumber,eq,'05000608',''),!(DocketNumber,eq,'99902115',''),!(DocketNumber,eq,'99902071',''),!(DocketNumber,eq,'07007027',''),!(DocketNumber,eq,'99902117',''),!(DocketNumber,eq,'99902111',''),!(DocketNumber,eq,'99902100',''),!(DocketNumber,eq,'05000613',''),!(DocketNumber,eq,'99902150',''),!(DocketNumber,eq,'99902094',''),!(DocketNumber,eq,'99902079',''),!(DocketNumber,eq,'99902076',''),!(DocketNumber,eq,'99900003',''),!(DocketNumber,eq,'99902049',''),!(DocketNumber,eq,'05200048',''),!(DocketNumber,eq,'99902078',''),!(DocketNumber,eq,'05200050',''),!(DocketNumber,eq,'99902052',''),!(DocketNumber,eq,'99902069',''),!(DocketNumber,eq,'05007513',''),!(DocketNumber,eq,'05000611',''),!(DocketNumber,eq,'05000612',''),!(DocketNumber,eq,'99902095',''),!(DocketNumber,eq,'99902101',''),!(DocketNumber,eq,'05200049',''),!(DocketNumber,eq,'99902128',''),!(DocketNumber,eq,'99902136',''),!(DocketNumber,eq,'99902122',''),!(DocketNumber,eq,'99902056',''),!(DocketNumber,eq,'05000615','')),properties_search_all:!(!(PublishDatePARS,gt,'09/17/2022',''),!(PublishDatePARS,lt,'10/31/2022',''))))&qn=New&tab=advanced-search-pars&z=0 
#> : 1.506 sec elapsed
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search_any:!(!(DocketNumber,eq,'99902088',''),!(DocketNumber,eq,'05000610',''),!(DocketNumber,eq,'05000608',''),!(DocketNumber,eq,'99902115',''),!(DocketNumber,eq,'99902071',''),!(DocketNumber,eq,'07007027',''),!(DocketNumber,eq,'99902117',''),!(DocketNumber,eq,'99902111',''),!(DocketNumber,eq,'99902100',''),!(DocketNumber,eq,'05000613',''),!(DocketNumber,eq,'99902150',''),!(DocketNumber,eq,'99902094',''),!(DocketNumber,eq,'99902079',''),!(DocketNumber,eq,'99902076',''),!(DocketNumber,eq,'99900003',''),!(DocketNumber,eq,'99902049',''),!(DocketNumber,eq,'05200048',''),!(DocketNumber,eq,'99902078',''),!(DocketNumber,eq,'05200050',''),!(DocketNumber,eq,'99902052',''),!(DocketNumber,eq,'99902069',''),!(DocketNumber,eq,'05007513',''),!(DocketNumber,eq,'05000611',''),!(DocketNumber,eq,'05000612',''),!(DocketNumber,eq,'99902095',''),!(DocketNumber,eq,'99902101',''),!(DocketNumber,eq,'05200049',''),!(DocketNumber,eq,'99902128',''),!(DocketNumber,eq,'99902136',''),!(DocketNumber,eq,'99902122',''),!(DocketNumber,eq,'99902056',''),!(DocketNumber,eq,'05000615','')),properties_search_all:!(!(PublishDatePARS,gt,'10/31/2022',''),!(PublishDatePARS,lt,'12/13/2022',''))))&qn=New&tab=advanced-search-pars&z=0 
#> : 1.508 sec elapsed
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search_any:!(!(DocketNumber,eq,'99902088',''),!(DocketNumber,eq,'05000610',''),!(DocketNumber,eq,'05000608',''),!(DocketNumber,eq,'99902115',''),!(DocketNumber,eq,'99902071',''),!(DocketNumber,eq,'07007027',''),!(DocketNumber,eq,'99902117',''),!(DocketNumber,eq,'99902111',''),!(DocketNumber,eq,'99902100',''),!(DocketNumber,eq,'05000613',''),!(DocketNumber,eq,'99902150',''),!(DocketNumber,eq,'99902094',''),!(DocketNumber,eq,'99902079',''),!(DocketNumber,eq,'99902076',''),!(DocketNumber,eq,'99900003',''),!(DocketNumber,eq,'99902049',''),!(DocketNumber,eq,'05200048',''),!(DocketNumber,eq,'99902078',''),!(DocketNumber,eq,'05200050',''),!(DocketNumber,eq,'99902052',''),!(DocketNumber,eq,'99902069',''),!(DocketNumber,eq,'05007513',''),!(DocketNumber,eq,'05000611',''),!(DocketNumber,eq,'05000612',''),!(DocketNumber,eq,'99902095',''),!(DocketNumber,eq,'99902101',''),!(DocketNumber,eq,'05200049',''),!(DocketNumber,eq,'99902128',''),!(DocketNumber,eq,'99902136',''),!(DocketNumber,eq,'99902122',''),!(DocketNumber,eq,'99902056',''),!(DocketNumber,eq,'05000615','')),properties_search_all:!(!(PublishDatePARS,gt,'12/13/2022',''),!(PublishDatePARS,lt,'01/26/2023',''))))&qn=New&tab=advanced-search-pars&z=0 
#> : 1.58 sec elapsed
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search_any:!(!(DocketNumber,eq,'99902088',''),!(DocketNumber,eq,'05000610',''),!(DocketNumber,eq,'05000608',''),!(DocketNumber,eq,'99902115',''),!(DocketNumber,eq,'99902071',''),!(DocketNumber,eq,'07007027',''),!(DocketNumber,eq,'99902117',''),!(DocketNumber,eq,'99902111',''),!(DocketNumber,eq,'99902100',''),!(DocketNumber,eq,'05000613',''),!(DocketNumber,eq,'99902150',''),!(DocketNumber,eq,'99902094',''),!(DocketNumber,eq,'99902079',''),!(DocketNumber,eq,'99902076',''),!(DocketNumber,eq,'99900003',''),!(DocketNumber,eq,'99902049',''),!(DocketNumber,eq,'05200048',''),!(DocketNumber,eq,'99902078',''),!(DocketNumber,eq,'05200050',''),!(DocketNumber,eq,'99902052',''),!(DocketNumber,eq,'99902069',''),!(DocketNumber,eq,'05007513',''),!(DocketNumber,eq,'05000611',''),!(DocketNumber,eq,'05000612',''),!(DocketNumber,eq,'99902095',''),!(DocketNumber,eq,'99902101',''),!(DocketNumber,eq,'05200049',''),!(DocketNumber,eq,'99902128',''),!(DocketNumber,eq,'99902136',''),!(DocketNumber,eq,'99902122',''),!(DocketNumber,eq,'99902056',''),!(DocketNumber,eq,'05000615','')),properties_search_all:!(!(PublishDatePARS,gt,'01/26/2023',''),!(PublishDatePARS,lt,'03/10/2023',''))))&qn=New&tab=advanced-search-pars&z=0 
#> : 3.422 sec elapsed
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search_any:!(!(DocketNumber,eq,'99902088',''),!(DocketNumber,eq,'05000610',''),!(DocketNumber,eq,'05000608',''),!(DocketNumber,eq,'99902115',''),!(DocketNumber,eq,'99902071',''),!(DocketNumber,eq,'07007027',''),!(DocketNumber,eq,'99902117',''),!(DocketNumber,eq,'99902111',''),!(DocketNumber,eq,'99902100',''),!(DocketNumber,eq,'05000613',''),!(DocketNumber,eq,'99902150',''),!(DocketNumber,eq,'99902094',''),!(DocketNumber,eq,'99902079',''),!(DocketNumber,eq,'99902076',''),!(DocketNumber,eq,'99900003',''),!(DocketNumber,eq,'99902049',''),!(DocketNumber,eq,'05200048',''),!(DocketNumber,eq,'99902078',''),!(DocketNumber,eq,'05200050',''),!(DocketNumber,eq,'99902052',''),!(DocketNumber,eq,'99902069',''),!(DocketNumber,eq,'05007513',''),!(DocketNumber,eq,'05000611',''),!(DocketNumber,eq,'05000612',''),!(DocketNumber,eq,'99902095',''),!(DocketNumber,eq,'99902101',''),!(DocketNumber,eq,'05200049',''),!(DocketNumber,eq,'99902128',''),!(DocketNumber,eq,'99902136',''),!(DocketNumber,eq,'99902122',''),!(DocketNumber,eq,'99902056',''),!(DocketNumber,eq,'05000615','')),properties_search_all:!(!(PublishDatePARS,gt,'03/10/2023',''),!(PublishDatePARS,lt,'04/23/2023',''))))&qn=New&tab=advanced-search-pars&z=0 
#> : 5.647 sec elapsed
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search_any:!(!(DocketNumber,eq,'99902088',''),!(DocketNumber,eq,'05000610',''),!(DocketNumber,eq,'05000608',''),!(DocketNumber,eq,'99902115',''),!(DocketNumber,eq,'99902071',''),!(DocketNumber,eq,'07007027',''),!(DocketNumber,eq,'99902117',''),!(DocketNumber,eq,'99902111',''),!(DocketNumber,eq,'99902100',''),!(DocketNumber,eq,'05000613',''),!(DocketNumber,eq,'99902150',''),!(DocketNumber,eq,'99902094',''),!(DocketNumber,eq,'99902079',''),!(DocketNumber,eq,'99902076',''),!(DocketNumber,eq,'99900003',''),!(DocketNumber,eq,'99902049',''),!(DocketNumber,eq,'05200048',''),!(DocketNumber,eq,'99902078',''),!(DocketNumber,eq,'05200050',''),!(DocketNumber,eq,'99902052',''),!(DocketNumber,eq,'99902069',''),!(DocketNumber,eq,'05007513',''),!(DocketNumber,eq,'05000611',''),!(DocketNumber,eq,'05000612',''),!(DocketNumber,eq,'99902095',''),!(DocketNumber,eq,'99902101',''),!(DocketNumber,eq,'05200049',''),!(DocketNumber,eq,'99902128',''),!(DocketNumber,eq,'99902136',''),!(DocketNumber,eq,'99902122',''),!(DocketNumber,eq,'99902056',''),!(DocketNumber,eq,'05000615','')),properties_search_all:!(!(PublishDatePARS,gt,'04/23/2023',''),!(PublishDatePARS,lt,'06/05/2023',''))))&qn=New&tab=advanced-search-pars&z=0 
#> : 4.111 sec elapsed
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search_any:!(!(DocketNumber,eq,'99902088',''),!(DocketNumber,eq,'05000610',''),!(DocketNumber,eq,'05000608',''),!(DocketNumber,eq,'99902115',''),!(DocketNumber,eq,'99902071',''),!(DocketNumber,eq,'07007027',''),!(DocketNumber,eq,'99902117',''),!(DocketNumber,eq,'99902111',''),!(DocketNumber,eq,'99902100',''),!(DocketNumber,eq,'05000613',''),!(DocketNumber,eq,'99902150',''),!(DocketNumber,eq,'99902094',''),!(DocketNumber,eq,'99902079',''),!(DocketNumber,eq,'99902076',''),!(DocketNumber,eq,'99900003',''),!(DocketNumber,eq,'99902049',''),!(DocketNumber,eq,'05200048',''),!(DocketNumber,eq,'99902078',''),!(DocketNumber,eq,'05200050',''),!(DocketNumber,eq,'99902052',''),!(DocketNumber,eq,'99902069',''),!(DocketNumber,eq,'05007513',''),!(DocketNumber,eq,'05000611',''),!(DocketNumber,eq,'05000612',''),!(DocketNumber,eq,'99902095',''),!(DocketNumber,eq,'99902101',''),!(DocketNumber,eq,'05200049',''),!(DocketNumber,eq,'99902128',''),!(DocketNumber,eq,'99902136',''),!(DocketNumber,eq,'99902122',''),!(DocketNumber,eq,'99902056',''),!(DocketNumber,eq,'05000615','')),properties_search_all:!(!(PublishDatePARS,gt,'06/05/2023',''),!(PublishDatePARS,lt,'07/18/2023',''))))&qn=New&tab=advanced-search-pars&z=0 
#> : 1.387 sec elapsed
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search_any:!(!(DocketNumber,eq,'99902088',''),!(DocketNumber,eq,'05000610',''),!(DocketNumber,eq,'05000608',''),!(DocketNumber,eq,'99902115',''),!(DocketNumber,eq,'99902071',''),!(DocketNumber,eq,'07007027',''),!(DocketNumber,eq,'99902117',''),!(DocketNumber,eq,'99902111',''),!(DocketNumber,eq,'99902100',''),!(DocketNumber,eq,'05000613',''),!(DocketNumber,eq,'99902150',''),!(DocketNumber,eq,'99902094',''),!(DocketNumber,eq,'99902079',''),!(DocketNumber,eq,'99902076',''),!(DocketNumber,eq,'99900003',''),!(DocketNumber,eq,'99902049',''),!(DocketNumber,eq,'05200048',''),!(DocketNumber,eq,'99902078',''),!(DocketNumber,eq,'05200050',''),!(DocketNumber,eq,'99902052',''),!(DocketNumber,eq,'99902069',''),!(DocketNumber,eq,'05007513',''),!(DocketNumber,eq,'05000611',''),!(DocketNumber,eq,'05000612',''),!(DocketNumber,eq,'99902095',''),!(DocketNumber,eq,'99902101',''),!(DocketNumber,eq,'05200049',''),!(DocketNumber,eq,'99902128',''),!(DocketNumber,eq,'99902136',''),!(DocketNumber,eq,'99902122',''),!(DocketNumber,eq,'99902056',''),!(DocketNumber,eq,'05000615','')),properties_search_all:!(!(PublishDatePARS,gt,'07/18/2023',''),!(PublishDatePARS,lt,'08/31/2023',''))))&qn=New&tab=advanced-search-pars&z=0 
#> : 2.014 sec elapsed
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search_any:!(!(DocketNumber,eq,'99902088',''),!(DocketNumber,eq,'05000610',''),!(DocketNumber,eq,'05000608',''),!(DocketNumber,eq,'99902115',''),!(DocketNumber,eq,'99902071',''),!(DocketNumber,eq,'07007027',''),!(DocketNumber,eq,'99902117',''),!(DocketNumber,eq,'99902111',''),!(DocketNumber,eq,'99902100',''),!(DocketNumber,eq,'05000613',''),!(DocketNumber,eq,'99902150',''),!(DocketNumber,eq,'99902094',''),!(DocketNumber,eq,'99902079',''),!(DocketNumber,eq,'99902076',''),!(DocketNumber,eq,'99900003',''),!(DocketNumber,eq,'99902049',''),!(DocketNumber,eq,'05200048',''),!(DocketNumber,eq,'99902078',''),!(DocketNumber,eq,'05200050',''),!(DocketNumber,eq,'99902052',''),!(DocketNumber,eq,'99902069',''),!(DocketNumber,eq,'05007513',''),!(DocketNumber,eq,'05000611',''),!(DocketNumber,eq,'05000612',''),!(DocketNumber,eq,'99902095',''),!(DocketNumber,eq,'99902101',''),!(DocketNumber,eq,'05200049',''),!(DocketNumber,eq,'99902128',''),!(DocketNumber,eq,'99902136',''),!(DocketNumber,eq,'99902122',''),!(DocketNumber,eq,'99902056',''),!(DocketNumber,eq,'05000615','')),properties_search_all:!(!(PublishDatePARS,gt,'08/31/2023',''),!(PublishDatePARS,lt,'10/13/2023',''))))&qn=New&tab=advanced-search-pars&z=0 
#> : 1.983 sec elapsed
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search_any:!(!(DocketNumber,eq,'99902088',''),!(DocketNumber,eq,'05000610',''),!(DocketNumber,eq,'05000608',''),!(DocketNumber,eq,'99902115',''),!(DocketNumber,eq,'99902071',''),!(DocketNumber,eq,'07007027',''),!(DocketNumber,eq,'99902117',''),!(DocketNumber,eq,'99902111',''),!(DocketNumber,eq,'99902100',''),!(DocketNumber,eq,'05000613',''),!(DocketNumber,eq,'99902150',''),!(DocketNumber,eq,'99902094',''),!(DocketNumber,eq,'99902079',''),!(DocketNumber,eq,'99902076',''),!(DocketNumber,eq,'99900003',''),!(DocketNumber,eq,'99902049',''),!(DocketNumber,eq,'05200048',''),!(DocketNumber,eq,'99902078',''),!(DocketNumber,eq,'05200050',''),!(DocketNumber,eq,'99902052',''),!(DocketNumber,eq,'99902069',''),!(DocketNumber,eq,'05007513',''),!(DocketNumber,eq,'05000611',''),!(DocketNumber,eq,'05000612',''),!(DocketNumber,eq,'99902095',''),!(DocketNumber,eq,'99902101',''),!(DocketNumber,eq,'05200049',''),!(DocketNumber,eq,'99902128',''),!(DocketNumber,eq,'99902136',''),!(DocketNumber,eq,'99902122',''),!(DocketNumber,eq,'99902056',''),!(DocketNumber,eq,'05000615','')),properties_search_all:!(!(PublishDatePARS,gt,'10/13/2023',''),!(PublishDatePARS,lt,'11/26/2023',''))))&qn=New&tab=advanced-search-pars&z=0 
#> : 2.349 sec elapsed
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search_any:!(!(DocketNumber,eq,'99902088',''),!(DocketNumber,eq,'05000610',''),!(DocketNumber,eq,'05000608',''),!(DocketNumber,eq,'99902115',''),!(DocketNumber,eq,'99902071',''),!(DocketNumber,eq,'07007027',''),!(DocketNumber,eq,'99902117',''),!(DocketNumber,eq,'99902111',''),!(DocketNumber,eq,'99902100',''),!(DocketNumber,eq,'05000613',''),!(DocketNumber,eq,'99902150',''),!(DocketNumber,eq,'99902094',''),!(DocketNumber,eq,'99902079',''),!(DocketNumber,eq,'99902076',''),!(DocketNumber,eq,'99900003',''),!(DocketNumber,eq,'99902049',''),!(DocketNumber,eq,'05200048',''),!(DocketNumber,eq,'99902078',''),!(DocketNumber,eq,'05200050',''),!(DocketNumber,eq,'99902052',''),!(DocketNumber,eq,'99902069',''),!(DocketNumber,eq,'05007513',''),!(DocketNumber,eq,'05000611',''),!(DocketNumber,eq,'05000612',''),!(DocketNumber,eq,'99902095',''),!(DocketNumber,eq,'99902101',''),!(DocketNumber,eq,'05200049',''),!(DocketNumber,eq,'99902128',''),!(DocketNumber,eq,'99902136',''),!(DocketNumber,eq,'99902122',''),!(DocketNumber,eq,'99902056',''),!(DocketNumber,eq,'05000615','')),properties_search_all:!(!(PublishDatePARS,gt,'11/26/2023',''),!(PublishDatePARS,lt,'01/08/2024',''))))&qn=New&tab=advanced-search-pars&z=0 
#> : 1.844 sec elapsed
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search_any:!(!(DocketNumber,eq,'99902088',''),!(DocketNumber,eq,'05000610',''),!(DocketNumber,eq,'05000608',''),!(DocketNumber,eq,'99902115',''),!(DocketNumber,eq,'99902071',''),!(DocketNumber,eq,'07007027',''),!(DocketNumber,eq,'99902117',''),!(DocketNumber,eq,'99902111',''),!(DocketNumber,eq,'99902100',''),!(DocketNumber,eq,'05000613',''),!(DocketNumber,eq,'99902150',''),!(DocketNumber,eq,'99902094',''),!(DocketNumber,eq,'99902079',''),!(DocketNumber,eq,'99902076',''),!(DocketNumber,eq,'99900003',''),!(DocketNumber,eq,'99902049',''),!(DocketNumber,eq,'05200048',''),!(DocketNumber,eq,'99902078',''),!(DocketNumber,eq,'05200050',''),!(DocketNumber,eq,'99902052',''),!(DocketNumber,eq,'99902069',''),!(DocketNumber,eq,'05007513',''),!(DocketNumber,eq,'05000611',''),!(DocketNumber,eq,'05000612',''),!(DocketNumber,eq,'99902095',''),!(DocketNumber,eq,'99902101',''),!(DocketNumber,eq,'05200049',''),!(DocketNumber,eq,'99902128',''),!(DocketNumber,eq,'99902136',''),!(DocketNumber,eq,'99902122',''),!(DocketNumber,eq,'99902056',''),!(DocketNumber,eq,'05000615','')),properties_search_all:!(!(PublishDatePARS,gt,'01/08/2024',''),!(PublishDatePARS,lt,'02/21/2024',''))))&qn=New&tab=advanced-search-pars&z=0 
#> : 1.989 sec elapsed
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search_any:!(!(DocketNumber,eq,'99902088',''),!(DocketNumber,eq,'05000610',''),!(DocketNumber,eq,'05000608',''),!(DocketNumber,eq,'99902115',''),!(DocketNumber,eq,'99902071',''),!(DocketNumber,eq,'07007027',''),!(DocketNumber,eq,'99902117',''),!(DocketNumber,eq,'99902111',''),!(DocketNumber,eq,'99902100',''),!(DocketNumber,eq,'05000613',''),!(DocketNumber,eq,'99902150',''),!(DocketNumber,eq,'99902094',''),!(DocketNumber,eq,'99902079',''),!(DocketNumber,eq,'99902076',''),!(DocketNumber,eq,'99900003',''),!(DocketNumber,eq,'99902049',''),!(DocketNumber,eq,'05200048',''),!(DocketNumber,eq,'99902078',''),!(DocketNumber,eq,'05200050',''),!(DocketNumber,eq,'99902052',''),!(DocketNumber,eq,'99902069',''),!(DocketNumber,eq,'05007513',''),!(DocketNumber,eq,'05000611',''),!(DocketNumber,eq,'05000612',''),!(DocketNumber,eq,'99902095',''),!(DocketNumber,eq,'99902101',''),!(DocketNumber,eq,'05200049',''),!(DocketNumber,eq,'99902128',''),!(DocketNumber,eq,'99902136',''),!(DocketNumber,eq,'99902122',''),!(DocketNumber,eq,'99902056',''),!(DocketNumber,eq,'05000615','')),properties_search_all:!(!(PublishDatePARS,gt,'02/21/2024',''),!(PublishDatePARS,lt,'04/04/2024',''))))&qn=New&tab=advanced-search-pars&z=0 
#> : 1.48 sec elapsed
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search_any:!(!(DocketNumber,eq,'99902088',''),!(DocketNumber,eq,'05000610',''),!(DocketNumber,eq,'05000608',''),!(DocketNumber,eq,'99902115',''),!(DocketNumber,eq,'99902071',''),!(DocketNumber,eq,'07007027',''),!(DocketNumber,eq,'99902117',''),!(DocketNumber,eq,'99902111',''),!(DocketNumber,eq,'99902100',''),!(DocketNumber,eq,'05000613',''),!(DocketNumber,eq,'99902150',''),!(DocketNumber,eq,'99902094',''),!(DocketNumber,eq,'99902079',''),!(DocketNumber,eq,'99902076',''),!(DocketNumber,eq,'99900003',''),!(DocketNumber,eq,'99902049',''),!(DocketNumber,eq,'05200048',''),!(DocketNumber,eq,'99902078',''),!(DocketNumber,eq,'05200050',''),!(DocketNumber,eq,'99902052',''),!(DocketNumber,eq,'99902069',''),!(DocketNumber,eq,'05007513',''),!(DocketNumber,eq,'05000611',''),!(DocketNumber,eq,'05000612',''),!(DocketNumber,eq,'99902095',''),!(DocketNumber,eq,'99902101',''),!(DocketNumber,eq,'05200049',''),!(DocketNumber,eq,'99902128',''),!(DocketNumber,eq,'99902136',''),!(DocketNumber,eq,'99902122',''),!(DocketNumber,eq,'99902056',''),!(DocketNumber,eq,'05000615','')),properties_search_all:!(!(PublishDatePARS,gt,'04/04/2024',''),!(PublishDatePARS,lt,'05/18/2024',''))))&qn=New&tab=advanced-search-pars&z=0 
#> : 1.472 sec elapsed
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search_any:!(!(DocketNumber,eq,'99902088',''),!(DocketNumber,eq,'05000610',''),!(DocketNumber,eq,'05000608',''),!(DocketNumber,eq,'99902115',''),!(DocketNumber,eq,'99902071',''),!(DocketNumber,eq,'07007027',''),!(DocketNumber,eq,'99902117',''),!(DocketNumber,eq,'99902111',''),!(DocketNumber,eq,'99902100',''),!(DocketNumber,eq,'05000613',''),!(DocketNumber,eq,'99902150',''),!(DocketNumber,eq,'99902094',''),!(DocketNumber,eq,'99902079',''),!(DocketNumber,eq,'99902076',''),!(DocketNumber,eq,'99900003',''),!(DocketNumber,eq,'99902049',''),!(DocketNumber,eq,'05200048',''),!(DocketNumber,eq,'99902078',''),!(DocketNumber,eq,'05200050',''),!(DocketNumber,eq,'99902052',''),!(DocketNumber,eq,'99902069',''),!(DocketNumber,eq,'05007513',''),!(DocketNumber,eq,'05000611',''),!(DocketNumber,eq,'05000612',''),!(DocketNumber,eq,'99902095',''),!(DocketNumber,eq,'99902101',''),!(DocketNumber,eq,'05200049',''),!(DocketNumber,eq,'99902128',''),!(DocketNumber,eq,'99902136',''),!(DocketNumber,eq,'99902122',''),!(DocketNumber,eq,'99902056',''),!(DocketNumber,eq,'05000615','')),properties_search_all:!(!(PublishDatePARS,gt,'05/18/2024',''),!(PublishDatePARS,lt,'06/30/2024',''))))&qn=New&tab=advanced-search-pars&z=0 
#> : 1.363 sec elapsed
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search_any:!(!(DocketNumber,eq,'99902088',''),!(DocketNumber,eq,'05000610',''),!(DocketNumber,eq,'05000608',''),!(DocketNumber,eq,'99902115',''),!(DocketNumber,eq,'99902071',''),!(DocketNumber,eq,'07007027',''),!(DocketNumber,eq,'99902117',''),!(DocketNumber,eq,'99902111',''),!(DocketNumber,eq,'99902100',''),!(DocketNumber,eq,'05000613',''),!(DocketNumber,eq,'99902150',''),!(DocketNumber,eq,'99902094',''),!(DocketNumber,eq,'99902079',''),!(DocketNumber,eq,'99902076',''),!(DocketNumber,eq,'99900003',''),!(DocketNumber,eq,'99902049',''),!(DocketNumber,eq,'05200048',''),!(DocketNumber,eq,'99902078',''),!(DocketNumber,eq,'05200050',''),!(DocketNumber,eq,'99902052',''),!(DocketNumber,eq,'99902069',''),!(DocketNumber,eq,'05007513',''),!(DocketNumber,eq,'05000611',''),!(DocketNumber,eq,'05000612',''),!(DocketNumber,eq,'99902095',''),!(DocketNumber,eq,'99902101',''),!(DocketNumber,eq,'05200049',''),!(DocketNumber,eq,'99902128',''),!(DocketNumber,eq,'99902136',''),!(DocketNumber,eq,'99902122',''),!(DocketNumber,eq,'99902056',''),!(DocketNumber,eq,'05000615','')),properties_search_all:!(!(PublishDatePARS,gt,'06/30/2024',''),!(PublishDatePARS,lt,'08/13/2024',''))))&qn=New&tab=advanced-search-pars&z=0 
#> : 8.116 sec elapsed
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search_any:!(!(DocketNumber,eq,'99902088',''),!(DocketNumber,eq,'05000610',''),!(DocketNumber,eq,'05000608',''),!(DocketNumber,eq,'99902115',''),!(DocketNumber,eq,'99902071',''),!(DocketNumber,eq,'07007027',''),!(DocketNumber,eq,'99902117',''),!(DocketNumber,eq,'99902111',''),!(DocketNumber,eq,'99902100',''),!(DocketNumber,eq,'05000613',''),!(DocketNumber,eq,'99902150',''),!(DocketNumber,eq,'99902094',''),!(DocketNumber,eq,'99902079',''),!(DocketNumber,eq,'99902076',''),!(DocketNumber,eq,'99900003',''),!(DocketNumber,eq,'99902049',''),!(DocketNumber,eq,'05200048',''),!(DocketNumber,eq,'99902078',''),!(DocketNumber,eq,'05200050',''),!(DocketNumber,eq,'99902052',''),!(DocketNumber,eq,'99902069',''),!(DocketNumber,eq,'05007513',''),!(DocketNumber,eq,'05000611',''),!(DocketNumber,eq,'05000612',''),!(DocketNumber,eq,'99902095',''),!(DocketNumber,eq,'99902101',''),!(DocketNumber,eq,'05200049',''),!(DocketNumber,eq,'99902128',''),!(DocketNumber,eq,'99902136',''),!(DocketNumber,eq,'99902122',''),!(DocketNumber,eq,'99902056',''),!(DocketNumber,eq,'05000615','')),properties_search_all:!(!(PublishDatePARS,gt,'08/13/2024',''),!(PublishDatePARS,lt,'09/25/2024',''))))&qn=New&tab=advanced-search-pars&z=0 
#> : 5.249 sec elapsed
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search_any:!(!(DocketNumber,eq,'99902088',''),!(DocketNumber,eq,'05000610',''),!(DocketNumber,eq,'05000608',''),!(DocketNumber,eq,'99902115',''),!(DocketNumber,eq,'99902071',''),!(DocketNumber,eq,'07007027',''),!(DocketNumber,eq,'99902117',''),!(DocketNumber,eq,'99902111',''),!(DocketNumber,eq,'99902100',''),!(DocketNumber,eq,'05000613',''),!(DocketNumber,eq,'99902150',''),!(DocketNumber,eq,'99902094',''),!(DocketNumber,eq,'99902079',''),!(DocketNumber,eq,'99902076',''),!(DocketNumber,eq,'99900003',''),!(DocketNumber,eq,'99902049',''),!(DocketNumber,eq,'05200048',''),!(DocketNumber,eq,'99902078',''),!(DocketNumber,eq,'05200050',''),!(DocketNumber,eq,'99902052',''),!(DocketNumber,eq,'99902069',''),!(DocketNumber,eq,'05007513',''),!(DocketNumber,eq,'05000611',''),!(DocketNumber,eq,'05000612',''),!(DocketNumber,eq,'99902095',''),!(DocketNumber,eq,'99902101',''),!(DocketNumber,eq,'05200049',''),!(DocketNumber,eq,'99902128',''),!(DocketNumber,eq,'99902136',''),!(DocketNumber,eq,'99902122',''),!(DocketNumber,eq,'99902056',''),!(DocketNumber,eq,'05000615','')),properties_search_all:!(!(PublishDatePARS,gt,'09/25/2024',''),!(PublishDatePARS,lt,'11/07/2024',''))))&qn=New&tab=advanced-search-pars&z=0 
#> : 15.767 sec elapsed
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search_any:!(!(DocketNumber,eq,'99902088',''),!(DocketNumber,eq,'05000610',''),!(DocketNumber,eq,'05000608',''),!(DocketNumber,eq,'99902115',''),!(DocketNumber,eq,'99902071',''),!(DocketNumber,eq,'07007027',''),!(DocketNumber,eq,'99902117',''),!(DocketNumber,eq,'99902111',''),!(DocketNumber,eq,'99902100',''),!(DocketNumber,eq,'05000613',''),!(DocketNumber,eq,'99902150',''),!(DocketNumber,eq,'99902094',''),!(DocketNumber,eq,'99902079',''),!(DocketNumber,eq,'99902076',''),!(DocketNumber,eq,'99900003',''),!(DocketNumber,eq,'99902049',''),!(DocketNumber,eq,'05200048',''),!(DocketNumber,eq,'99902078',''),!(DocketNumber,eq,'05200050',''),!(DocketNumber,eq,'99902052',''),!(DocketNumber,eq,'99902069',''),!(DocketNumber,eq,'05007513',''),!(DocketNumber,eq,'05000611',''),!(DocketNumber,eq,'05000612',''),!(DocketNumber,eq,'99902095',''),!(DocketNumber,eq,'99902101',''),!(DocketNumber,eq,'05200049',''),!(DocketNumber,eq,'99902128',''),!(DocketNumber,eq,'99902136',''),!(DocketNumber,eq,'99902122',''),!(DocketNumber,eq,'99902056',''),!(DocketNumber,eq,'05000615','')),properties_search_all:!(!(PublishDatePARS,gt,'11/07/2024',''),!(PublishDatePARS,lt,'12/21/2024',''))))&qn=New&tab=advanced-search-pars&z=0 
#> : 1.785 sec elapsed
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search_any:!(!(DocketNumber,eq,'99902088',''),!(DocketNumber,eq,'05000610',''),!(DocketNumber,eq,'05000608',''),!(DocketNumber,eq,'99902115',''),!(DocketNumber,eq,'99902071',''),!(DocketNumber,eq,'07007027',''),!(DocketNumber,eq,'99902117',''),!(DocketNumber,eq,'99902111',''),!(DocketNumber,eq,'99902100',''),!(DocketNumber,eq,'05000613',''),!(DocketNumber,eq,'99902150',''),!(DocketNumber,eq,'99902094',''),!(DocketNumber,eq,'99902079',''),!(DocketNumber,eq,'99902076',''),!(DocketNumber,eq,'99900003',''),!(DocketNumber,eq,'99902049',''),!(DocketNumber,eq,'05200048',''),!(DocketNumber,eq,'99902078',''),!(DocketNumber,eq,'05200050',''),!(DocketNumber,eq,'99902052',''),!(DocketNumber,eq,'99902069',''),!(DocketNumber,eq,'05007513',''),!(DocketNumber,eq,'05000611',''),!(DocketNumber,eq,'05000612',''),!(DocketNumber,eq,'99902095',''),!(DocketNumber,eq,'99902101',''),!(DocketNumber,eq,'05200049',''),!(DocketNumber,eq,'99902128',''),!(DocketNumber,eq,'99902136',''),!(DocketNumber,eq,'99902122',''),!(DocketNumber,eq,'99902056',''),!(DocketNumber,eq,'05000615','')),properties_search_all:!(!(PublishDatePARS,gt,'12/21/2024',''),!(PublishDatePARS,lt,'02/02/2025',''))))&qn=New&tab=advanced-search-pars&z=0 
#> : 1.645 sec elapsed
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search_any:!(!(DocketNumber,eq,'99902088',''),!(DocketNumber,eq,'05000610',''),!(DocketNumber,eq,'05000608',''),!(DocketNumber,eq,'99902115',''),!(DocketNumber,eq,'99902071',''),!(DocketNumber,eq,'07007027',''),!(DocketNumber,eq,'99902117',''),!(DocketNumber,eq,'99902111',''),!(DocketNumber,eq,'99902100',''),!(DocketNumber,eq,'05000613',''),!(DocketNumber,eq,'99902150',''),!(DocketNumber,eq,'99902094',''),!(DocketNumber,eq,'99902079',''),!(DocketNumber,eq,'99902076',''),!(DocketNumber,eq,'99900003',''),!(DocketNumber,eq,'99902049',''),!(DocketNumber,eq,'05200048',''),!(DocketNumber,eq,'99902078',''),!(DocketNumber,eq,'05200050',''),!(DocketNumber,eq,'99902052',''),!(DocketNumber,eq,'99902069',''),!(DocketNumber,eq,'05007513',''),!(DocketNumber,eq,'05000611',''),!(DocketNumber,eq,'05000612',''),!(DocketNumber,eq,'99902095',''),!(DocketNumber,eq,'99902101',''),!(DocketNumber,eq,'05200049',''),!(DocketNumber,eq,'99902128',''),!(DocketNumber,eq,'99902136',''),!(DocketNumber,eq,'99902122',''),!(DocketNumber,eq,'99902056',''),!(DocketNumber,eq,'05000615','')),properties_search_all:!(!(PublishDatePARS,gt,'02/02/2025',''),!(PublishDatePARS,lt,'03/18/2025',''))))&qn=New&tab=advanced-search-pars&z=0 
#> : 1.989 sec elapsed
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search_any:!(!(DocketNumber,eq,'99902088',''),!(DocketNumber,eq,'05000610',''),!(DocketNumber,eq,'05000608',''),!(DocketNumber,eq,'99902115',''),!(DocketNumber,eq,'99902071',''),!(DocketNumber,eq,'07007027',''),!(DocketNumber,eq,'99902117',''),!(DocketNumber,eq,'99902111',''),!(DocketNumber,eq,'99902100',''),!(DocketNumber,eq,'05000613',''),!(DocketNumber,eq,'99902150',''),!(DocketNumber,eq,'99902094',''),!(DocketNumber,eq,'99902079',''),!(DocketNumber,eq,'99902076',''),!(DocketNumber,eq,'99900003',''),!(DocketNumber,eq,'99902049',''),!(DocketNumber,eq,'05200048',''),!(DocketNumber,eq,'99902078',''),!(DocketNumber,eq,'05200050',''),!(DocketNumber,eq,'99902052',''),!(DocketNumber,eq,'99902069',''),!(DocketNumber,eq,'05007513',''),!(DocketNumber,eq,'05000611',''),!(DocketNumber,eq,'05000612',''),!(DocketNumber,eq,'99902095',''),!(DocketNumber,eq,'99902101',''),!(DocketNumber,eq,'05200049',''),!(DocketNumber,eq,'99902128',''),!(DocketNumber,eq,'99902136',''),!(DocketNumber,eq,'99902122',''),!(DocketNumber,eq,'99902056',''),!(DocketNumber,eq,'05000615','')),properties_search_all:!(!(PublishDatePARS,gt,'03/18/2025',''),!(PublishDatePARS,lt,'04/30/2025',''))))&qn=New&tab=advanced-search-pars&z=0 
#> : 1.712 sec elapsed
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search_any:!(!(DocketNumber,eq,'99902088',''),!(DocketNumber,eq,'05000610',''),!(DocketNumber,eq,'05000608',''),!(DocketNumber,eq,'99902115',''),!(DocketNumber,eq,'99902071',''),!(DocketNumber,eq,'07007027',''),!(DocketNumber,eq,'99902117',''),!(DocketNumber,eq,'99902111',''),!(DocketNumber,eq,'99902100',''),!(DocketNumber,eq,'05000613',''),!(DocketNumber,eq,'99902150',''),!(DocketNumber,eq,'99902094',''),!(DocketNumber,eq,'99902079',''),!(DocketNumber,eq,'99902076',''),!(DocketNumber,eq,'99900003',''),!(DocketNumber,eq,'99902049',''),!(DocketNumber,eq,'05200048',''),!(DocketNumber,eq,'99902078',''),!(DocketNumber,eq,'05200050',''),!(DocketNumber,eq,'99902052',''),!(DocketNumber,eq,'99902069',''),!(DocketNumber,eq,'05007513',''),!(DocketNumber,eq,'05000611',''),!(DocketNumber,eq,'05000612',''),!(DocketNumber,eq,'99902095',''),!(DocketNumber,eq,'99902101',''),!(DocketNumber,eq,'05200049',''),!(DocketNumber,eq,'99902128',''),!(DocketNumber,eq,'99902136',''),!(DocketNumber,eq,'99902122',''),!(DocketNumber,eq,'99902056',''),!(DocketNumber,eq,'05000615','')),properties_search_all:!(!(PublishDatePARS,gt,'04/30/2025',''),!(PublishDatePARS,lt,'06/13/2025',''))))&qn=New&tab=advanced-search-pars&z=0 
#> : 1.41 sec elapsed
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search_any:!(!(DocketNumber,eq,'99902088',''),!(DocketNumber,eq,'05000610',''),!(DocketNumber,eq,'05000608',''),!(DocketNumber,eq,'99902115',''),!(DocketNumber,eq,'99902071',''),!(DocketNumber,eq,'07007027',''),!(DocketNumber,eq,'99902117',''),!(DocketNumber,eq,'99902111',''),!(DocketNumber,eq,'99902100',''),!(DocketNumber,eq,'05000613',''),!(DocketNumber,eq,'99902150',''),!(DocketNumber,eq,'99902094',''),!(DocketNumber,eq,'99902079',''),!(DocketNumber,eq,'99902076',''),!(DocketNumber,eq,'99900003',''),!(DocketNumber,eq,'99902049',''),!(DocketNumber,eq,'05200048',''),!(DocketNumber,eq,'99902078',''),!(DocketNumber,eq,'05200050',''),!(DocketNumber,eq,'99902052',''),!(DocketNumber,eq,'99902069',''),!(DocketNumber,eq,'05007513',''),!(DocketNumber,eq,'05000611',''),!(DocketNumber,eq,'05000612',''),!(DocketNumber,eq,'99902095',''),!(DocketNumber,eq,'99902101',''),!(DocketNumber,eq,'05200049',''),!(DocketNumber,eq,'99902128',''),!(DocketNumber,eq,'99902136',''),!(DocketNumber,eq,'99902122',''),!(DocketNumber,eq,'99902056',''),!(DocketNumber,eq,'05000615','')),properties_search_all:!(!(PublishDatePARS,gt,'06/13/2025',''),!(PublishDatePARS,lt,'07/26/2025',''))))&qn=New&tab=advanced-search-pars&z=0 
#> : 1.628 sec elapsed
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search_any:!(!(DocketNumber,eq,'99902088',''),!(DocketNumber,eq,'05000610',''),!(DocketNumber,eq,'05000608',''),!(DocketNumber,eq,'99902115',''),!(DocketNumber,eq,'99902071',''),!(DocketNumber,eq,'07007027',''),!(DocketNumber,eq,'99902117',''),!(DocketNumber,eq,'99902111',''),!(DocketNumber,eq,'99902100',''),!(DocketNumber,eq,'05000613',''),!(DocketNumber,eq,'99902150',''),!(DocketNumber,eq,'99902094',''),!(DocketNumber,eq,'99902079',''),!(DocketNumber,eq,'99902076',''),!(DocketNumber,eq,'99900003',''),!(DocketNumber,eq,'99902049',''),!(DocketNumber,eq,'05200048',''),!(DocketNumber,eq,'99902078',''),!(DocketNumber,eq,'05200050',''),!(DocketNumber,eq,'99902052',''),!(DocketNumber,eq,'99902069',''),!(DocketNumber,eq,'05007513',''),!(DocketNumber,eq,'05000611',''),!(DocketNumber,eq,'05000612',''),!(DocketNumber,eq,'99902095',''),!(DocketNumber,eq,'99902101',''),!(DocketNumber,eq,'05200049',''),!(DocketNumber,eq,'99902128',''),!(DocketNumber,eq,'99902136',''),!(DocketNumber,eq,'99902122',''),!(DocketNumber,eq,'99902056',''),!(DocketNumber,eq,'05000615','')),properties_search_all:!(!(PublishDatePARS,gt,'07/26/2025',''),!(PublishDatePARS,lt,'09/08/2025',''))))&qn=New&tab=advanced-search-pars&z=0 
#> : 1.667 sec elapsed
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search_any:!(!(DocketNumber,eq,'99902088',''),!(DocketNumber,eq,'05000610',''),!(DocketNumber,eq,'05000608',''),!(DocketNumber,eq,'99902115',''),!(DocketNumber,eq,'99902071',''),!(DocketNumber,eq,'07007027',''),!(DocketNumber,eq,'99902117',''),!(DocketNumber,eq,'99902111',''),!(DocketNumber,eq,'99902100',''),!(DocketNumber,eq,'05000613',''),!(DocketNumber,eq,'99902150',''),!(DocketNumber,eq,'99902094',''),!(DocketNumber,eq,'99902079',''),!(DocketNumber,eq,'99902076',''),!(DocketNumber,eq,'99900003',''),!(DocketNumber,eq,'99902049',''),!(DocketNumber,eq,'05200048',''),!(DocketNumber,eq,'99902078',''),!(DocketNumber,eq,'05200050',''),!(DocketNumber,eq,'99902052',''),!(DocketNumber,eq,'99902069',''),!(DocketNumber,eq,'05007513',''),!(DocketNumber,eq,'05000611',''),!(DocketNumber,eq,'05000612',''),!(DocketNumber,eq,'99902095',''),!(DocketNumber,eq,'99902101',''),!(DocketNumber,eq,'05200049',''),!(DocketNumber,eq,'99902128',''),!(DocketNumber,eq,'99902136',''),!(DocketNumber,eq,'99902122',''),!(DocketNumber,eq,'99902056',''),!(DocketNumber,eq,'05000615','')),properties_search_all:!(!(PublishDatePARS,gt,'09/08/2025',''),!(PublishDatePARS,lt,'10/21/2025',''))))&qn=New&tab=advanced-search-pars&z=0 
#> : 1.529 sec elapsed
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search_any:!(!(DocketNumber,eq,'99902088',''),!(DocketNumber,eq,'05000610',''),!(DocketNumber,eq,'05000608',''),!(DocketNumber,eq,'99902115',''),!(DocketNumber,eq,'99902071',''),!(DocketNumber,eq,'07007027',''),!(DocketNumber,eq,'99902117',''),!(DocketNumber,eq,'99902111',''),!(DocketNumber,eq,'99902100',''),!(DocketNumber,eq,'05000613',''),!(DocketNumber,eq,'99902150',''),!(DocketNumber,eq,'99902094',''),!(DocketNumber,eq,'99902079',''),!(DocketNumber,eq,'99902076',''),!(DocketNumber,eq,'99900003',''),!(DocketNumber,eq,'99902049',''),!(DocketNumber,eq,'05200048',''),!(DocketNumber,eq,'99902078',''),!(DocketNumber,eq,'05200050',''),!(DocketNumber,eq,'99902052',''),!(DocketNumber,eq,'99902069',''),!(DocketNumber,eq,'05007513',''),!(DocketNumber,eq,'05000611',''),!(DocketNumber,eq,'05000612',''),!(DocketNumber,eq,'99902095',''),!(DocketNumber,eq,'99902101',''),!(DocketNumber,eq,'05200049',''),!(DocketNumber,eq,'99902128',''),!(DocketNumber,eq,'99902136',''),!(DocketNumber,eq,'99902122',''),!(DocketNumber,eq,'99902056',''),!(DocketNumber,eq,'05000615','')),properties_search_all:!(!(PublishDatePARS,gt,'10/21/2025',''))))&qn=New&tab=advanced-search-pars&z=0 
#> : 2.154 sec elapsed

docket_count = combined_dockets |>
  dplyr::count(Project, sort = TRUE)

docket_count |>
  DT::datatable()
```

## Docket Plots

### Bar Plots

There are too many document types coded by ADAMS to effectively show on
a plot (i.e., \> 180). As a result, the Type field is binned to
facilitate a bar plot of various reactor applications.

``` r
library(ggplot2)
docket_types = combined_dockets |>
  dplyr::mutate(
    Project = factor(Project, levels = docket_count |> dplyr::pull(Project)),
  ) |>
  nrcadams::simplify_type()

type_count = docket_types |>
  dplyr::filter(NLWR) |>
  dplyr::count(Type, sort = TRUE) |>
  dplyr::arrange(n)


plt = docket_types |>
  dplyr::mutate(Type = factor(Type, levels = type_count |> dplyr::pull(Type))) |>
  ggplot() +
    geom_bar(aes(y = Project, fill = Type)) +
    theme_bw() +
    scale_fill_brewer(palette="Set1") +
    labs(
      title = "Advanced Reactor ADAMS Documents",
      subtitle =  paste("as of", Sys.Date())
    ) +
    xlab("Document Count")

plt |> plotly::ggplotly(tooltip = c("Type", "count"))
```

The same data can also be plotted with the bars unstacked.

``` r
plt = docket_types |>
  dplyr::mutate(Type = factor(Type, levels = type_count |> dplyr::pull(Type))) |>
  ggplot() +
    geom_bar(aes(y = Project, fill = Type), position = position_dodge()) +
    theme_bw() +
    scale_fill_brewer(palette="Set1") +
    labs(
      title = "Advanced Reactor ADAMS Documents",
      subtitle =  paste("as of", Sys.Date())
    ) +
    xlab("Document Count")

plt |> plotly::ggplotly(tooltip = c("Type", "count"))
```

### Time Series

The plot below shows the number of documents submitted to a docket. Plot
order is sorted from highest number of documents, NuScale 50 MWe Part 52
to lowest number of documents, USO SFR Owner Pre-Applicatoin.

#### Cumulative Plots

The cumulative number of documents on a given ADAMS docket is also
presented as a function of document date. Due to the large number of
plots, **it is suggested that you use the interactive plot filter
function.** By clicking on a project name in the legend, you can remove
that project from the plot to better focus on the remaining projects.

``` r
plot_min_date = "2020-01-01" |> lubridate::ymd()

grouped_dockets = combined_dockets |>
  dplyr::group_by(Project) |>
  dplyr::arrange(`Publish Date`) |>
  dplyr::mutate(
    Project = factor(Project, levels = docket_count |> dplyr::pull(Project)),
    count = 1,
    `Document Count` = cumsum(count),
    `Publish Date` = `Publish Date` |> lubridate::as_date()
    ) 

plt = grouped_dockets |>
  dplyr::filter(`Publish Date` > plot_min_date) |>
  ggplot() +
    geom_step(aes(x = `Publish Date`, y = `Document Count`, color = Project)) +
    theme_bw() +
    theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) +
    labs(
      title = "Advanced Reactor ADAMS Documents",
      subtitle =  paste("as of", Sys.Date())
    ) +
    scale_y_continuous(
      breaks= seq(
        0, 
        max(grouped_dockets$`Document Count`), 
        by = 200
        )
      ) +
    scale_x_continuous(
      breaks= seq(
        min(plot_min_date), 
        max(grouped_dockets$`Publish Date` |> lubridate::as_date()) , 
        by = "quarter"
        )
      )
```

The data in linear scale:

``` r
plt |> plotly::ggplotly()
```

The data in a y axis semi log scale:

``` r
plt = plt + scale_y_log10() 
plt |> plotly::ggplotly()
```

#### Cumulative Plots (By Document Type)

**This section is a work in progress**

Dockets can often be cluttered by affidavits, meeting notices, and other
documents that can obscure insights. Reclassifying these documents using
the `simplify_type` function and then removing the `Other` type can help
see what is really going on in a docket. **Warning, in order to see what
is happening in each docket, the y-axis is allowed to rescale to each
docket. This can make comparing dockets difficult.**

``` r

grouped_project_type <-  combined_dockets |>
  nrcadams::simplify_type() |>
  dplyr::filter(!Type == "Other") |>
  dplyr::group_by(Project, Type) |>
  dplyr::arrange(`Publish Date`) |>
  dplyr::mutate(
    Project = factor(Project, levels = docket_count |> dplyr::pull(Project)),
    count = 1,
    `Document Count` = cumsum(count),
    `Publish Date` = `Publish Date` |> lubridate::as_date()
    ) 

plt <- grouped_project_type |>  
  dplyr::filter(lubridate::as_date(`Publish Date`) > plot_min_date) |>
  ggplot() +
    geom_step(aes(x = `Publish Date`, y = `Document Count`, color = Type)) +
    theme_bw() +
    theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) +
    labs(
      title = "Advanced Reactor ADAMS Documents",
      subtitle =  paste("as of", Sys.Date())
    ) +
    scale_x_continuous(
      breaks= seq(
        min(plot_min_date), 
        max(grouped_project_type$`Publish Date` |> lubridate::as_date()) , 
        by = "quarter"
        )
      ) +
    facet_grid(vars(Project), scales = "free_y")

plt |> plotly::ggplotly()
```

#### Smoothed Interaction Rates

The daily document rate provides a metric to gauge the level of
interactions between a project and the NRC at a given point in time.
Unlikely the cumulative plots, this metric is memory-less and thus is
not impacted by prior interactions. Due to the large number of plots,
**it is suggested that you use the interactive plot filter function.**
By clicking on a project name in the legend, you can remove that project
from the plot to better focus on the remaining projects.

``` r
smoothed_grouped_dockets = combined_dockets |>
  dplyr::arrange(`Publish Date`) |>
  dplyr::mutate(
    Project = factor(Project, levels = docket_count |> dplyr::pull(Project)),
    count = 1,
    `Day Published` = paste(
      `Publish Date` |> lubridate::year(), 
      `Publish Date` |> lubridate::month(), 
      `Publish Date` |> lubridate::day(),
      sep = '/'
      ) |> lubridate::ymd()
    ) |>
  dplyr::group_by(`Day Published`, Project) |>
  dplyr::summarise(`Daily Document Count` = sum(count)) |>
  dplyr::group_by(Project) |>
  tidyr::complete(
    `Day Published` = seq.Date(
      min(`Day Published`), 
      max(`Day Published`), 
      by = "day"
      ),
    fill = list(`Daily Document Count` = 0)
    ) |>
  dplyr::mutate(
    `Smoothed Daily Document Rate` = zoo::rollmean(
      `Daily Document Count`, k = 30, na.pad = TRUE, align = "center"
      )
    ) 

plt = smoothed_grouped_dockets |>
  dplyr::filter(`Day Published` > plot_min_date) |>
  ggplot() +
    geom_step(
      aes(x = `Day Published`, y = `Smoothed Daily Document Rate`, color = Project)
    ) +
    theme_bw() +
    labs(
      title = "Advanced Reactor ADAMS Documents",
      subtitle =  paste("as of", Sys.Date())
    ) +
  scale_y_continuous(
    breaks= seq(
      0, 
      max(smoothed_grouped_dockets$`Smoothed Daily Document Rate`, na.rm = TRUE), 
      by=1
      )
    ) +
  scale_x_date(
    breaks= seq(
      plot_min_date, 
      max(smoothed_grouped_dockets$`Day Published`), 
      by = "year")
    )

plt |> plotly::ggplotly()
```

Unfortunately, the data in this plot is a bit clustered so it is hard to
pinpoint the trend of any given docket. Facet plots can separate out any
given docket to more easily decipher trends.

``` r
facet_dockets =  smoothed_grouped_dockets |>
  dplyr::mutate(
    Project = dplyr::case_when(
      Project |> stringr::str_detect("Part 50") ~ Project |> stringr::str_replace(" Part 50", ""),
      Project |> stringr::str_detect("Part 52") ~ Project |> stringr::str_replace(" Part 52", ""),
      Project |> stringr::str_detect("Part 70") ~ Project |> stringr::str_replace(" Part 70", ""),
      TRUE ~ Project |> stringr::str_replace(" Pre-App.", "")
      )
    ) |>
  tidyr::pivot_longer(
    c(`Daily Document Count`, `Smoothed Daily Document Rate`), 
    names_to = "Plot Type",
    values_to = "count"
    ) |>
  dplyr::mutate(
    `Plot Type` = dplyr::case_when(
      `Plot Type` == "Daily Document Count" ~ "Raw Counts",
      TRUE ~ "Smoothed"
    ),
    count = count |> signif(1)
  )

plt = facet_dockets |>  
  dplyr::filter(`Day Published` > plot_min_date) |>
  ggplot() +
    geom_step(
      aes(x = `Day Published`, y = count, color = `Plot Type`)
    ) +
    theme_bw() +
    theme(legend.position="top") +
    labs(
      title = "Advanced Reactor ADAMS Documents",
      subtitle =  paste("as of", Sys.Date())
    ) +
  scale_y_continuous(
    breaks= seq(
      0, 
      6, 
      by=1
      ),
    limits = c(0,5.5)
    ) +
  scale_x_date(
    breaks= seq(
      plot_min_date, 
      max(facet_dockets$`Day Published`), 
      by = "year")
    ) +
  facet_grid(vars(Project)) +
  ylab("Daily Document Count")

plt |> plotly::ggplotly()
```

### Docket Statistics

With the basic docket information parsed in previous sections, basic
summary statistics can be computed to compare the state of various
dockets at a glance.

``` r
seconds_per_year = 365 * 24 *60 *60
smoothed_grouped_dockets |>
  dplyr::group_by(Project) |>
  dplyr::summarise(
    `First Date` = min(`Day Published`[`Daily Document Count` > 0]),
    `Last Date` = max(`Day Published`[`Daily Document Count` > 0]),
    `Total` = sum(`Daily Document Count`),
    `Years` = round(lubridate::interval(`First Date`, `Last Date`) |> lubridate::int_length() / seconds_per_year, digits = 2),
    `Yearly Rate` = round(Total / Years, digits = 2)
    ) |>
  DT::datatable()
```

## Reports

This section is updated once a day and presents the Topical Reports,
Technical Reports, Environmental Reports, and Safety Evaluations
available on new reactor dockets. The last update was at 2025-12-04
21:19:00.847939. The following dockets are searched:

- MSRR Pre-Application
- MSRR Part 50
- Shine Part 50
- Shine Recycling Pre-Application
- Xe-100 Pre-Application
- TRISO-X Fab. Part 70
- Long Mott Pre-Application
- AP300
- Natrium Pre-Application
- Natrium Part 50
- USO SFR Owner Pre-Applicatoin
- UIUC HTGR Pre-Application
- eVinci Pre-Application
- IMSR Pre-Application
- BWRX-300 Pre-Application
- SMR-300 Pre-Application
- NuScale 50 MWe Part 52
- NuScale 77 MWe Pre-Application
- NuScale 77 MWe Part 52
- Carbon Free Power Project
- KP Pre-Application
- Hermes Part 50
- Hermes 2 Part 50
- Hermes 2 Unit 2 Part 50
- Oklo Reactor Pre-Application
- Oklo Fuel Cycle Pre-Application
- Aurora Part 52
- Aalo-1 Pre-Application
- RELLIS ESP Pre-Application
- Natura Pre-Application
- BWRX-300 Clinch River Pre-Application
- BWRX-300 Clinch River Part 50

### Topical Reports

The following table summarizes tagged Topical Reports.

``` r
Topicals = combined_dockets |>
  nrcadams::remove_noisy_files("Topical Report")

Topicals |>
  DT::datatable(
    caption = "Topical Reports",
    filter = list(position = 'top', clear = TRUE, plain = FALSE),
    escape = FALSE
    )
```

### Technical Paper

The following table summarizes tagged Technical Reports.

``` r
Technicals = combined_dockets |>
  nrcadams::remove_noisy_files("Technical")

Technicals |>
  DT::datatable(
    caption = "Technical Paper",
    filter = list(position = 'top', clear = TRUE, plain = FALSE),
    escape = FALSE
    )
```

### Environmental Reports

The following table summarizes tagged Environmental Reports.

``` r
Environmental = combined_dockets |>
  nrcadams::remove_noisy_files("Environmental")

Environmental |>
  DT::datatable(
    caption = "Environmental Reports",
    filter = list(position = 'top', clear = TRUE, plain = FALSE),
    escape = FALSE
    )
```

### Safety Analysis Reports

The following table summarizes tagged Safety Analysis Reports.

``` r
Safety_Analysis = combined_dockets |>
  nrcadams::remove_noisy_files("Safety Analysis")

Safety_Analysis |>
  DT::datatable(
    caption = "Safety Analysis Documents",
    filter = list(position = 'top', clear = TRUE, plain = FALSE),
    escape = FALSE
    )
```

### Safety Evaluations Reports

The following table summarizes tagged Safety Evaluations Reports.

``` r
Safety_Evaluation = combined_dockets |>
  nrcadams::remove_noisy_files("Safety Evaluation")

Safety_Evaluation |>
  DT::datatable(
    caption = "Safety Evaluation Documents",
    filter = list(position = 'top', clear = TRUE, plain = FALSE),
    escape = FALSE
    )
```
