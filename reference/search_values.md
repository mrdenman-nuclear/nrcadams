# Conduct ADAMS Search on Author Affliation and Search Terms

Conduct ADAMS Search on Author Affliation and Search Terms

## Usage

``` r
search_values(
  search_term = NA,
  author_affiliation = NA,
  DocketNumber = NA,
  results_tag = NA,
  days_back = 7,
  skip_int = 0,
  max_returns = 1e+06,
  verbosity = 0,
  adams_key = Sys.getenv("ADAMS")
)
```

## Source

<https://adams-search.nrc.gov/assets/APS-API-Guide.pdf>

## Arguments

- search_term:

  chr: string with the search query

- author_affiliation:

  chr: string with the author affiliation

- DocketNumber:

  chr: string with the docket number

- results_tag:

  chr: string with the results tag

- days_back:

  dbl: Length of time the search extends in days since the document was
  published on ADAMS? Default is 7 days.

- skip_int:

  dbl: Number of results to skip

- max_returns:

  dbl: Maximum number of results to return

- verbosity:

  dbl: Level of verbosity for the httr2 request

- adams_key:

  chr: ADAMS API key

## Value

tibble of search results
