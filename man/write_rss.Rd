% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/write_rss.R
\name{write_rss}
\alias{write_rss}
\title{Writes RSS Feeds}
\source{
https://github.com/cran/animation/blob/8ef6f898875373fa95ba9a55d405a6f2bb741474/R/write.rss.R
}
\usage{
write_rss(
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
  managingEditor = "mrdenman@gmail.com",
  webMaster = "mrdenman@gmail.com",
  maxitem = 30,
  doc_ML = `ML Number`,
  doc_title = Title,
  doc_author = Affiliation,
  doc_description = Type,
  doc_date = `Publish Date`,
  ...
)
}
\arguments{
\item{docket_tbl}{incoming docket tbl}

\item{file}{file name to be printed.}

\item{xmlver}{XML file version}

\item{rssver}{RSS file version}

\item{title}{Title of RSS feed}

\item{link}{URL}

\item{description}{Description of RSS feed}

\item{language}{Language}

\item{copyright}{Copyrite}

\item{pubDate}{Publication Date}

\item{lastBuildDate}{Last updated date}

\item{docs}{website date}

\item{generator}{how the file was written}

\item{managingEditor}{whose fault is this?}

\item{webMaster}{who put this on the web?}

\item{maxitem}{how long is the RSS feed?}

\item{doc_ML}{The document ML number used to format a URL vector name.}

\item{doc_title}{The document title vector name.}

\item{doc_author}{The document author vector name.}

\item{doc_description}{The document description vector name.}

\item{doc_date}{The document date vector name.}

\item{...}{Other items}
}
\value{
an RSS file
}
\description{
Writes RSS Feeds
}
