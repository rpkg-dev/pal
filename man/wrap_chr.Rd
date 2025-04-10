% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/pal.gen.R
\name{wrap_chr}
\alias{wrap_chr}
\title{Wrap character in character}
\usage{
wrap_chr(x, wrap = "\\"")
}
\arguments{
\item{x}{A character vector or something coercible to. Will be fed to \code{\link[=as_chr]{as_chr()}} before wrapping.}

\item{wrap}{Character sequence \code{x} is to be wrapped in. A character vector or something coercible to.}
}
\value{
A character vector of the same length as \code{wrap}.
}
\description{
Wraps a character vector \code{x} in another character vector \code{wrap} (by default the string \verb{"}).
}
\examples{
mtcars |>
  colnames() |>
  pal::wrap_chr(wrap = "`") |>
  magrittr::set_colnames(x = mtcars) |>
  pal::pipe_table()
}
\seealso{
Other string functions:
\code{\link{as_chr}()},
\code{\link{as_comment_str}()},
\code{\link{as_env_var_name}()},
\code{\link{as_line_feed_chr}()},
\code{\link{as_str}()},
\code{\link{capitalize_first}()},
\code{\link{dsv_colnames}()},
\code{\link{enum_str}()},
\code{\link{escape_lf}()},
\code{\link{fuse_regex}()},
\code{\link{phrase_nr}()},
\code{\link{sentenceify}()}
}
\concept{string}
