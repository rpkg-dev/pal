% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/pal.gen.R
\name{roxy_to_md_links}
\alias{roxy_to_md_links}
\title{Convert roxygen2 documentation links to Markdown}
\usage{
roxy_to_md_links(x)
}
\arguments{
\item{x}{Markdown text with roxygen2 documentation links. A character scalar.}
}
\value{
A character scalar.
}
\description{
Converts roxygen2 documentation \href{https://roxygen2.r-lib.org/articles/rd-formatting.html#function-links}{links in pseudo-Markdown style} to actual Markdown
ones using \code{\link[downlit:autolink]{downlit::autolink_url()}}.
}
\examples{
pal::roxy_to_md_links("[base::c()] is so short I almost forget it's there.")
pal::roxy_to_md_links("[`base::c()`], probably the most used base R function ever.")
pal::roxy_to_md_links("Some functions [are magic][downlit::autolink_url]!")
pal::roxy_to_md_links("downlit's [`autolink_url()`][downlit::autolink_url] seems magic!")
}
\seealso{
Other package documentation functions:
\code{\link{enum_fn_param_defaults}()},
\code{\link{fn_param_defaults}()},
\code{\link{roxy_blocks}()},
\code{\link{roxy_obj}()},
\code{\link{roxy_tag_value}()}
}
\concept{roxy}
