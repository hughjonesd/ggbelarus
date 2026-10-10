library(ggplot2)
devtools::load_all()

p <- ggplot(mtcars, aes(wt, mpg)) +
  geom_stitch(size = 4, stroke = 1) +
  labs(title = "Every stitch a small act",
    subtitle = "Red thread. White cloth. Belarus.",
    x = "Weight (1,000 lb)", y = "Miles per gallon",
    caption = "ggbelarus / demonstration data: mtcars") +
  theme_belarus()
ggsave("man/figures/stitches.png", p, width = 8, height = 6,
  dpi = 160, device = ragg::agg_png, bg = "white")

p <- ggplot(mtcars, aes(factor(cyl))) +
  geom_bar(width = 0.75) +
  labs(title = "White / red / white", x = "Cylinders", y = "Cars") +
  theme_belarus()
ggsave("man/figures/bars.png", p, width = 7, height = 5,
  dpi = 160, device = ragg::agg_png, bg = "white")

p <- ggplot(mtcars, aes(wt, mpg)) +
  geom_stitch(size = 3) +
  facet_wrap(vars(cyl), nrow = 1) +
  labs(title = "A pattern that repeats", x = "Weight", y = "Miles per gallon") +
  theme_belarus(base_size = 11)
ggsave("man/figures/facets.png", p, width = 10, height = 5,
  dpi = 160, device = ragg::agg_png, bg = "white")
