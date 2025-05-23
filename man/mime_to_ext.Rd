% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/pal.gen.R
\name{mime_to_ext}
\alias{mime_to_ext}
\title{MIME type to file extension}
\usage{
mime_to_ext(mime_type, quiet = FALSE)
}
\arguments{
\item{mime_type}{MIME type to determine the file extension for. A character scalar.}

\item{quiet}{Whether or not to suppress printing status output from internal processing.}
}
\value{
A character scalar.
}
\description{
Determines a suitable file extension from a \href{https://en.wikipedia.org/wiki/Media_type}{MIME type}, based i.a. on \code{\link[mime:mimemap]{mime::mimemap}} and \code{mime:::mimeextra}. In
case of multiple matches, the first one is returned and a warning is printed (unless \code{quiet = TRUE}).
}
\examples{
pal::mime_to_ext("application/json")
pal::mime_to_ext("audio/mpeg")
}
