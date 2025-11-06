# The `nrcadams` R package

A R package used to pull data from NRC’s ADAMS document repository.

Do you ever want to keep track of the most recent back and forth between
applicants and the NRC but you find [NRC web based ADAMS
searches](https://adams.nrc.gov/wba/) cumbersome? If so, this package
might be for you!

# How to install `nrcadams`

This R package is based on tidyverse, so both R and tidyverse
installation is recommended. Web based ADAMS results are processed in
xml, so the `xml2` package is a prerequisite. This package is programmed
using base R pipes, so versions of R greater than 4.1 are required.

Please install this package using `remotes`:

``` r
remotes::install_github("mrdenman-nuclear/nrcadams")
```

This package is unlikely to be published on CRAN.

# How to use this package

The `nrcadams` package is fairly limited at this time. All of the key
functionality runs through the `search_docket`. At least one docket
number is required, but you can filter the results by specifying how
many days in the past you want to search for as well as search terms.
The function outputs a tibble of results including URLs to the
documents.

``` r
ACU_MSRR <- c(99902088, 05000610)
ACU_MSRR |>
  nrcadams::search_docket(
    days_back = 20,
    search_term = "Acceptance"
    )
```
