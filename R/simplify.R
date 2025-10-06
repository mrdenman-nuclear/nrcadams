#' Simplify Type Vector
#'
#' @param search_tbl Search Tibble with an ADAMS Type vector
#' @param type_vct Name of the Type column (default is Type)
#'
#' @return Search Tibble
#' @export
#'
simplify_type = function(search_tbl, type_vct = Type) {
  search_tbl |>
    dplyr::mutate(
      {{type_vct}} := dplyr::case_when(
        {{type_vct}} |> stringr::str_detect("Comment Letter") ~ "Comments",
        {{type_vct}} |> stringr::str_detect("RAI") ~ "RAI",
        {{type_vct}} |> stringr::str_detect("Audit") ~ "Audit",
        {{type_vct}} |> stringr::str_detect("SAR") ~ "Safety Analysis",
        {{type_vct}} |> stringr::str_detect("Safety Analysis") ~ "Safety Analysis",
        {{type_vct}} |> stringr::str_detect("SER") ~ "Safety Eval.",
        {{type_vct}} |> stringr::str_detect("Safety Evaluation") ~ "Safety Eval.",
        {{type_vct}} |> stringr::str_detect("Report") ~ "Report",
        {{type_vct}} |> stringr::str_detect("Slides") ~ "Slides",
        {{type_vct}} |> stringr::str_detect("Legal-Affidavit") ~ "Other",
        {{type_vct}} |> stringr::str_detect("Legal") ~ "Legal",
        TRUE ~ "Other"
      )
    )
}

#' Removes files from a targeted search results
#'
#' Searching for a file type can be difficult due to ADAMS's inconsistent
#' type structure. This function attempts to "cut through the noise" and
#' target the search results properly
#'
#' @param search_tbl Search Tibble with an ADAMS Type vector and Title vector
#' @param target_chr The search type of note
#' @param type_vct Name of the Type column (default is Type)
#' @param title_vct Name of the Title column (default is Title)
#'
#' @return  Search Tibble
#' @export
#'
remove_noisy_files = function(
    search_tbl,
    target_chr,
    type_vct = Type,
    title_vct = Title
    ) {
  search_tbl |>
    dplyr::filter(stringr::str_detect({{type_vct}}, target_chr)) |>
    nrcadams::simplify_type({{type_vct}}) |>
    dplyr::filter(
      !stringr::str_detect({{type_vct}}, "RAI"),
      !stringr::str_detect({{type_vct}}, "Other"),
      !stringr::str_detect({{type_vct}}, "Legal"),
      !stringr::str_detect({{title_vct}}, "Question"),
      !stringr::str_detect({{title_vct}}, "Form 896"),
      !stringr::str_detect({{title_vct}}, "Cover Letter"),
      !stringr::str_detect({{title_vct}}, "Request"),
      !stringr::str_detect({{title_vct}}, "Response"),
      !stringr::str_detect({{title_vct}}, "Letter")
    )

}


#' Combines ULR with name vector to form a hyperlink
#'
#' @param search_tbl Search Tibble
#' @param name_vct Name of the column (default is Type)
#' @param url_vct Name of the URL column (default is URL)
#'
#' @return search_tbl minus the URL column
#' @export
hyperlink_file_to_name = function(search_tbl, name_vct = Title, url_vct = URL) {
  search_tbl |>
    dplyr::mutate(
      Title = paste0("<a href='", {{url_vct}}, "'>", {{name_vct}}, '</a>')
      ) |>
    dplyr::select(-{{url_vct}})
}
