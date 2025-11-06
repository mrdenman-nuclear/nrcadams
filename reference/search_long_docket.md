# Conduct a lengthy search on Docket Numbers

Individual ADAMS searches are limited to 1000 results, which can make
searches that are lengthy difficult. Additionally, long ADAMS searches
can take over 10 seconds to complete which may trigger a connection
timeout on some systems.

## Usage

``` r
search_long_docket(
  DocketNumber,
  search_term = NA,
  number_of_intervals = 5,
  start_date = "2017-1-1",
  document_type = NA
)
```

## Source

<https://www.nrc.gov/site-help/developers/wba-api-developer-guide.pdf>

## Arguments

- DocketNumber:

  dbl/vector: Docket number (or numbers) to be searched on ADAMS

- search_term:

  chr: Any search term desired. Default is nothing (i.e., NA)

- number_of_intervals:

  dbl: The maximum number of searches to be conducted

- start_date:

  chr: The earliest date (ymd) search results should be returned.

- document_type:

  chr: Type of ADAMS document

## Value

tibble of search results

## Details

To avoid these problems, this wrapper script conducts multiple searches
from today back to a starting point in time. The number of searches is
set by the num_interval. For example, if today is 2020/1/1 and the
starting date is 2010/1/1 and number_of_intervals is set to 2, this
script will conduct two searches, one from 2010 to 2015 and the other
from 2015 to 2020. These search results are then combined and output to
the user.
