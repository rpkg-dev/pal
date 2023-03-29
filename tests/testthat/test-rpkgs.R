# build_readme ----
# TODO: figure out why a `tests/testthat/README.html` file is created and kept when running the tests using `devtools::test()`
test_that("`README.Rmd` can be built successfully", {

  withr::local_file(.file = list("README.Rmd" = readr::write_file(file = "README.Rmd",
                                                                  x = paste("---",
                                                                            "output:",
                                                                            "  github_document:",
                                                                            "    html_preview: false",
                                                                            "---",
                                                                            "",
                                                                            "# hi there",
                                                                            "",
                                                                            "nothing `r 'here.'`",
                                                                            sep = "\n")),
                                 "README.md" = pal::build_readme()))

  expect_match(object = readr::read_file("README.md"),
               regexp = "nothing here\\.")
})

# is_pkg_installed ----
test_that("`is_pkg_installed()` works as expected", {

  expect_identical(is_pkg_installed(c("dplyr", "tibble", "not.a.real.package")),
                   c(dplyr = TRUE, tibble = TRUE, not.a.real.package = FALSE))

  expect_identical(is_pkg_installed(pkg = c("dplyr", "tibble", "magrittr"),
                                    min_version = c("1.0", "2.0", "99.9.9000")),
                   c(dplyr = TRUE, tibble = TRUE, magrittr = FALSE))

  # invalid `min_version` specifications
  expect_error(is_pkg_installed("dplyr", "lala"))
  expect_error(is_pkg_installed("dplyr", 0L))
  expect_error(is_pkg_installed("dplyr", -1.1))
})
