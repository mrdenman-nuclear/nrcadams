# Conduct ADAMS Search on ML numbers

Conduct ADAMS Search on ML numbers

## Usage

``` r
search_ml(ML_number, adams_key = Sys.getenv("ADAMS"))
```

## Source

<https://adams-search.nrc.gov/assets/APS-API-Guide.pdf>

## Arguments

- ML_number:

  chr/vector: ML number (or numbers) to be searched on ADAMS. All
  searches must start with ML but partial ML numbers can be searched for
  in addition to full ML numbers.

## Value

tibble of search results

## Examples

``` r
nrcadams::search_ml(ML_number = c("ML19211C119", "ML20014E642", "ML22179A346"))
#> # A tibble: 3 × 9
#> Warning: unknown timezone 'EDT'
#> Warning: unknown timezone 'EDT'
#>   DocketNumber `ML Number` Title       `Document Date` `Publish Date`      Type 
#>          <dbl> <chr>       <chr>       <date>          <dttm>              <chr>
#> 1      5000608 ML19211C119 "SHINE Med… 2019-07-17      2019-08-13 14:46:00 Fina…
#> 2     99902069 ML20014E642 "Kairos Po… 2020-02-06      2020-03-06 12:33:00 Lett…
#> 3           NA ML22179A346 "NUREG-218… 2022-06-30      2022-07-05 12:26:00 NURE…
#> # ℹ 3 more variables: Affiliation <chr>, URL <chr>, count <dbl>
```
