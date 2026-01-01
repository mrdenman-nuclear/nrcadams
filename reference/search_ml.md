# Conduct ADAMS Search on ML numbers

Conduct ADAMS Search on ML numbers

## Usage

``` r
search_ml(ML_number)
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
#> [1] "ML19211C119"
#> [1] "ML20014E642"
#> Joining with `by = join_by(Title, `Document Date`, `Publish Date`, Type,
#> Affiliation, URL, DocketNumber, `ML Number`)`
#> [1] "ML22179A346"
#> Joining with `by = join_by(Title, `Document Date`, `Publish Date`, Type,
#> Affiliation, URL, DocketNumber, `ML Number`)`
```
