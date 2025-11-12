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
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search_any:!(!(AccessionNumber,starts,ML22179A346,''),!(AccessionNumber,starts,ML19211C119,''))))&qn=New&tab=content-search-pars&z=0
#> Warning: Failed to open 'https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search_any:!(!(AccessionNumber,starts,ML22179A346,''),!(AccessionNumber,starts,ML19211C119,''))))&qn=New&tab=content-search-pars&z=0': The requested URL returned error: 500
#> Error in open.connection(x, "rb"): cannot open the connection
```
