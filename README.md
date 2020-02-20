# supporter: Convenience Functions for the Typical R Coder

This package combines a variety of convenience functions which aren't found in any other tidyverse-style R packages.

## Features

...

## Details

...

## Installation

To install the latest development version of _supporter_, run the following in R:

```r
if ( !("remotes" %in% rownames(installed.packages())) )
{
  install.packages(pkgs = "remotes",
                   repos = "https://cloud.r-project.org/")
}
remotes::install_gitlab(repo = "salim_b/r/pkgs/supporter")
```

## Development

This package is written using [literate programming](https://en.wikipedia.org/wiki/Literate_programming) techniques [proposed by Yihui Xie](https://yihui.name/rlp/). This means all the `-GEN.R` suffixed R source code found under [`R/`](R/) is generated from their respective [R Markdown](https://rmarkdown.rstudio.com/) counterparts found under [`Rmd/`](Rmd/) as instructed by the [`Makefile`](Makefile). Always make changes only to the `.Rmd` files – not the `.R` files – and then run the following from the root of this repository to regenerate the R source code and build and install the package:

```sh
make && Rscript -e "devtools::install('.', keep_source = TRUE)"
```

Make sure that [`make`](https://de.wikipedia.org/wiki/GNU_Make)[^make-prop] is available on your system and that the R packages [`knitr`](https://cran.r-project.org/package=knitr) and [`rmarkdown`](https://cran.r-project.org/package=rmarkdown) are up to date beforehand.


[^make-prop]: On Windows, `make` is included in [Rtools](https://cran.rstudio.com/bin/windows/Rtools/). On macOS, you have to install the [Xcode command line tools](https://stackoverflow.com/a/10301513/7196903).


## See also

- [The _xfun_ package by Yihui Xe, a different collection of miscellaneous R functions](https://yihui.org/xfun/).
