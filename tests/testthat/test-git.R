# git_file_mod_time ----
test_that("`git_file_mod_time()` works with relative path", {

  skip_if_not(condition = git2r::in_repository(),
              message = "Not in a Git repository")

  expect_vector(git_file_mod_time(path = "DESCRIPTION"),
                ptype = vctrs::new_datetime(),
                size = 1L)
})

test_that("`git_file_mod_time()` works with absolute path", {

  skip_if_not(condition = git2r::in_repository(),
              message = "Not in a Git repository")

  expect_vector(git_file_mod_time(path = fs::path_abs("DESCRIPTION")),
                ptype = vctrs::new_datetime(),
                size = 1L)
})
