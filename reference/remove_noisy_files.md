# Removes files from a targeted search results

Searching for a file type can be difficult due to ADAMS's inconsistent
type structure. This function attempts to "cut through the noise" and
target the search results properly

## Usage

``` r
remove_noisy_files(search_tbl, target_chr, type_vct = Type, title_vct = Title)
```

## Arguments

- search_tbl:

  Search Tibble with an ADAMS Type vector and Title vector

- target_chr:

  The search type of note

- type_vct:

  Name of the Type column (default is Type)

- title_vct:

  Name of the Title column (default is Title)

## Value

Search Tibble
