# rename_from ----
test_that("`rename_from()` works as expected", {

  # chr vctr dict
  mtcars_renamed <- mtcars
  names(mtcars_renamed)[names(mtcars_renamed) == "mpg"] <- "Wrooom!"
  expect_identical(mtcars |> rename_from(dict = c(mpg = "Wrooom!",
                                                  not_there = "?")),
                   mtcars_renamed)
  # list dict
  mtcars_renamed <- mtcars
  names(mtcars_renamed)[names(mtcars_renamed) == "mpg"] <- "Wrooom!"
  expect_identical(mtcars |> rename_from(dict = list(mpg = "Wrooom!",
                                                     not_there = "?")),
                   mtcars_renamed)

  # length 0 input
  expect_identical(NULL |> rename_from(dict = list(mpg = "Wrooom!")),
                   NULL)
  expect_identical(character() |> rename_from(dict = list(mpg = "Wrooom!")),
                   character())
})
