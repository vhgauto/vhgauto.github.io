png(
  "img/favicon.png", width = 500, height = 500, units = "px", type = "cairo",
  bg = "#F6B40E"
)
terra::vect(
  data.frame(x = c(0, 1), y = c(0, 1)), geom = c("x", "y")
) |>
  terra::ext() |>
  terra::as.polygons() |>
  terra::plot(
    col = "#F6B40E", axes = FALSE, border = NA, xlim = c(0, 1), ylim = c(0, 1),
    mar = c(0, 0, 0, 0)
  )
dev.off()
