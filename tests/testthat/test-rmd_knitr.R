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
