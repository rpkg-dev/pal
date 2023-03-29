# cli_process_expr ----
test_that("`cli_process_expr()` works as expected", {

  test <- function() {

    local_string <- "WRONG-fn"
    fn_string <- "good"
    local_col_name <- "WRONG-fn"
    fn_col_name <- "Petal.Width"

    cli_process_expr(msg = "Omnitest",
                     expr = {

                       cat("\n")
                       local_string <- "good"
                       local_col_name <- "Species"

                       expect_error(iris %>% dplyr::select(!!fn_string))

                       expect_identical(global_string, "good")
                       expect_identical(fn_string, "good")
                       expect_identical(local_string, "good")
                       expect_identical(iris %>% dplyr::select(!!global_col_name) %>% ncol(),
                                        1L)
                       expect_identical(iris %>% dplyr::select(!!fn_col_name) %>% ncol(),
                                        1L)
                       expect_identical(iris %>% dplyr::select(!!local_col_name) %>% ncol(),
                                        1L)
                     })
  }

  local_string <- "WRONG-global"
  local_col_name <- "WRONG-global"
  fn_string <- "WRONG-global"
  fn_col_name <- "WRONG-global"
  global_string <- "good"
  global_col_name <- "Petal.Length"

  test()
})
