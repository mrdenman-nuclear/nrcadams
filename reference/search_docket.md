# Conduct ADAMS Search on Docket Numbers

Conduct ADAMS Search on Docket Numbers

## Usage

``` r
search_docket(
  DocketNumber,
  search_term = NA,
  days_back = NA,
  start_date = NA,
  end_date = NA,
  document_type = NA,
  skip_int = 0,
  max_returns = 1e+06,
  verbosity = 0,
  adams_key = Sys.getenv("ADAMS")
)
```

## Source

<https://www.nrc.gov/site-help/developers/wba-api-developer-guide.pdf>

<https://adams-search.nrc.gov/assets/APS-API-Guide.pdf>

## Arguments

- DocketNumber:

  dbl/vector: Docket number (or numbers) to be searched on ADAMS

- search_term:

  chr: Any search term desired. Default is nothing (i.e., NA)

- days_back:

  dbl: Length of time the search extends in days since the document was
  published on ADAMS? Default is all time (i.e, NA). Cannot be used with
  start_date or end_date.

- start_date:

  chr: The earliest date (ymd) search results should be returned. Cannot
  be used with days_back.

- end_date:

  chr: The latest date (ymd) search results should be returned. Cannot
  be used with days_back.

- document_type:

  chr: Type of ADAMS document, currently unsupported

- max_returns:

  dbl: Maximum number of returns to pull when using REST API.

- verbosity:

  dbl: Level of verbosity for REST API requests. Integer 0-3, with 0
  being silent and 3 being most verbose.

- skip_int::

  Number of records to skip in the search.

## Value

tibble of search results
