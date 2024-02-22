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
                                 "README.md" = pal::build_readme(quiet = TRUE)))

  expect_match(object = readr::read_file("README.md"),
               regexp = "nothing here\\.")
})

# knitr_table_format ----
test_that("`knitr_table_format()` works as supposed", {

  withr::with_options(new = list(knitr.table.format = "html"),
                      code = expect_identical(knitr_table_format(),
                                              "html"))

  withr::with_options(new = list(knitr.table.format = "latex"),
                      code = expect_identical(knitr_table_format(),
                                              "latex"))

  withr::with_options(new = list(knitr.table.format = NULL),
                      code = expect_identical(knitr_table_format(default = "latex"),
                                              "latex"))

  withr::with_options(new = list(knitr.table.format = function() if (knitr::is_latex_output()) "latex" else "html"),
                      code = expect_identical(knitr_table_format(),
                                              "html"))
})
