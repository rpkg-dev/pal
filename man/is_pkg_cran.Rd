% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/pal.gen.R
\name{is_pkg_cran}
\alias{is_pkg_cran}
\title{Test if a package is available on CRAN}
\usage{
is_pkg_cran(pkg, min_version = NULL, max_tries = 1L)
}
\arguments{
\item{pkg}{Package name (case-sensitive). A character scalar.}

\item{min_version}{Minimum required version number of \code{pkg}. Must be either \code{NULL} to ignore version numbers, or a single
\code{\link[base:numeric_version]{package_version}} or something coercible to.}

\item{max_tries}{Maximum number of request attempts in case of an HTTP error. An integerish scalar. Retries are performed using exponential backoff and jitter, see \code{\link[httr2:req_retry]{httr2::req_retry()}} for details.}
}
\value{
A logical scalar.
}
\description{
Test if a package is available on CRAN
}
\examples{
pal::is_pkg_cran("foobar")
pal::is_pkg_cran("dplyr")
pal::is_pkg_cran("dplyr", min_version = "9999.9")
}
\seealso{
Other R package functions:
\code{\link{is_pkg_dir}()},
\code{\link{is_pkg_installed}()},
\code{\link{is_pkgdown_dir}()},
\code{\link{ls_pkg}()},
\code{\link{use_pkg}()}
}
\concept{rpkgs}
