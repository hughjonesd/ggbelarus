#' Cross-stitch points
#' @param mapping,data,...,na.rm,show.legend,inherit.aes Passed to [ggplot2::geom_point()].
#' @param size Stitch size in mm.
#' @param stroke Thread thickness.
#' @return A ggplot2 layer.
#' @export
geom_stitch <- function(mapping = NULL, data = NULL, ..., size = 3,
                        stroke = 0.7, na.rm = FALSE, show.legend = NA,
                        inherit.aes = TRUE) {
  ggplot2::geom_point(mapping = mapping, data = data, ..., shape = 4,
    size = size, stroke = stroke, na.rm = na.rm, show.legend = show.legend,
    inherit.aes = inherit.aes)
}
