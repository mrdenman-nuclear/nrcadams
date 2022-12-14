% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/urlformat.R
\name{adams_start_or_end}
\alias{adams_start_or_end}
\title{ADAMS search posted date interval URL section for any ADAMS search}
\source{
\url{https://www.nrc.gov/site-help/developers/wba-api-developer-guide.pdf}
}
\usage{
adams_start_or_end(date = Sys.Date(), end_lgl = TRUE)
}
\arguments{
\item{end_lgl}{Logical: TRUE formats a search before this date.
FALSE formats a search after this date.}

\item{date_chr}{chr: The date (ymd)}
}
\value{
url segment for publish date searches
}
\description{
ADAMS search posted date interval URL section for any ADAMS search
}
\keyword{Internal}
