# dsv_colnames ----
test_that("`dsv_colnames()` hadnles", {

  raw_csv <-
    httr2::request(base_url = "https://salim_b.gitlab.io/misc/Kantonsratswahl_Zuerich_2019_Ergebnisse_Gemeinden.csv") |>
    httr2::req_perform() |>
    httr2::resp_body_string()

  # this CSV file has a UTF-8 BOM and uses Windows-style line breaks (`\r\n\`); ensure the latter aren't spuriously included
  expect_identical(dsv_colnames(raw_csv),
                   c("Gemeindenamen",
                     "BFS-Nr.",
                     "Listen-Nr.",
                     "Liste",
                     "Wahlkreis-Nr.",
                     "Wahlkreis",
                     "Stimmen",
                     "Stimmenanteil",
                     "+/- (Stimmenanteil)",
                     "Stimmenzusatz",
                     "Wähler",
                     "Wähleranteil",
                     "+/- (Wähleranteil)",
                     "Stimmenanteil 2015",
                     "Wähleranteil 2015"))
})

# fn_param_defaults ----
test_that("`fn_param_defaults()` works as expected", {

  # test with internal fns
  expect_identical(fn_param_defaults(param = "wrap",
                                     fn = enum_str),
                   '""')

  expect_identical(fn_param_defaults(param = "wrap",
                                     fn = "enum_str"),
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
                   c('"check_unique"', '"unique"', '"universal"', '"minimal"', '"unique_quiet"', '"universal_quiet"'))

  expect_identical(fn_param_defaults(param = ".name_repair",
                                     fn = "as_tibble",
                                     env = environment(tibble::as_tibble)),
                   c('"check_unique"', '"unique"', '"universal"', '"minimal"', '"unique_quiet"', '"universal_quiet"'))

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

# fuse_regex ----
test_that("`fuse_regex()` works as expected", {

  expect_identical(fuse_regex(1:3),
                   "(1|2|3)")

  expect_identical(fuse_regex(1, 2, 3),
                   "(1|2|3)")
})
