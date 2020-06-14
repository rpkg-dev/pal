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

# Miscellaneous ----
