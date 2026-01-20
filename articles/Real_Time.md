# Last Week in Dockets

This page is updated Monday through Friday, hourly between 9AM ET and 5
PM ET. The last update was at 2026-01-20 10:30:19.602133 ET.

``` r
last_week_in_dockets <- nrcadams::docket_codex |>
  dplyr::pull(DocketNumber) |>
  nrcadams::search_docket(days_back = 7) |>
  dplyr::left_join(nrcadams::docket_codex) |>
  dplyr::filter(!is.na(Project))
#> 
#>  This search returned: 30 files.
#> Joining with `by = join_by(DocketNumber)`

build_html_table <- function(docket_tbl, LWR) {
  if (LWR) {
    docket_tbl = docket_tbl |>
      dplyr::filter(!NLWR)
    title = "The Last 7 Days of Posted LWR Licensing Documents."
  } else {
    docket_tbl = docket_tbl |>
      dplyr::filter(NLWR)
    title = "The Last 7 Days of Posted NLWR Licensing Documents."
  }
    
docket_tbl |> 
  nrcadams::hyperlink_file_to_name() |>
  dplyr::select(-c(Company, DocketNumber, NLWR)) |>
  DT::datatable(
    caption = title,
    filter = list(position = 'top', clear = TRUE, plain = FALSE),
    escape = FALSE
    )
}

docket_count = last_week_in_dockets |>
  dplyr::count(Project, sort = TRUE)

docket_count |>
  DT::datatable()
```

``` r
library(ggplot2)
library(plotly)
#> 
#> Attaching package: 'plotly'
#> The following object is masked from 'package:ggplot2':
#> 
#>     last_plot
#> The following object is masked from 'package:stats':
#> 
#>     filter
#> The following object is masked from 'package:graphics':
#> 
#>     layout
plt = last_week_in_dockets |>
  dplyr::mutate(
    Project = factor(Project, levels = docket_count |> dplyr::pull(Project))
  ) |> 
  nrcadams::simplify_type() |>
  ggplot() +
    geom_bar(aes(y = Project, fill = Type)) +
    scale_fill_brewer(palette="Set1") +
    theme_bw() +
    labs(
      title = "New Advanced Reactor ADAMS Documents",
      subtitle =  paste("the week before", Sys.Date())
    ) +
    xlab("Document Count")

plt |> ggplotly(tooltip = c("count", "Type"))
```

## Non-Light Water Reactor Docket Search

The following table summarizes all ADAMS documents for the following
dockets:

- MSRR Pre-Application
- MSRR Part 50
- Shine Part 50
- Shine Recycling Pre-Application
- Xe-100 Pre-Application
- TRISO-X Fab. Part 70
- Long Mott Pre-Application
- Long Mott Part 50
- Natrium Pre-Application
- Natrium Part 50
- USO SFR Owner Pre-Applicatoin
- UIUC HTGR Pre-Application
- eVinci Pre-Application
- IMSR Pre-Application
- KP Pre-Application
- Hermes Part 50
- Hermes 2 Part 50
- Hermes 2 Unit 2 Part 50
- Oklo Reactor Pre-Application
- Oklo Fuel Cycle Pre-Application
- Aurora Part 52
- Aalo-1 Pre-Application
- Natura Pre-Application

``` r
last_week_in_dockets |> 
  build_html_table(LWR = FALSE)
```

## Light Water Reactor Docket Search

The following table summarizes all ADAMS documents for the following
dockets:

- AP300
- BWRX-300 Pre-Application
- SMR-300 Pre-Application
- NuScale 50 MWe Part 52
- NuScale 77 MWe Pre-Application
- NuScale 77 MWe Part 52
- Carbon Free Power Project
- RELLIS ESP Pre-Application
- BWRX-300 Clinch River Pre-Application
- BWRX-300 Clinch River Part 50

``` r
last_week_in_dockets |> 
  build_html_table(LWR = TRUE)
```
