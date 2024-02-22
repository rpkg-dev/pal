# is_equal_df ----
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
                          mtcars[c(3:1, 4:nrow(mtcars)), ],
                          ignore_row_order = TRUE))

  expect_false(is_equal_df(mtcars,
                           mtcars[c(3:1, 4:nrow(mtcars)), ],
                           ignore_row_order = FALSE))

  # column types
  expect_true(is_equal_df(mtcars %>% tibble::as_tibble(),
                          mtcars %>% tibble::as_tibble() %>% dplyr::mutate(gear = as.integer(gear)),
                          ignore_col_types = TRUE))

  expect_false(is_equal_df(mtcars %>% tibble::as_tibble(),
                           mtcars %>% tibble::as_tibble() %>% dplyr::mutate(gear = as.integer(gear)),
                           ignore_col_types = FALSE))

  # type conversion
  mtcars_tibble <- mtcars %>% tibble::as_tibble(rownames = "model")

  expect_true(is_equal_df(mtcars_tibble,
                          mtcars_tibble %>% dplyr::mutate(model = as.factor(model)),
                          ignore_col_types = TRUE))

  expect_false(is_equal_df(mtcars_tibble,
                           mtcars_tibble %>% dplyr::mutate(model = as.factor(model)),
                           ignore_col_types = FALSE))

  # non-quiet
  expect_output(suppressMessages(is_equal_df(mtcars_tibble,
                                             mtcars_tibble %>% dplyr::mutate(model = as.factor(model)),
                                             ignore_col_types = FALSE,
                                             quiet = FALSE)),
                regexp = "a character vector.*an S3 object of class <factor>")

  # waldo object instead of a boolean
  expect_identical(is_equal_df(mtcars_tibble,
                               mtcars_tibble %>% dplyr::mutate(model = as.factor(model)),
                               return_waldo_compare = TRUE),
                   waldo::compare(mtcars_tibble,
                                  mtcars_tibble %>% dplyr::mutate(model = as.factor(model)),
                                  x_arg = "x",
                                  y_arg = "y",
                                  max_diffs = 10L))
})

# reduce_df_list ----
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
