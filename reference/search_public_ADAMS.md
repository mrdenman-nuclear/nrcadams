# Conducts a single ADAMS Search on Docket Numbers

Maximum of 100 results per search, so multiple searches may be needed.
Please use search_docket() for most use cases.

## Usage

``` r
search_public_ADAMS(
  DocketNumber,
  search_term,
  start_date,
  end_date,
  skip_dbl,
  verbosity = 0
)
```

## Source

<https://adams-search.nrc.gov/assets/APS-API-Guide.pdf>

## Arguments

- DocketNumber:

  dbl/vector: Docket number (or numbers) to be searched on ADAMS

- search_term:

  chr: Any search term desired. Default is nothing (i.e., NA)

- start_date:

  chr: The earliest date (ymd) search results should be returned. Cannot
  be used with days_back.

- end_date:

  chr: The latest date (ymd) search results should be returned. Cannot
  be used with days_back.

- verbosity:

  dbl: Level of verbosity for REST API requests.

- rest_api:

  logical: If TRUE, use the REST API to conduct the search.

- skip_dbl::

  Number of records to skip in the search.

## Value

tibble of search results
