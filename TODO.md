# TODOs

-   systematically rely on pkg [xfun](https://yihui.name/xfun/) whenever sensible

-   add a [standards-conformant changelog](https://keepachangelog.com/) for v0.1.0 but use pkg [fledge](https://cynkra.github.io/fledge/) to generate it from
    Git commits (note the [special rules](https://cynkra.github.io/fledge/articles/fledge.html) to mark commit msgs for in-/exclusion in the changelog)

-   generate a `codemeta.json` file using pkg [codemetar](https://docs.ropensci.org/codemetar/)

-   release on CRAN:

    1.  Thoroughly scan exported fns for possible API improvements (which would harder to introduce once the pkg is on CRAN) and other outstanding work and
        implement it.

        -   Migrate to httr2!

    2.  Replace `pkgsnip::*` with constants included in pkg. Make changes (to source file `Rmd/pal.Rmd` only) in a single commit, so it can be easily reverted.

    3.  Remove Netlify redirect rule `/` -\> `/dev`.

    4.  Release pkg pkgsnip on CRAN.

    5.  Revert step 2.
