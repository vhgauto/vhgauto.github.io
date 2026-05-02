readRenviron(".env")

m <- readr::read_tsv("datos/m.tsv", show_col_types = FALSE)

f_poster <- function(id) {
  l <- TMDb::search_movie(
    api_key = Sys.getenv("api_key_TMDb"),
    query = m$movie[id]
  ) |>
    purrr::pluck("results") |>
    tibble::as_tibble() |>
    tidyr::drop_na(release_date) |>
    dplyr::mutate(release_date = as.Date(release_date))

  p <- dplyr::select(l, release_date, poster_path) |>
    tidyr::drop_na() |>
    dplyr::mutate(d = lubridate::year(release_date) - m$year[id]) |>
    dplyr::slice_min(order_by = abs(d), n = 1) |>
    dplyr::pull(poster_path)

  download.file(
    url = paste0("https://image.tmdb.org/t/p/original/", p),
    mode = "wb",
    quiet = TRUE,
    destfile = paste0("img/poster_", id, ".jpg")
  )

  cat("Poster ", id, "🆗\n")
}

purrr::walk(1:4, f_poster)
