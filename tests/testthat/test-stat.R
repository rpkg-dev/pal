# round_to ----
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

# safe_min ----
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

# safe_max ----
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

# stat_mode ----
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
