% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/pal.gen.R
\name{phrase_nr}
\alias{phrase_nr}
\title{Phrase numeric vector}
\usage{
phrase_nr(
  x,
  round_to = 0.1,
  round_up = TRUE,
  big_mark = "'",
  decimal_mark = ".",
  justify_right = FALSE,
  ...
)
}
\arguments{
\item{x}{A numeric vector to phrase.}

\item{round_to}{Number to round \code{x} to. A numeric scalar.}

\item{round_up}{Whether to round a remainder of exactly \code{to / 2} \emph{up} or not. Set to \code{FALSE} in order to round \emph{off}.}

\item{big_mark}{Character used between every 3 digits to separate thousands.}

\item{decimal_mark}{Character used to indicate the numeric decimal point. Only relevant if \code{x} does not solely consist of integers.}

\item{justify_right}{Whether to right-justify the results to a common width. See the \code{trim} parameter of \code{\link[base:format]{base::format()}} for details.}

\item{...}{Further arguments passed on to \code{\link[base:format]{base::format()}}.}
}
\value{
A character vector of the same length as \code{x}.
}
\description{
Phrases a numeric vector by rounding, separating thousands and optionally other procedures. Basically a convenience wrapper around \code{\link[=round_to]{round_to()}} and
\code{\link[base:format]{base::format()}}.
}
\examples{
c(0.11, 11111.11) |> pal::phrase_nr()

c(0.11, 11111.11) |>
  pal::phrase_nr(justify_right = TRUE) |>
  pal::cat_lines()
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
\code{\link{sentenceify}()},
\code{\link{wrap_chr}()}
}
\concept{string}
