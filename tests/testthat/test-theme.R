test_that("theme sets local defaults without changing other plots", {
  p <- ggplot2::ggplot(mtcars, ggplot2::aes(wt, mpg)) + ggplot2::geom_point()
  before <- ggplot2::ggplot_build(p)$data[[1]]
  themed <- ggplot2::ggplot_build(p + theme_belarus())$data[[1]]
  expect_equal(themed$colour, rep("#B52B32", nrow(mtcars)))
  expect_equal(themed$shape, rep(15, nrow(mtcars)))
  expect_equal(ggplot2::ggplot_build(p)$data[[1]], before)
})

test_that("mapped groups and continuous values stay in the red palette", {
  p <- ggplot2::ggplot(mtcars, ggplot2::aes(wt, mpg, colour = factor(cyl))) +
    geom_stitch() + theme_belarus()
  colours <- unique(ggplot2::ggplot_build(p)$data[[1]]$colour)
  expect_length(colours, 3L)
  rgb <- grDevices::col2rgb(colours)
  expect_true(all(rgb[1, ] > rgb[2, ] & rgb[1, ] > rgb[3, ]))
  p <- ggplot2::ggplot(mtcars, ggplot2::aes(wt, mpg, colour = hp)) +
    geom_stitch() + theme_belarus()
  expect_no_error(ggplot2::ggplot_build(p))
})

test_that("patterns render with facets and flipped coordinates", {
  p <- ggplot2::ggplot(mtcars, ggplot2::aes(wt, mpg)) +
    geom_stitch() + ggplot2::facet_wrap(ggplot2::vars(cyl)) +
    ggplot2::coord_flip() + theme_belarus(stitch = 1)
  path <- tempfile(fileext = ".svg")
  grDevices::svg(path, width = 8, height = 5)
  expect_no_warning(print(p))
  grDevices::dev.off()
  expect_gt(file.info(path)$size, 1000)
  unlink(path)
})

test_that("invalid stitch spacing fails early", {
  expect_error(theme_belarus(stitch = 0))
  expect_error(element_stitch(stitch = NA_real_))
  expect_error(element_stitch(stitch = c(1, 2)))
})
