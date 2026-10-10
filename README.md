# ggbelarus

A ggplot theme inspired by Belarusian cross-stitch.

```r
remotes::install_github("hughjonesd/ggbelarus")
library(ggplot2)
library(ggbelarus)

ggplot(mtcars, aes(wt, mpg)) +
  geom_stitch(size = 4, stroke = 1) +
  labs(
    title = "Fuel economy and vehicle weight",
    subtitle = "1974 Motor Trend road tests",
    x = "Weight (1,000 lb)",
    y = "Miles per gallon",
    caption = "ggbelarus / demonstration data: mtcars"
  ) +
  theme_belarus()
```

![Stitches](man/figures/stitches.png)

`theme_belarus(stitch = 1.4)` controls stitch spacing in mm.
Ordinary points default to red squares. `geom_stitch()` draws crosses.
Use ragg PNG, `cairo_pdf`, or `svg` as a device to support
the grid-pattern feature. 

```r
ggplot(mtcars, aes(factor(cyl))) +
  geom_bar(width = 0.75) +
  labs(
    title = "Cars by cylinder count",
    subtitle = "1974 Motor Trend road tests",
    x = "Cylinders",
    y = "Cars"
  ) +
  theme_belarus()
```

![Bars](man/figures/bars.png)

```r
ggplot(
  palmerpenguins::penguins,
  aes(bill_length_mm, bill_depth_mm)
) +
  geom_stitch(size = 3, na.rm = TRUE) +
  facet_wrap(vars(species), nrow = 1) +
  labs(
    title = "Penguin bills by species",
    subtitle = "Palmer Archipelago, Antarctica",
    x = "Bill length (mm)",
    y = "Bill depth (mm)"
  ) +
  theme_belarus(base_size = 11)
```

![Facets](man/figures/facets.png)

Inspired by Belarusian embroidery and Rufina Bazlova's illustrations in
[The Economist](https://www.economist.com/interactive/europe/2026/10/09/belarus-is-becoming-increasingly-russian).

