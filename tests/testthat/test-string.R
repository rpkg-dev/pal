# fuse_regex ----
test_that("`fuse_regex()` works as expected", {

  expect_identical(fuse_regex(1:3),
                   "(1|2|3)")

  expect_identical(fuse_regex(1, 2, 3),
                   "(1|2|3)")
})

# prose_ls_fn_param ----
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

  ## test vector result
  expect_identical(prose_ls_fn_param(param = ".id",
                                     fn = dplyr::bind_rows,
                                     as_scalar = FALSE),
                   '`NULL`')

  # test primitive
  expect_identical(prose_ls_fn_param(param = "na.rm",
                                     fn = base::sum),
                   "`FALSE`")

  # test inexistent param
  expect_error(prose_ls_fn_param(param = ".name_repair99",
                                 fn = tibble::as_tibble),
               regexp = "does not have a parameter .*.name_repair99")

  # test param with no default
  expect_error(prose_ls_fn_param(param = "x",
                                 fn = tibble::as_tibble),
               regexp = "does not have a default value")
})
