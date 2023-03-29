# strip_md ----
test_that("`strip_md()` works as expected", {

  # basic
  expect_identical(strip_md("Some **MD** formatted [string](https://en.wikipedia.org/wiki/String_(computer_science))"),
                   "Some MD formatted string")

  # footnotes
  expect_identical(strip_md("Some **MD** formatted _string_ with a footnote ref[^bla]",
                            strip_footnotes = TRUE),
                   "Some MD formatted string with a footnote ref")

  expect_identical(strip_md("Some **MD** formatted _string_ with a footnote ref[^bla]",
                            strip_footnotes = FALSE),
                   "Some MD formatted string with a footnote ref[^bla]")

  expect_identical(strip_md("Some **MD** formatted _string_ with an inline^[footnote] footnote",
                            strip_footnotes = TRUE),
                   "Some MD formatted string with an inline footnote")

  expect_identical(strip_md("Some **MD** formatted _string_ with an inline^[footnote] footnote",
                            strip_footnotes = FALSE),
                   "Some MD formatted string with an inline^[footnote] footnote")
})

# strip_md_footnotes ----
test_that("`strip_md_footnotes()` works as expected", {

  expect_identical(strip_md_footnotes("Some **MD** formatted [string](https://en.wikipedia.org/wiki/String_(computer_science))"),
                   "Some **MD** formatted [string](https://en.wikipedia.org/wiki/String_(computer_science))")

  expect_identical(strip_md_footnotes(NA_character_),
                   NA_character_)

  expect_identical(strip_md_footnotes(c("Blabla", NA_character_, "Some **MD** formatted _string_ with an inline^[bla bli blu] footnote")),
                   c("Blabla", NA_character_, "Some **MD** formatted _string_ with an inline footnote"))

  expect_identical(strip_md_footnotes("A footnote ref[^bla].\n\n[^bla]: bli blu\n\n    more bla\neven more bla\n\n    ```\nand some code```\n"),
                   "A footnote ref.")

  expect_identical(strip_md_footnotes("A footnote ref[^bla] with broken def.\n\n[^bla]: bli blu\n\n\n    more bla"),
                   "A footnote ref with broken def.\n\n    more bla")
})
