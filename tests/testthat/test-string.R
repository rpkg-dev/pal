# fuse_regex ----
test_that("`fuse_regex()` works as expected", {

  expect_identical(fuse_regex(1:3),
                   "(1|2|3)")

  expect_identical(fuse_regex(1, 2, 3),
                   "(1|2|3)")
})

# fn_param_defaults ----
test_that("`fn_param_defaults()` works as expected", {

  # test with internal fns
  expect_identical(fn_param_defaults(param = "wrap",
                                     fn = prose_ls),
                   '""')

  expect_identical(fn_param_defaults(param = "wrap",
                                     fn = "prose_ls"),
                   '""')

  expect_identical(fn_param_defaults(param = "type",
                                     fn = stat_mode),
                   c('"one"','"all"', '"n"'))

  ## test non-character results
  expect_identical(fn_param_defaults(param = ".default",
                                     fn = cols_regex),
                   'readr::col_character()')

  expect_identical(fn_param_defaults(param = "env",
                                     fn = cli_process_expr),
                   'parent.frame()')

  expect_identical(fn_param_defaults(param = "msg_done",
                                     fn = cli_process_expr),
                   'paste(msg, "... done")')

  # test with external fns
  expect_identical(fn_param_defaults(param = ".name_repair",
                                     fn = tibble::as_tibble),
                   c('"check_unique"', '"unique"', '"universal"', '"minimal"'))

  expect_identical(fn_param_defaults(param = ".name_repair",
                                     fn = "as_tibble",
                                     env = environment(tibble::as_tibble)),
                   c('"check_unique"', '"unique"', '"universal"', '"minimal"'))

  ## test non-character results
  expect_identical(fn_param_defaults(param = ".id",
                                     fn = dplyr::bind_rows),
                   'NULL')

  ## test primitive
  expect_identical(fn_param_defaults(param = "na.rm",
                                     fn = base::sum),
                   "FALSE")

  ## test inexistent param
  expect_error(fn_param_defaults(param = ".name_repair99",
                                 fn = tibble::as_tibble),
               regexp = "does not have a parameter .*.name_repair99")

  ## test param with no default
  expect_error(fn_param_defaults(param = "x",
                                 fn = tibble::as_tibble),
               regexp = "does not have a default value")
})
