# Dataframes / Tibbles ----
test_that("`is_equal_df()` works as expected", {

  # different df's
  expect_true(is_equal_df(mtcars,
                          mtcars))

  expect_false(is_equal_df(mtcars,
                           cars))

  #
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

# R Markdown / Knitr ----


# R Packages ----
test_that("`README.Rmd` can be built successfully", {

  readr::write_file(x = "---
output: github_document
---

# hi there

nothing `r 'here.'`",
                    file = "README.Rmd")

  pal::build_readme()

  expect_match(object = readr::read_file("README.md"),
               regexp = "nothing here\\.")

  fs::file_delete(path = c("README.md",
                           "README.Rmd"))
})

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

# Miscellaneous ----

# Extending other R packages ----
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

  tmp_file <- fs::file_temp(ext = "txt")
  tmp_file2 <- fs::file_temp(ext = "txt")
  teardown(unlink(tmp_file))
  setup(readr::write_lines(x = before,
                           file = tmp_file),
        readr::write_lines(x = before,
                           file = tmp_file2))

  str_replace_file(path = c(tmp_file,
                            tmp_file2),
                   pattern,
                   process_line_by_line = TRUE,
                   verbose = FALSE)

  str_replace_file(path = c(tmp_file,
                            tmp_file2),
                   pattern,
                   process_line_by_line = FALSE,
                   verbose = FALSE)

  expect_identical(readr::read_lines(tmp_file),
                   after)
  expect_identical(readr::read_lines(tmp_file2),
                   after)
})
