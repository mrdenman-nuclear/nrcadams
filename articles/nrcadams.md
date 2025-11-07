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

To keep up-to-date with ACU’s MSRR license, it is best to search through
both the pre-application and docketed information.

``` r
nrcadams::docket_codex |>
  dplyr::filter(Company == "ACU") |>
  dplyr::pull(DocketNumber) |>
  nrcadams::search_docket(days_back = 60) |>
  dplyr::mutate(Title = paste0("<a href='", URL, "'>", Title, '</a>')) |>
  dplyr::select(-URL) |>
  DT::datatable(
    caption = "The last 60 Days of the MSRR's Posted Licensing Documents.",
    filter = list(position = 'top', clear = TRUE, plain = FALSE),
    escape = FALSE
    )
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search_any:!(!(DocketNumber,eq,'99902088',''),!(DocketNumber,eq,'05000610','')),properties_search_all:!(!(PublishDatePARS,gt,'09/08/2025',''))))&qn=New&tab=advanced-search-pars&z=0 
#> : 0.305 sec elapsed
#> 
#>  This search returned: 5 files.
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
  nrcadams::search_docket() |>
  dplyr::filter(
    !stringr::str_detect(Type, "E-Mail"),
    !stringr::str_detect(Type, "Letter")
    )|>
  dplyr::mutate(Title = paste0("<a href='", URL, "'>", Title, '</a>')) |>
  dplyr::select(-URL) |>
  DT::datatable(
    caption = "X-Energy's Pre-Applicaion Docket without Letters and Emails.",
    filter = list(position = 'top', clear = TRUE, plain = FALSE),
    escape = FALSE
    )
#> Searching with the following URL:
#>  https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search_any:!(!(DocketNumber,eq,'99902071',''),!(DocketNumber,eq,'07007027',''),!(DocketNumber,eq,'99902117',''))))&qn=New&tab=advanced-search-pars&z=0 
#> : 3.454 sec elapsed
#> 
#>  This search returned: 1000 files.
#> Warning in nrcadams::search_docket(dplyr::pull(dplyr::filter(nrcadams::docket_codex, : 
#> This search returned more than 1000 results and thus may be incomplete. As a result, the search should be refined.
```
