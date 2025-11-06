# Writes RSS Feeds

Writes RSS Feeds

## Usage

``` r
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
```

## Source

https://github.com/cran/animation/blob/8ef6f898875373fa95ba9a55d405a6f2bb741474/R/write.rss.R

## Arguments

- docket_tbl:

  incoming docket tbl

- file:

  file name to be printed.

- xmlver:

  XML file version

- rssver:

  RSS file version

- title:

  Title of RSS feed

- link:

  URL

- description:

  Description of RSS feed

- language:

  Language

- copyright:

  Copyrite

- pubDate:

  Publication Date

- lastBuildDate:

  Last updated date

- docs:

  website date

- generator:

  how the file was written

- managingEditor:

  whose fault is this?

- webMaster:

  who put this on the web?

- maxitem:

  how long is the RSS feed?

- doc_ML:

  The document ML number used to format a URL vector name.

- doc_title:

  The document title vector name.

- doc_author:

  The document author vector name.

- doc_description:

  The document description vector name.

- doc_date:

  The document date vector name.

- ...:

  Other items

## Value

an RSS file
