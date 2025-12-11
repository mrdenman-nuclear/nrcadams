# Conduct ADAMS Search on Docket Numbers

Conduct ADAMS Search on Docket Numbers

## Usage

``` r
search_docket(
  DocketNumber,
  search_term = NA,
  days_back = NA,
  start_date = NA,
  end_date = NA,
  document_type = NA
)
```

## Source

<https://www.nrc.gov/site-help/developers/wba-api-developer-guide.pdf>

## Arguments

- DocketNumber:

  dbl/vector: Docket number (or numbers) to be searched on ADAMS

- search_term:

  chr: Any search term desired. Default is nothing (i.e., NA)

- days_back:

  dbl: Length of time the search extends in days since the document was
  published on ADAMS? Default is all time (i.e, NA). Cannot be used with
  start_date or end_date.

- start_date:

  chr: The earliest date (ymd) search results should be returned. Cannot
  be used with days_back.

- end_date:

  chr: The latest date (ymd) search results should be returned. Cannot
  be used with days_back.

- document_type:

  chr: Type of ADAMS document

## Value

tibble of search results

## Examples

``` r
  nrcadams::docket_codex |>
    dplyr::filter(Company == "ACU") |>
    dplyr::pull(DocketNumber) |>
    nrcadams::search_docket()
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search_any:!(!(DocketNumber,eq,'99902088',''),!(DocketNumber,eq,'05000610',''))))&qn=New&tab=advanced-search-pars&z=0 
#> : 1.284 sec elapsed
#> 
#>  This search returned: 228 files.
#> # A tibble: 228 × 8
#> Warning: unknown timezone 'EDT'
#> Warning: unknown timezone 'EDT'
#>    Title             `Document Date` `Publish Date`      Type  Affiliation URL  
#>    <chr>             <date>          <dttm>              <chr> <chr>       <chr>
#>  1 Hadron Energy, I… 2025-10-14      2025-10-22 08:08:00 Lett… Hadron Ene… "htt…
#>  2 Hadron Energy, I… 2025-09-19      2025-09-29 08:06:00 Lett… Hadron Ene… "htt…
#>  3 Enclosure 3: Req… 2025-09-15      2025-09-23 08:12:00 Prop… Natura Res… "htt…
#>  4 Abilene Christia… 2025-09-15      2025-09-23 08:12:00 Lett… Abilene Ch… "htt…
#>  5 Enclosure 2: Deg… 2025-09-15      2025-09-23 08:12:00 Repo… Abilene Ch… "htt…
#>  6 Meeting Summary … 2025-07-24      2025-07-24 15:07:00 Meet… NRC/NRR     "htt…
#>  7 05/28/2025 Publi… 2025-05-28      2025-05-28 09:42:00 Meet… NRC/NRR     "htt…
#>  8 ACU MSRR Fuel Qu… 2025-05-28      2025-05-28 09:27:00 Slid… Abilene Ch… "htt…
#>  9 Meeting Slides -… 2025-05-27      2025-05-27 12:31:00 Meet… NRC/NRR     "htt…
#> 10 Request for With… 2025-05-13      2025-05-13 11:32:00 Lett… NRC/NRR     "htt…
#> # ℹ 218 more rows
#> # ℹ 2 more variables: DocketNumber <dbl>, `ML Number` <chr>
```
