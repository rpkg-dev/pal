% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/pal.gen.R
\name{assert_class_any}
\alias{assert_class_any}
\title{Assert object is member of any class}
\usage{
assert_class_any(x, classes, name = "x")
}
\arguments{
\item{x}{\R object to test.}

\item{classes}{Class names to check for inheritance. A character vector.}

\item{name}{Name of the checked object to print in error message in case the assertion fails. A character scalar.}
}
\value{
\code{x}, invisibly.
}
\description{
Asserts that an object is member of any of the specified classes.
}
\details{
In contrast to \code{\link[checkmate:checkClass]{checkmate::assert_class()}}, this function returns \code{TRUE} as long as \code{x} is at least member of \emph{one} of \code{classes}.
}
\examples{
xml2::read_html("https://pal.rpkg.dev/dev/license") |>
  assert_class_any(classes = c("xml_document", "xml_nodeset", "xml_node"))
}
\seealso{
Other functions extending the checkmate package:
\code{\link{assert_cli}()},
\code{\link{assert_df_or_tibble}()},
\code{\link{assert_inf_count}()}
}
\concept{checkmate}
