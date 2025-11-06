# Makes a Formatted Tibble from ADAMS URL Search Results

Makes a Formatted Tibble from ADAMS URL Search Results

## Usage

``` r
make_results_tibble_no_docket(adams_url, tag_chr = NULL, download = FALSE)
```

## Source

<https://www.nrc.gov/site-help/developers/wba-api-developer-guide.pdf>

## Arguments

- adams_url:

  ADAMS search URL

- tag_chr:

  tag associted with the search result

- download:

  Logical, if set to true, the file is downloaded before it is processed

## Value

vector of search term results

## Examples

``` r
"https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search_any:!(!(DocketNumber,eq,'99902088','')),properties_search_all:!(!(PublishDatePARS,gt,'01/05/2023',''))))&qn=New&tab=advanced-search-pars&z=0" |>
nrcadams:::make_results_tibble()
#> # A tibble: 24 × 8
#> Warning: unknown timezone 'EDT'
#> Warning: unknown timezone 'EDT'
#>    Title             `Document Date` `Publish Date`      Type  Affiliation URL  
#>    <chr>             <date>          <dttm>              <chr> <chr>       <chr>
#>  1 Hadron Energy, I… 2025-10-14      2025-10-22 08:08:00 Lett… Hadron Ene… "htt…
#>  2 Hadron Energy, I… 2025-09-19      2025-09-29 08:06:00 Lett… Hadron Ene… "htt…
#>  3 Appendices for R… 2024-04-30      2024-05-08 08:32:00 - No… Abilene Ch… "htt…
#>  4 Appendices for R… 2024-04-30      2024-05-08 08:32:00 - No… Abilene Ch… "htt…
#>  5 Abilene Christia… 2024-04-30      2024-05-08 08:32:00 Lett… Abilene Ch… "htt…
#>  6 Abilene Christia… 2024-04-30      2024-05-08 08:32:00 Lett… Abilene Ch… "htt…
#>  7 Submittal of Abi… 2024-04-26      2024-05-06 08:32:00 Lett… Abilene Ch… "htt…
#>  8 Submittal of Abi… 2024-04-26      2024-05-06 08:32:00 Lett… Abilene Ch… "htt…
#>  9 Abilene Christia… 2023-04-13      2023-09-22 08:39:00 Meet… Abilene Ch… "htt…
#> 10 Abilene Christia… 2023-04-13      2023-09-22 08:39:00 Meet… Abilene Ch… "htt…
#> # ℹ 14 more rows
#> # ℹ 2 more variables: DocketNumber <dbl>, `ML Number` <chr>
```
