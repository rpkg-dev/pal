% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/pal.gen.R
\name{ls_pkg}
\alias{ls_pkg}
\title{List a subset of all installed packages}
\usage{
ls_pkg(pkg, ignore_case = TRUE, as_regex = FALSE)
}
\arguments{
\item{pkg}{A character vector of package names.}

\item{ignore_case}{Do not distinguish between upper and lower case letters in \code{pkg}. If \code{FALSE}, \code{pkg} is treated case-sensitive.}

\item{as_regex}{Interpret \code{pkg} as regular expression(s). If \code{FALSE}, \code{pkg} is interpreted literally.}
}
\value{
A \link[tibble:tbl_df-class]{tibble}.
}
\description{
List a subset of all installed packages
}
\examples{
pal::ls_pkg(pkg = c("methods", "utils"))

pal::ls_pkg(pkg = "^ut",
            as_regex = TRUE)
}
\seealso{
Other R package functions:
\code{\link{is_pkg_cran}()},
\code{\link{is_pkg_dir}()},
\code{\link{is_pkg_installed}()},
\code{\link{is_pkgdown_dir}()},
\code{\link{use_pkg}()}
}
\concept{rpkgs}
