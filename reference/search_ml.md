# Conduct ADAMS Search on ML numbers

Conduct ADAMS Search on ML numbers

## Usage

``` r
search_ml(ML_number)
```

## Source

<https://www.nrc.gov/site-help/developers/wba-api-developer-guide.pdf>

## Arguments

- ML_number:

  chr/vector: ML number (or numbers) to be searched on ADAMS. All
  searches must start with ML but partial ML numbers can be searched for
  in addition to full ML numbers.

## Value

tibble of search results

## Examples

``` r
c("ML22179A346", "ML19211C119") |> nrcadams::search_ml()
#> [1] "ML22179A346"
#> Error in httr2::req_perform(req): HTTP 401 Unauthorized.
```
