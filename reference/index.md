# Package index

## ADAMS Search Functions

The primary user fuctions for searching the ADAMS database.

- [`search_docket()`](https://mrdenman-nuclear.github.io/nrcadams/reference/search_docket.md)
  : Conduct ADAMS Search on Docket Numbers
- [`search_ml()`](https://mrdenman-nuclear.github.io/nrcadams/reference/search_ml.md)
  : Conduct ADAMS Search on ML numbers
- [`search_public_ADAMS()`](https://mrdenman-nuclear.github.io/nrcadams/reference/search_public_ADAMS.md)
  : Conducts a single ADAMS Search on Docket Numbers
- [`search_values()`](https://mrdenman-nuclear.github.io/nrcadams/reference/search_values.md)
  : Conduct ADAMS Search on Author Affliation and Search Terms

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

## Internal

Internal functions and objects (use ::: to find) for developer use.

- [`decode_resp()`](https://mrdenman-nuclear.github.io/nrcadams/reference/decode_resp.md)
  : Decodes the REST API response from ADAMS
- [`process_dates()`](https://mrdenman-nuclear.github.io/nrcadams/reference/process_dates.md)
  : Process first and last dates.
