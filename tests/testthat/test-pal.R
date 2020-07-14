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
