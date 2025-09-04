library(chromote)

# https://rstudio.github.io/chromote/

b <- ChromoteSession$new()
b$go_to("https://letterboxd.com/vhgauto/")
b$screenshot("img/posters.png", selector = ".poster-list", expand = 7)
b$close()

# 150 X 225

i <- magick::image_read("img/posters.png")

f_poster <- function(M) {
  i |>
    magick::image_crop(
      geometry = magick::geometry_area(
        width = 150,
        height = 225,
        x_off = 7 + (150 + 10) * M,
        y_off = 7
      ),
      gravity = "NorthEast"
    ) |>
    magick::image_write(paste0("img/poster_", M + 1, ".png"))
}

purrr::walk(0:3, f_poster)
