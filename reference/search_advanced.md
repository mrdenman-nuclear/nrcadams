# Conduct ADAMS Search on ACRS Documents

Conduct ADAMS Search on ACRS Documents

## Usage

``` r
search_advanced(
  search_field = "properties_search_all:!(!(AuthorAffiliation,starts,NRC/ACRS,''),",
  results_tag = "ACRS",
  days_back = 7,
  content_search = FALSE
)
```

## Source

<https://www.nrc.gov/site-help/developers/wba-api-developer-guide.pdf>

## Arguments

- search_field:

  chr: string with the search query

- results_tag:

  chr: string with the results tag

- days_back:

  dbl: Length of time the search extends in days since the document was
  published on ADAMS? Default is all time (i.e, NA). Cannot be used with
  start_date or end_date.

- content_search:

  lgl: Is this a content search or a tag search

## Value

tibble of search results
