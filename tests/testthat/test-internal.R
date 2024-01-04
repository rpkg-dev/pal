# env_var_name ----
test_that("`as_env_var_name()` works as expected", {

  expect_identical(as_env_var_name("only", "UPPERCASE?chars-plus:underscore"),
                   "ONLY_UPPERCASE_CHARS_PLUS_UNDERSCORE")
  expect_identical(as_env_var_name("1", "not start with", "digit"),
                   "_1_NOT_START_WITH_DIGIT")
})
