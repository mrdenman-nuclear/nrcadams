# Process first and last dates.

Process first and last dates.

## Usage

``` r
process_dates(start_date = NA, end_date = NA, days_back = NA)
```

## Arguments

- start_date:

  chr: The earliest date (ymd) search results should be returned. Cannot
  be used with days_back.

- end_date:

  chr: The latest date (ymd) search results should be returned. Cannot
  be used with days_back.

- days_back:

  dbl: Length of time the search extends in days since the document was
  published on ADAMS? Default is all time (i.e, NA). Cannot be used with
  start_date or end_date.

## Value

list of start and end dates
