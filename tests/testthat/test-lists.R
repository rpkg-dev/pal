test_that("`as_flat_list()` works as expected", {

  # with defaults
  expect_identical(as_flat_list(NULL),
                   list(NULL))

  expect_identical(as_flat_list(1.0),
                   list(1.0))

  expect_identical(as_flat_list(1:3),
                   list(1:3))

  expect_identical(as_flat_list(list(list(factor("a"), factor("b")), factor("c"))),
                   list(factor("a"), factor("b"), factor("c")))

  expect_identical(as_flat_list(mtcars),
                   list(mtcars))

  expect_identical(as_flat_list(x = list(1:3, xfun::strict_list(list(list("buried deep"))))),
                   list(1:3, xfun::strict_list(list(list("buried deep")))))

  # with `is_node = is.list`
  ## atomic dfs are preserved as-is
  expect_identical(as_flat_list(x = mtcars,
                                is_node = is.list),
                   mtcars)
  ## nested dfs are unclassed
  expect_identical(as_flat_list(x = list(mtcars),
                                is_node = is.list),
                   as.list(mtcars))


  expect_identical(as_flat_list(list(1:3, xfun::strict_list(list(list("buried deep")))),
                                is_node = is.list),
                   list(1:3, "buried deep"))
})
