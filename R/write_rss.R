
#' Writes RSS Feeds
#'
#' @param docket_tbl incoming docket tbl
#' @param file file name to be printed.
#' @param xmlver XML file version
#' @param rssver RSS file version
#' @param title Title of RSS feed
#' @param link URL
#' @param description Description of RSS feed
#' @param language Language
#' @param copyright Copyrite
#' @param pubDate Publication Date
#' @param lastBuildDate Last updated date
#' @param docs website date
#' @param generator how the file was written
#' @param managingEditor whose fault is this?
#' @param webMaster who put this on the web?
#' @param maxitem how long is the RSS feed?
#' @param doc_url The document URL vector name.
#' @param doc_title The document title vector name.
#' @param doc_author The document author vector name.
#' @param doc_description The document description vector name.
#' @param doc_date The document date vector name.
#' @param ... Other items
#'
#' @source https://github.com/cran/animation/blob/8ef6f898875373fa95ba9a55d405a6f2bb741474/R/write.rss.R
#'
#' @return an RSS file
#' @keywords Internal
write_rss <- function(
    docket_tbl = "rss.csv",
    file = "dockets.xml",
    xmlver = "1.0",
    rssver = "2.0",
    title = "New Docket Files",
    link = "https://mrdenman-nuclear.github.io/nrcadams/",
    description = "NRC ADAMS Docket Update",
    language = "en-us",
    copyright = "Copyright 2022, Matthew Denman",
    pubDate = Sys.time(),
    lastBuildDate = Sys.time(),
    docs = "https://mrdenman-nuclear.github.io/nrcadams/",
    generator = "Function write_rss() in R package nrcadams",
    managingEditor = "mrdenman[at]gmail.com",
    webMaster = "mrdenman[at]gmail.com",
    maxitem = 30,
    doc_url = URL,
    doc_title = Title,
    doc_author = Affiliation,
    doc_description = Type,
    doc_date = `Document Date`,
    ...) {
  docket_tbl = docket_tbl |>
    dplyr::rename(
      title = {{doc_title}},
      link = {{doc_url}},
      description = {{doc_description}},
      author = {{doc_author}},
      pubDate = {{doc_date}}
    ) |>
    dplyr::select(title, link, description, author, pubDate) |>
    dplyr::filter(dplyr::row_number() <= maxitem)


  # if (nrow(x) > maxitem) {
  #   x = x[(nrow(x) - maxitem + 1):nrow(x), ]
  # }
  #
  # x = x[nrow(x):1, ]
  lcl = Sys.getlocale("LC_TIME")
  Sys.setlocale("LC_TIME", "C")
  pubDate = format(pubDate, "%a, %d %b %Y %H:%M:%S GMT")
  lastBuildDate = format(lastBuildDate, "%a, %d %b %Y %H:%M:%S GMT")
  cat(
    "<?xml version", "=\"", xmlver, "\"?>\n", "<rss version=\"",
    rssver, "\">\n", "\t", "<channel>\n", "\t\t", "<title>",
    title, "</title>\n", "\t\t", "<link>", link, "</link>\n",
    "\t\t", "<description>", description, "</description>\n",
    "\t\t", "<language>", language, "</language>\n", "\t\t",
    "<pubDate>", pubDate, "</pubDate>\n", "\t\t", "<lastBuildDate>",
    lastBuildDate, "</lastBuildDate>\n", "\t\t", "<docs>",
    docs, "</docs>\n", "\t\t", "<generator>", generator,
    "</generator>\n", "\t\t", "<managingEditor>", managingEditor,
    "</managingEditor>\n", "\t\t", "<webMaster>", webMaster,
    "</webMaster>\n", file = file,
    sep = ""
  )
  extra = list(...)
  if (length(extra)) {
    tag1 = paste("\t\t<", names(extra), ">", sep = "")
    tag2 = paste("</", names(extra), ">", sep = "")
    cat(paste(tag1, extra, tag2, sep = "", collapse = "\n"),
        "\n", file = file, append = TRUE)
  }

  if(nrow(docket_tbl) > 0.5) {
    tag1 = paste("<", colnames(docket_tbl), ">", sep = "")
    tag2 = paste("</", colnames(docket_tbl), ">", sep = "")
    cat(
      paste(
        "\t\t<item>",
        apply(docket_tbl, 1, function(xx) paste(
          "\t\t\t",
          paste(tag1, xx, tag2, sep = "", collapse = "\n\t\t\t"), sep = "")
          ),
        "\t\t</item>",
        sep = "\n",
        collapse = "\n"
      ),
      file = file, append = TRUE
    )
    cat("\n\t", file = file, append = TRUE)
  }

  cat("</channel>", file = file, append = TRUE)
  cat("\n</rss>", file = file, append = TRUE)
  Sys.setlocale("LC_TIME", lcl)
  cat("RSS feed created at:", file, "\n")
}
