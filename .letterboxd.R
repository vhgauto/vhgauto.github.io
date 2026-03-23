readRenviron(".env")

m <- readr::read_tsv("datos/m.tsv", show_col_types = FALSE)

f_poster <- function(id) {
  l <- TMDb::search_movie(
    api_key = Sys.getenv("api_key_TMDb"),
    query = m$movie[id]
  )$results$poster_path[1]

  download.file(
    url = paste0("https://image.tmdb.org/t/p/original/", l),
    mode = "wb",
    quiet = TRUE,
    destfile = paste0("img/poster_", id, ".jpg")
  )

  cat("Poster ", id, "🆗\n")
}

purrr::walk(1:4, f_poster)
