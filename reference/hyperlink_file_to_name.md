# Combines ULR with name vector to form a hyperlink

Combines ULR with name vector to form a hyperlink

## Usage

``` r
hyperlink_file_to_name(search_tbl, name_vct = Title, url_vct = URL)
```

## Arguments

- search_tbl:

  Search Tibble

- name_vct:

  Name of the column (default is Type)

- url_vct:

  Name of the URL column (default is URL)

## Value

search_tbl minus the URL column
