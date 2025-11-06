# Conduct ADAMS Search on ACRS Documents

Conduct ADAMS Search on ACRS Documents

## Usage

``` r
search_ACRS(days_back = 7)
```

## Source

<https://www.nrc.gov/site-help/developers/wba-api-developer-guide.pdf>

## Arguments

- days_back:

  dbl: Length of time the search extends in days since the document was
  published on ADAMS? Default is all time (i.e, NA). Cannot be used with
  start_date or end_date.

## Value

tibble of search results
