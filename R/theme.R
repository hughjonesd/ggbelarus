#' Red and white embroidery
#'
#' Use a pattern-capable device: ragg, cairo_pdf, or svg.
#' @param base_size Text size in points.
#' @param base_family Font family.
#' @param stitch Stitch spacing in mm.
#' @param colour Thread colour.
#' @param paper Cloth colour.
#' @return A ggplot2 theme.
#' @export
#' @examples
#' library(ggplot2)
#' ggplot(mtcars, aes(wt, mpg)) + geom_point() + theme_belarus()
theme_belarus <- function(base_size = 12, base_family = "mono", stitch = 1.4,
                          colour = "#B52B32", paper = "white") {
  ggplot2::theme_bw(base_size = base_size, base_family = base_family,
                    ink = colour, paper = paper, accent = colour) +
    ggplot2::theme(
      geom = ggplot2::element_geom(ink = colour, paper = paper,
        accent = colour, colour = colour, fill = colour,
        pointshape = 15, pointsize = 2.5, linewidth = 0.8),
      palette.colour.discrete = grDevices::colorRampPalette(c(colour,
        grDevices::adjustcolor(colour, offset = c(0.35, 0.35, 0.35, 0)))),
      palette.fill.discrete = grDevices::colorRampPalette(c(colour,
        grDevices::adjustcolor(colour, offset = c(0.35, 0.35, 0.35, 0)))),
      palette.colour.continuous = c(paper, colour),
      palette.fill.continuous = c(paper, colour),
      plot.background = element_stitch(stitch, colour, paper, "border"),
      plot.margin = ggplot2::margin(stitch * 10, stitch * 10,
        stitch * 10, stitch * 10, unit = "mm"),
      panel.background = element_stitch(stitch, colour, paper, "cloth"),
      panel.grid = ggplot2::element_blank(),
      panel.border = ggplot2::element_rect(fill = NA, colour = colour,
        linewidth = 0.8, linetype = "dotted"),
      axis.ticks = ggplot2::element_line(colour = colour, linewidth = 0.8),
      axis.ticks.length = grid::unit(1.5, "mm"),
      axis.text = ggplot2::element_text(colour = colour),
      plot.title = ggplot2::element_text(face = "bold", size = ggplot2::rel(1.5),
        margin = ggplot2::margin(b = 8)),
      plot.subtitle = ggplot2::element_text(margin = ggplot2::margin(b = 12)),
      plot.caption = ggplot2::element_text(hjust = 0,
        margin = ggplot2::margin(t = 10)),
      strip.background = ggplot2::element_rect(fill = colour, colour = colour),
      strip.text = ggplot2::element_text(colour = paper, face = "bold",
        margin = ggplot2::margin(6, 8, 6, 8)),
      panel.spacing = grid::unit(5, "mm"),
      legend.key = ggplot2::element_rect(fill = paper, colour = NA),
      legend.background = ggplot2::element_rect(fill = paper, colour = NA),
      legend.position = "bottom",
      legend.title = ggplot2::element_text(face = "bold")
    )
}

#' Stitched cloth or border
#' @param stitch Stitch spacing in mm.
#' @param colour Thread colour.
#' @param paper Cloth colour.
#' @param pattern Either `"border"` or `"cloth"`.
#' @return A ggplot2 rectangle element.
#' @export
element_stitch <- function(stitch = 1.4, colour = "#B52B32", paper = "white",
                           pattern = c("border", "cloth")) {
  stopifnot(is.numeric(stitch), length(stitch) == 1L,
            is.finite(stitch), stitch > 0)
  pattern <- match.arg(pattern)
  if (pattern == "border") {
    tile <- grid::gTree(stitch = stitch, colour = colour, paper = paper,
                       cl = "belarus_border")
    fill <- grid::pattern(tile, extend = "none")
  } else {
    tile <- grid::grobTree(
      grid::rectGrob(gp = grid::gpar(fill = paper, col = NA)),
      grid::segmentsGrob(x0 = c(0.5, 0), y0 = c(0, 0.5),
        x1 = c(0.5, 1), y1 = c(1, 0.5),
        gp = grid::gpar(col = grDevices::adjustcolor(colour, alpha.f = 0.13),
                       lwd = 0.4)),
      vp = grid::viewport(width = grid::unit(stitch, "mm"),
                          height = grid::unit(stitch, "mm"))
    )
    fill <- grid::pattern(tile, width = grid::unit(stitch, "mm"),
      height = grid::unit(stitch, "mm"), extend = "repeat")
  }
  ggplot2::element_rect(fill = fill, colour = NA)
}

#' @export
#' @importFrom grid makeContent
makeContent.belarus_border <- function(x) {
  width <- grid::convertWidth(grid::unit(1, "npc"), "mm", valueOnly = TRUE)
  height <- grid::convertHeight(grid::unit(1, "npc"), "mm", valueOnly = TRUE)
  nx <- max(1L, floor(width / x$stitch))
  ny <- max(1L, floor(height / x$stitch))
  cells <- expand.grid(col = seq_len(nx), row = seq_len(ny))
  # Seven rows of diamonds, crosses, and a running stitch on each edge.
  dx <- abs((cells$col - 1L) %% 12L - 5L)
  dy <- pmin(cells$row - 1L, ny - cells$row)
  horizontal <- dy < 7L & (dx + abs(dy - 3L) == 3L |
    (dx == 0L & abs(dy - 3L) <= 1L) |
    (dy == 6L & cells$col %% 2L == 0L))
  dx <- pmin(cells$col - 1L, nx - cells$col)
  dy <- abs((cells$row - 1L) %% 12L - 5L)
  vertical <- dx < 7L & (dy + abs(dx - 3L) == 3L |
    (dy == 0L & abs(dx - 3L) <= 1L) |
    (dx == 6L & cells$row %% 2L == 0L))
  cells <- cells[horizontal | vertical, ]
  cx <- (cells$col - 0.5) * x$stitch + (width - nx * x$stitch) / 2
  cy <- (cells$row - 0.5) * x$stitch + (height - ny * x$stitch) / 2
  half <- x$stitch * 0.38
  stitches <- grid::segmentsGrob(
    x0 = grid::unit(c(cx - half, cx - half), "mm"),
    y0 = grid::unit(c(cy - half, cy + half), "mm"),
    x1 = grid::unit(c(cx + half, cx + half), "mm"),
    y1 = grid::unit(c(cy + half, cy - half), "mm"),
    gp = grid::gpar(col = x$colour, lwd = x$stitch * 0.65, lineend = "square")
  )
  grid::setChildren(x, grid::gList(
    grid::rectGrob(gp = grid::gpar(fill = x$paper, col = NA)), stitches
  ))
}
