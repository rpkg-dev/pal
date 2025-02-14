# TODOs

-   systematically rely on pkg [xfun](https://yihui.name/xfun/) whenever sensible

-   add a [standards-conformant changelog](https://keepachangelog.com/) for v0.1.0 but use pkg [fledge](https://cynkra.github.io/fledge/) to generate it from
    Git commits (note the [special rules](https://cynkra.github.io/fledge/articles/fledge.html) to mark commit msgs for in-/exclusion in the changelog)

    note that [according to its README](https://github.com/cynkra/fledge), fledge plays nicely together with the [Conventional
    Commits](https://www.conventionalcommits.org/) syntax (which is a lot more universal; e.g. [release-please](https://github.com/googleapis/release-please)
    and [Release-plz](https://release-plz.ieni.dev/) build upon it).

    see also the Rust-written changelog generator [git-cliff](https://git-cliff.org/)

-   generate a `codemeta.json` file using pkg [codemetar](https://docs.ropensci.org/codemetar/)

-   release on CRAN:

    1.  Thoroughly scan exported fns for possible API improvements (which would be harder to introduce once the pkg is on CRAN) and other outstanding work and
        implement it.

        -   move `toml_*()` fns to sep pkg (tomlr?)

        -   remove deprecated fns: `as_flat_list()`, `fuse_regex()`, ...

            (lazier solution might be moving them to pkg salim and adapting downstream accordingly)

    2.  Replace `pkgsnip::*` with constants included in pkg. Make changes in a single commit (only incl. source file `Rmd/pal.Rmd`), so it can be easily
        reverted.

    3.  Remove Netlify redirect rule `/` -\> `/dev`.

    4.  Release pkg pkgsnip on CRAN.

    5.  Revert step 2.

