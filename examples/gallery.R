library(ggplot2)
devtools::load_all()

p <- ggplot(mtcars, aes(wt, mpg)) +
  geom_stitch(size = 4, stroke = 1) +
  labs(title = "Fuel economy and vehicle weight",
    subtitle = "1974 Motor Trend road tests",
    x = "Weight (1,000 lb)", y = "Miles per gallon",
    caption = "ggbelarus / demonstration data: mtcars") +
  theme_belarus()
ggsave("man/figures/stitches.png", p, width = 8, height = 6,
  dpi = 160, device = ragg::agg_png, bg = "white")

p <- ggplot(mtcars, aes(factor(cyl))) +
  geom_bar(width = 0.75) +
  labs(title = "Cars by cylinder count",
    subtitle = "1974 Motor Trend road tests",
    x = "Cylinders", y = "Cars") +
  theme_belarus()
ggsave("man/figures/bars.png", p, width = 7, height = 5,
  dpi = 160, device = ragg::agg_png, bg = "white")

p <- ggplot(palmerpenguins::penguins, aes(bill_length_mm, bill_depth_mm)) +
  geom_stitch(size = 3, na.rm = TRUE) +
  facet_wrap(vars(species), nrow = 1) +
  labs(title = "Penguin bills by species",
    subtitle = "Palmer Archipelago, Antarctica",
    x = "Bill length (mm)", y = "Bill depth (mm)") +
  theme_belarus(base_size = 11)
ggsave("man/figures/facets.png", p, width = 10, height = 5,
  dpi = 160, device = ragg::agg_png, bg = "white")
