% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ACRS.R
\name{make_results_tibble_no_docket}
\alias{make_results_tibble_no_docket}
\title{Makes a Formatted Tibble from ADAMS URL Search Results}
\source{
\url{https://www.nrc.gov/site-help/developers/wba-api-developer-guide.pdf}
}
\usage{
make_results_tibble_no_docket(adams_url, tag_chr = NULL, download = FALSE)
}
\arguments{
\item{adams_url}{ADAMS search URL}

\item{tag_chr}{tag associted with the search result}

\item{download}{Logical, if set to true, the file is downloaded before it is processed}
}
\value{
vector of search term results
}
\description{
Makes a Formatted Tibble from ADAMS URL Search Results
}
\examples{
"https://adams.nrc.gov/wba/services/search/advanced/nrc?q=(mode:sections,sections:(filters:(public-library:!t),properties_search_any:!(!(DocketNumber,eq,'99902088','')),properties_search_all:!(!(PublishDatePARS,gt,'01/05/2023',''))))&qn=New&tab=advanced-search-pars&z=0" |>
nrcadams:::make_results_tibble()
}
\keyword{Internal}
