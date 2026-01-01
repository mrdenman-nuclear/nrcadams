# Package index

## ADAMS Search Functions

The primary user fuctions for searching the ADAMS database.

- [`search_ACRS()`](https://mrdenman-nuclear.github.io/nrcadams/reference/search_ACRS.md)
  : Conduct ADAMS Search on ACRS Documents
- [`search_advanced()`](https://mrdenman-nuclear.github.io/nrcadams/reference/search_advanced.md)
  : Conduct ADAMS Search on ACRS Documents
- [`search_docket()`](https://mrdenman-nuclear.github.io/nrcadams/reference/search_docket.md)
  : Conduct ADAMS Search on Docket Numbers
- [`search_long_docket()`](https://mrdenman-nuclear.github.io/nrcadams/reference/search_long_docket.md)
  : Conduct a lengthy search on Docket Numbers
- [`search_ml()`](https://mrdenman-nuclear.github.io/nrcadams/reference/search_ml.md)
  : Conduct ADAMS Search on ML numbers
- [`search_public_ADAMS()`](https://mrdenman-nuclear.github.io/nrcadams/reference/search_public_ADAMS.md)
  : Conducts a single ADAMS Search on Docket Numbers
- [`search_undocketed()`](https://mrdenman-nuclear.github.io/nrcadams/reference/search_undocketed.md)
  : Why are my ears burning?

## Docket Inforamtion

Exported data objects intended to make using this package a little
easier.

- [`docket_codex`](https://mrdenman-nuclear.github.io/nrcadams/reference/docket_codex.md)
  : Codex of Docket Numbers
- [`RTR_docket_codex`](https://mrdenman-nuclear.github.io/nrcadams/reference/RTR_docket_codex.md)
  : Codex of Research and Test Reactor Docket Numbers

## Post-processing Functions

This set of functions helps work with the ADAMS search tibble results

- [`simplify_type()`](https://mrdenman-nuclear.github.io/nrcadams/reference/simplify_type.md)
  : Simplify Type Vector
- [`remove_noisy_files()`](https://mrdenman-nuclear.github.io/nrcadams/reference/remove_noisy_files.md)
  : Removes files from a targeted search results
- [`hyperlink_file_to_name()`](https://mrdenman-nuclear.github.io/nrcadams/reference/hyperlink_file_to_name.md)
  : Combines ULR with name vector to form a hyperlink
- [`format_ML_link()`](https://mrdenman-nuclear.github.io/nrcadams/reference/format_ML_link.md)
  : Make URL from ML number
- [`write_rss()`](https://mrdenman-nuclear.github.io/nrcadams/reference/write_rss.md)
  : Writes RSS Feeds
- [`collapse_list()`](https://mrdenman-nuclear.github.io/nrcadams/reference/collapse_list.md)
  : Collapse List

## Internal

Internal functions and objects (use ::: to find) for developer use.

- [`extract_from_xml()`](https://mrdenman-nuclear.github.io/nrcadams/reference/extract_from_xml.md)
  : Extract search term from XML results
- [`make_results_tibble()`](https://mrdenman-nuclear.github.io/nrcadams/reference/make_results_tibble.md)
  : Makes a Formatted Tibble from ADAMS URL Search Results
- [`make_results_tibble_no_docket()`](https://mrdenman-nuclear.github.io/nrcadams/reference/make_results_tibble_no_docket.md)
  : Makes a Formatted Tibble from ADAMS URL Search Results
- [`adams_all()`](https://mrdenman-nuclear.github.io/nrcadams/reference/adams_all.md)
  : ADAMS all criteria searches URL section for any ADAMS search
- [`adams_docket_numbers()`](https://mrdenman-nuclear.github.io/nrcadams/reference/adams_docket_numbers.md)
  : Adams Docket URL section for any ADAMS search
- [`adams_interval()`](https://mrdenman-nuclear.github.io/nrcadams/reference/adams_interval.md)
  : ADAMS search posted date interval URL section for any ADAMS search
- [`adams_search_head`](https://mrdenman-nuclear.github.io/nrcadams/reference/adams_search_head.md)
  : First URL section for any ADAMS search
- [`adams_search_tail()`](https://mrdenman-nuclear.github.io/nrcadams/reference/adams_search_tail.md)
  : Last URL section for any ADAMS search
- [`adams_search_term()`](https://mrdenman-nuclear.github.io/nrcadams/reference/adams_search_term.md)
  : ADAMS search term URL section for any ADAMS search
- [`adams_start_or_end()`](https://mrdenman-nuclear.github.io/nrcadams/reference/adams_start_or_end.md)
  : ADAMS search posted date interval URL section for any ADAMS search
- [`adams_type()`](https://mrdenman-nuclear.github.io/nrcadams/reference/adams_type.md)
  : ADAMS search type URL section for any ADAMS search
- [`lubridate_date()`](https://mrdenman-nuclear.github.io/nrcadams/reference/lubridate_date.md)
  : Formats YMD date string into ADAMS search date using lubridate
