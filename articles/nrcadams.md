# Docket Search

## What are Docket Numbers?

One of the more confusing aspects of the NRC’s document repository is
how the NRC assigns docket numbers. During pre-application engagement,
the companies are assigned a docket number that starts with `999`. Once
the NRC accepts a companies license application for review, the NRC will
assign a docket number based upon the type of license. For example,
companies applying for a traditional two stage license under Part 50
will have a docket number that begins with `050`. Companies applying for
a combined operating license under Part 52 will have a docket number
that begins with `052`. Even after an applicant receives a docket number
for a given facility or design, the applicant may still submit documents
to the pre-application docket if the information would support future
licensing submittals.

``` r
nrcadams::docket_codex |>
  DT::datatable(
    caption = "Exported Docket Numbers in the `nrcadams` Package.",
    filter = list(position = 'top', clear = TRUE, plain = FALSE)
    )
```

## Keeping Up to Date with a Docket

As an open regulator, the NRC is required to publicly provide
non-proprietary and non-export controlled information to the public.
When an applicant submits a proprietary document, the NRC will post the
non-proprietary portions of the document on ADAMS. The NRC typically
strives to ensure that enough information is in the public sphere to
justify any licensing actions.

To keep up-to-date with TerraPower’s Natrium license, it is best to
search through both the pre-application and docketed information.

``` r
nrcadams::docket_codex |>
  dplyr::filter(Company == "TerraPower") |>
  dplyr::pull(DocketNumber) |>
  nrcadams::search_docket(days_back = 60) |>
  dplyr::mutate(Title = paste0("<a href='", URL, "'>", Title, '</a>')) |>
  dplyr::select(-c(URL, count)) |>
  DT::datatable(
    caption = "The last 60 Days of the TerraPower's Posted Licensing Documents.",
    filter = list(position = "top", clear = TRUE, plain = FALSE),
    escape = FALSE
  )
#> 
#>  This search returned: 17 files.
```

## Filtering a Docket for Actual Information

A given docket will include email correspondence in addition to reports
and safety evaluations. Generally, letters and emails are more noise
than signal and can be filtered out of a search results. Instead of
mucking around with the ADAMS API to filter out these results, it is
simpler to use the
[`dplyr::filter`](https://dplyr.tidyverse.org/reference/filter.html) to
filter on the returned results.

``` r
nrcadams::docket_codex |>
  dplyr::filter(Company == "X-Energy") |>
  dplyr::pull(DocketNumber) |>
  nrcadams::search_docket(days_back = 30) |>
  dplyr::filter(
    !stringr::str_detect(Type, "E-Mail"),
    !stringr::str_detect(Type, "Letter")
  ) |>
  dplyr::mutate(Title = paste0("<a href='", URL, "'>", Title, '</a>')) |>
  dplyr::select(-URL) |>
  DT::datatable(
    caption = "X-Energy's Pre-Applicaion Docket without Letters and Emails.",
    filter = list(position = "top", clear = TRUE, plain = FALSE),
    escape = FALSE
  )
#> 
#>  This search returned: 29 files.
```
