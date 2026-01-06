# Conducts a single ADAMS Search on Docket Numbers

Maximum of 100 results per search, so multiple searches may be needed.
Please use search_docket() for most use cases.

## Usage

``` r
search_public_ADAMS(
  search_term = NA,
  DocketNumber = NA,
  start_date = NA,
  author_affiliation = NA,
  document_type = NA,
  results_tag = NA,
  end_date = NA,
  skip_int = 0,
  verbosity = 0,
  adams_key = Sys.getenv("ADAMS")
)
```

## Source

<https://adams-search.nrc.gov/assets/APS-API-Guide.pdf>

## Arguments

- search_term:

  chr: Any search term desired. Default is nothing (i.e., NA)

- DocketNumber:

  dbl/vector: Docket number (or numbers) to be searched on ADAMS

- start_date:

  chr: The earliest date (ymd) search results should be returned. Cannot
  be used with days_back.

- end_date:

  chr: The latest date (ymd) search results should be returned. Cannot
  be used with days_back.

- verbosity:

  dbl: Level of verbosity for REST API requests.

- skip_int::

  Number of records to skip in the search.

## Value

tibble of search results
