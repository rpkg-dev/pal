% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/pal.gen.R
\name{check_dots_named}
\alias{check_dots_named}
\title{Check that all named dots arguments are valid}
\usage{
check_dots_named(
  ...,
  .fn,
  .additional = NULL,
  .forbidden = NULL,
  .empty_ok = TRUE,
  .action = c("abort", "warn", "inform")
)
}
\arguments{
\item{...}{Dots argument to check.}

\item{.fn}{Function the \code{...} will be passed on to.}

\item{.additional}{Parameter names within \code{...} that should be treated as valid in addition to \code{.fn}'s actual parameter names. A character vector.}

\item{.forbidden}{Parameter names within \code{...} that should be treated as invalid. This has precedence over \code{.additional}. A character vector.}

\item{.empty_ok}{Set to \code{TRUE} if empty \code{...} should be allowed, or to \code{FALSE} otherwise.}

\item{.action}{Action to take when the check fails. One of \code{"abort"}, \code{"warn"} or \code{"inform"}}
}
\description{
\ifelse{html}{\href{https://lifecycle.r-lib.org/articles/stages.html#experimental}{\figure{lifecycle-experimental.svg}{options: alt='[Experimental]'}}}{\strong{[Experimental]}}

Ensures that \link[base:dots]{dots} \code{...} are either empty (if \code{.empty_ok = TRUE}), or all named elements in dots are a valid subset of \code{.fn}'s parameter names.
In case of an invalid or \code{.forbidden} argument, an informative message is shown and the defined \code{.action} is taken.
}
\details{
\code{check_dots_named()} is intended to combat the second one of the two major downsides that using \code{...} usually brings. In chapter 6.6 of the book
\emph{Advanced R} it is \href{https://adv-r.hadley.nz/functions.html#fun-dot-dot-dot}{phrased} as follows:

\emph{Using \code{...} comes with two downsides:}
\itemize{
\item \emph{When you use it to pass arguments to another function, you have to carefully explain to the user where those arguments go. This makes it hard to
understand what you can do with functions like \code{lapply()} and \code{plot()}.}
\item \strong{\emph{A misspelled argument will not raise an error. This makes it easy for typos to go unnoticed.}}
}
}
\examples{
# We can use `check_dots_named()` to address this second downside:
sum_safe <- function(...,
                     na.rm = FALSE) {
  pal::check_dots_named(...,
                        .fn = sum)
  sum(...,
      na.rm = na.rm)
}

# Note how the misspelled `na_rm` (instead of `na.rm`) silently gets ignored in the original
# function,
sum(1, 2, NA, na_rm = TRUE)

# whereas our safe version properly errors:
try(
  sum_safe(1, 2, NA, na_rm = TRUE)
)

# We can even build an `sapply()` function that fails "intelligently":
sapply_safe <- function(X,
                        FUN,
                        ...,
                        simplify = TRUE,
                        USE.NAMES = TRUE) {
  pal::check_dots_named(...,
                        .fn = FUN)
  sapply(X = X,
         FUN = FUN,
         ...,
         simplify = TRUE,
         USE.NAMES = TRUE)
}

# While the original `sapply()` silently consumes misspelled named arguments via `...`,
sapply(1:5, paste, "hour workdays", sep = "-", colaspe = " ")

# `sapply_safe()` will throw an informative error message:
try(
  sapply_safe(1:5, paste, "hour workdays", sep = "-", colaspe = " ")
)

# But be aware that `check_dots_named()` might be a bit rash,
try(
  sum_safe(a = 1, b = 2)
)

# while the original function actually has nothing to complain:
sum(a = 1, b = 2)

# Furthermore, it doesn't play nicely with generics that don't expose all of the argument names
# of the method that is eventually invoked (`to` and `by` in the case of `seq()` -> `seq.int()`):
try(
  sapply_safe(X = c(0,50),
              FUN = seq,
              to = 100,
              by = 5)
)

# To work around this, directly supply the proper method (`seq.int`),
sapply_safe(X = c(0,50),
            FUN = seq.int,
            to = 100,
            by = 5)

# or just provide `to` and `by` *unnamed*:
sapply_safe(X = c(0,50),
            FUN = seq,
            100,
            5)
}
\seealso{
rlang's check dots functions: \code{\link[rlang:check_dots_empty]{rlang::check_dots_empty()}}, \code{\link[rlang:check_dots_used]{rlang::check_dots_used()}} and \code{\link[rlang:check_dots_unnamed]{rlang::check_dots_unnamed()}}
}
\concept{dots}
