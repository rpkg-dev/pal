# Dataframes / Tibbles ----
## is_equal_df ----
test_that("`is_equal_df()` works as expected", {

  # different df's
  expect_true(is_equal_df(mtcars,
                          mtcars))

  expect_false(is_equal_df(mtcars,
                           cars))

  # column order
  expect_true(is_equal_df(mtcars,
                          mtcars %>% dplyr::select(3, everything()),
                          ignore_col_order = TRUE))

  expect_false(is_equal_df(mtcars,
                           mtcars %>% dplyr::select(3, everything()),
                           ignore_col_order = FALSE))

  # row order
  expect_true(is_equal_df(mtcars,
                          mtcars[c(3, 2, 1, 4:nrow(mtcars)), ],
                          ignore_row_order = TRUE))

  expect_false(is_equal_df(mtcars,
                           mtcars[c(3, 2, 1, 4:nrow(mtcars)), ],
                           ignore_row_order = FALSE))

  # type conversion
  mtcars_tibble <- mtcars %>% tibble::as_tibble(rownames = "model")

  expect_true(is_equal_df(mtcars_tibble,
                          mtcars_tibble %>% dplyr::mutate(model = as.factor(model)),
                          convert = TRUE))

  expect_false(is_equal_df(mtcars_tibble,
                           mtcars_tibble %>% dplyr::mutate(model = as.factor(model)),
                           convert = FALSE))

  # non-quiet
  expect_message(is_equal_df(mtcars_tibble,
                             mtcars_tibble %>% dplyr::mutate(model = as.factor(model)),
                             convert = FALSE,
                             quiet = FALSE),
                 regexp = "Different types for column `model`: character vs factor")

  # colum name repair
  expect_message(is_equal_df(mtcars_tibble %>% dplyr::rename(`mod el` = model),
                             mtcars_tibble %>% dplyr::rename(`mod el` = model),
                             name_repair = "universal"),
                 regexp = "`mod el` -> mod\\.el")
})

## reduce_df_list ----
test_that("`reduce_df_list()` works as expected", {

  mtcars_tibble <- tibble::as_tibble(mtcars,
                                     rownames = "model")
  df_list <- list(mtcars_tibble[1:4, ],
                  list(mtcars_tibble[5:8, ],
                       list(mtcars_tibble[9:12, ])),
                  list(list(list(mtcars_tibble[13:16, ]))),
                  mtcars_tibble[17:20, ],
                  list(list(mtcars_tibble[21:24, ]),
                       mtcars_tibble[25:28, ]),
                  mtcars_tibble[29:32, ])

  expect_identical(df_list %>% reduce_df_list(strict = TRUE) %>% dplyr::arrange(model),
                   mtcars_tibble %>% dplyr::arrange(model))

  expect_error(reduce_df_list(x = c(df_list, "not a tibble"),
                              strict = TRUE))

  expect_identical(c(df_list, "not a tibble") %>% reduce_df_list(strict = FALSE) %>% dplyr::arrange(model),
                   mtcars_tibble %>% dplyr::arrange(model))
})

# Pandoc Markdown ----
## strip_md ----
test_that("`strip_md()` works as expected", {

  # basic
  expect_identical(strip_md("Some **MD** formatted [string](https://en.wikipedia.org/wiki/String_(computer_science))"),
                   "Some MD formatted string")

  # footnotes
  expect_identical(strip_md("Some **MD** formatted _string_ with a footnote ref[^bla]",
                            strip_footnotes = TRUE),
                   "Some MD formatted string with a footnote ref")

  expect_identical(strip_md("Some **MD** formatted _string_ with a footnote ref[^bla]",
                            strip_footnotes = FALSE),
                   "Some MD formatted string with a footnote ref[^bla]")

  expect_identical(strip_md("Some **MD** formatted _string_ with an inline^[footnote] footnote",
                            strip_footnotes = TRUE),
                   "Some MD formatted string with an inline footnote")

  expect_identical(strip_md("Some **MD** formatted _string_ with an inline^[footnote] footnote",
                            strip_footnotes = FALSE),
                   "Some MD formatted string with an inline^[footnote] footnote")
})

# R Markdown / Knitr ----
## knitr_table_format ----
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

# R Packages ----
## build_readme ----
test_that("`README.Rmd` can be built successfully", {

  withr::local_file(.file = list("README.Rmd" = readr::write_file(file = "README.Rmd",
                                                                  x = "---
output: github_document
---

# hi there

nothing `r 'here.'`"),
                                 "README.md" = pal::build_readme()))

  expect_match(object = readr::read_file("README.md"),
               regexp = "nothing here\\.")
})

## is_pkg_installed ----
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

# Statistical computing ----
## round_to ----
test_that("`round_to()` works as expected", {

  expect_equal(round_to(x = c(0.125, 0.1999, 0.099999, 0.49, 0.55, 0.5, 0.9, 1, 2.02),
                        to = 0.05,
                        round_up = TRUE),
               c(0.15, 0.20, 0.10, 0.50, 0.55, 0.50, 0.90, 1.00, 2.00))

  expect_equal(round_to(x = c(0.125, 0.1999, 0.099999, 0.49, 0.55, 0.5, 0.9, 1, 2.02),
                        to = 0.05,
                        round_up = FALSE),
               c(0.10, 0.20, 0.10, 0.50, 0.55, 0.50, 0.90, 1.00, 2.00))

  expect_equal(round_to(x = 0.5,
                        to = 0.2,
                        round_up = TRUE),
               0.6)
})
## safe_min ----
test_that("`safe_min()` returns proper output types", {

  expect_identical(safe_min(NULL),
                   NULL)
  expect_identical(safe_min(NA),
                   NA)
  expect_identical(safe_min(NA_character_),
                   NA_character_)
  expect_identical(safe_min(NA_integer_),
                   NA_integer_)
  expect_identical(safe_min(NA_real_),
                   NA_real_)
  expect_identical(safe_min(character()),
                   character())
  expect_identical(safe_min(integer()),
                   integer())
  expect_identical(safe_min(numeric()),
                   numeric())
  expect_identical(safe_min(1L, 2),
                   1)
  expect_identical(safe_min(1L, 2L),
                   1L)
  expect_error(safe_min("one", 1))
})

## safe_max ----
test_that("`safe_max()` returns proper output types", {

  expect_identical(safe_max(NULL),
                   NULL)
  expect_identical(safe_max(NA),
                   NA)
  expect_identical(safe_max(NA_character_),
                   NA_character_)
  expect_identical(safe_max(NA_integer_),
                   NA_integer_)
  expect_identical(safe_max(NA_real_),
                   NA_real_)
  expect_identical(safe_max(character()),
                   character())
  expect_identical(safe_max(integer()),
                   integer())
  expect_identical(safe_max(numeric()),
                   numeric())
  expect_identical(safe_max(1L, 2),
                   2)
  expect_identical(safe_max(1L, 2L),
                   2L)
  expect_error(safe_max("one", 1))
})

## stat_mode ----
test_that("`stat_mode()` properly determines a single mode", {

  # integer
  expect_identical(stat_mode(1:9),
                   NA_integer_)
  expect_identical(stat_mode(c(rep(3L, times = 3), 1:9)),
                   3L)

  # double
  expect_identical(stat_mode(c(1, 2, 3)),
                   NA_real_)
  expect_identical(stat_mode(c(3.0, 1:9)),
                   3.0)

  # character
  expect_identical(stat_mode(letters),
                   NA_character_)
  expect_identical(stat_mode(c(letters, "a")),
                   "a")
})

test_that("`stat_mode()` properly determines multiple modes if requested", {

  # NA by default
  expect_identical(stat_mode(c(letters, "a", "b")),
                   NA_character_)

  # multiple modes
  expect_identical(stat_mode(c(letters, "a", "b"),
                             type = "all"),
                   c("a", "b"))
})

test_that("`stat_mode()` ignores `NA`s if requested", {

  expect_identical(stat_mode(c(letters, "a", NA_character_, NA_character_),
                             type = "all"),
                   c("a", NA_character_))

  expect_identical(stat_mode(c(letters, "a", NA_character_, NA_character_),
                             type = "all",
                             rm_na = TRUE),
                   "a")
})

# Strings ----
## prose_ls_fn_param ----
test_that("`prose_ls_fn_param()` works as expected", {

  # test with internal fns
  expect_identical(prose_ls_fn_param(param = "wrap",
                                     fn = prose_ls),
                   '`""`')

  expect_identical(prose_ls_fn_param(param = "wrap",
                                     fn = "prose_ls"),
                   '`""`')

  expect_identical(prose_ls_fn_param(param = "type",
                                     fn = stat_mode),
                   '`"one"`,`"all"` or `"n"`')

  ## test vector result
  expect_identical(prose_ls_fn_param(param = "type",
                                     fn = stat_mode,
                                     as_scalar = FALSE),
                   c('`"one"`', '`"all"`', '`"n"`'))

  ## test non-character results
  expect_identical(prose_ls_fn_param(param = ".default",
                                     fn = cols_regex),
                   '`readr::col_character()`')

  expect_identical(prose_ls_fn_param(param = "env",
                                     fn = cli_process_expr),
                   '`parent.frame()`')

  expect_identical(prose_ls_fn_param(param = "msg_done",
                                     fn = cli_process_expr),
                   '`paste(msg, "... done")`')

  # test with external fns
  expect_identical(prose_ls_fn_param(param = ".name_repair",
                                     fn = tibble::as_tibble),
                   '`"check_unique"`,`"unique"`,`"universal"` or `"minimal"`')

  expect_identical(prose_ls_fn_param(param = ".name_repair",
                                     fn = "as_tibble",
                                     env = environment(tibble::as_tibble)),
                   '`"check_unique"`,`"unique"`,`"universal"` or `"minimal"`')

  ## test non-character results
  expect_identical(prose_ls_fn_param(param = ".id",
                                     fn = dplyr::bind_rows),
                   '`NULL`')

  ### test vector result
  expect_identical(prose_ls_fn_param(param = ".id",
                                     fn = dplyr::bind_rows,
                                     as_scalar = FALSE),
                   '`NULL`')





  # test inexistent param
  expect_error(prose_ls_fn_param(param = ".name_repair99",
                                     fn = tibble::as_tibble),
               regexp = "does not have a parameter .*.name_repair99")

  # test param with no default
  expect_error(prose_ls_fn_param(param = "x",
                                 fn = tibble::as_tibble),
               regexp = "does not have a default value")

  # test unsupported primitive
  expect_error(prose_ls_fn_param(param = "x",
                                 fn = base::as.character),
               regexp = "Primitives .* not supported")
})

## str_replace_file ----
test_that("`str_replace_file()` basically works", {

  before <- c('"Tulips are not durable, ',
              ' not scarce, ',
              ' not programmable, ',
              ' not fungible, ',
              ' not verifiable, ',
              ' not divisible, ',
              ' and hard to transfer. ',
              ' But tell me more about your analogy..." ',
              '',
              '-[Naval Ravikant](https://twitter.com/naval/status/939316447318122496)')

  after <- c('"Tulips are TULIPS \U0001F911, ',
             ' TULIPS \U0001F911, ',
             rep(" TUUULIPS \U0001F92A, ",
                 times = 4L),
             ' and TULIPS \U0001F911. ',
             ' But go home already..." ',
             '',
             '-Nobody')

  pattern = c("(not (scarce|durable)|hard to transfer)" = "TULIPS \U0001F911",
              " not \\w+?[^r][ai]ble(?=, )" = " TUUULIPS \U0001F92A",
              "tell me more about your analog(y)" = "go home alread\\1",
              "\\Q[Naval Ravikant](https://twitter.com/naval/status/939316447318122496)" = "Nobody")

  withr::local_file(.file = list(
    "test_file_1.txt" = {
      readr::write_lines(x = before,
                         file = "test_file_1.txt")
      str_replace_file(path = "test_file_1.txt",
                       pattern,
                       process_line_by_line = TRUE,
                       verbose = FALSE)},
    "test_file_2.txt" = {
      readr::write_lines(x = before,
                         file = "test_file_2.txt")
      str_replace_file(path = "test_file_2.txt",
                       pattern,
                       process_line_by_line = FALSE,
                       verbose = FALSE)}))

  expect_identical(readr::read_lines("test_file_1.txt"),
                   after)
  expect_identical(readr::read_lines("test_file_2.txt"),
                   after)
})
