# R Markdown / Knitr ----


# R Packages ----
test_that("`README.Rmd` can be built successfully.", {

  readr::write_file(x = "---
output: github_document
---

# hi there

nothing `r 'here.'`",
                    path = "README.Rmd")

  pal::build_readme()

  expect_match(object = readr::read_file("README.md"),
               regexp = "nothing here\\.")

  fs::file_delete(path = c("README.md",
                           "README.Rmd"))
})

# Statistical computing ----
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
                             na_rm = TRUE),
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

  tmp_file <- fs::file_temp(ext = "txt")
  tmp_file2 <- fs::file_temp(ext = "txt")
  teardown(unlink(tmp_file))
  setup(readr::write_lines(x = before,
                           path = tmp_file),
        readr::write_lines(x = before,
                           path = tmp_file2))

  str_replace_file(path = c(tmp_file,
                            tmp_file2),
                   pattern = c("(not (scarce|durable)|hard to transfer)" = "TULIPS \U0001F911",
                               ".*?[^r][ai]ble(?=, )" = " TUUULIPS \U0001F92A",
                               "tell me more about your analogy" = "go home already",
                               "\\Q[Naval Ravikant](https://twitter.com/naval/status/939316447318122496)" = "Nobody"),
                   process_line_by_line = TRUE,
                   verbose = FALSE)

  expect_identical(readr::read_lines(tmp_file),
                   after)
  expect_identical(readr::read_lines(tmp_file2),
                   after)
})
