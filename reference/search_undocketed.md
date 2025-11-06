# Why are my ears burning?

This function searches for company mentions that are not tagged to a
docket.

## Usage

``` r
search_undocketed(company = "Kairos Power", days_back = 30)
```

## Source

<https://www.nrc.gov/site-help/developers/wba-api-developer-guide.pdf>

## Arguments

- company:

  chr: Name of the company in nrcadams::docket_codex to be searched for.

- days_back:

  dbl: Length of time the search extends in days since the document was
  published on ADAMS? Default is all time (i.e, NA). Cannot be used with
  start_date or end_date.

## Value

tibble of search results
