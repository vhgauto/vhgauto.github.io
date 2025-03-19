
# browseURL("https://nrennie.rbind.io/blog/script-templates-r/")

# mensaje -----------------------------------------------------------------

mensaje <- function(x) {
  cat(
    crayon::bgBlack(
      crayon::white(
        glue::glue(
          "\n\n--- {x} ---\n\n\n")
      )
    )
  )
}

# nueva semana ------------------------------------------------------------

# función que crea una nueva carpeta con un script para el procesamiento
# de los datos de {tidytuesday} de la semana de interés

nueva_semana <- function(semana_numero, año = 2025) {

  semana_numero <<- semana_numero

  # nombre de la carpeta a crear
  if (semana_numero <= 9) {
    semana_script <- glue::glue("tidytuesday/{año}/semana_0{semana_numero}.qmd")
  } else {
    semana_script <- glue::glue("tidytuesday/{año}/semana_{semana_numero}.qmd")
  }

  # archivo .R
  new_file <- file.path(semana_script)

  # verifico que la carpeta de la semana no exista
  semanas_ok <- list.files(glue::glue("{año}")) |>
    stringr::str_remove("s") |>
    as.numeric()

  if (length(semanas_ok) != 0 & mean(semanas_ok == semana_numero) != 0) {

    mensaje("Semana ya creada")

    system(glue::glue("open {new_file}"))

    stop()
  }

  # verifico que el número de semana sea correcto
  if (semana_numero %% as.integer(semana_numero) != 0) {

    stop(
      mensaje("Número de semana en formato incorrecto")
    )
  }

  # fecha del martes de la semana dada
  i <- seq.Date(
    from = lubridate::ymd(paste0(año, "0101")),
    to = lubridate::ymd(paste0(año, "1231")),
    by = "1 day"
  )
  fecha_tidytuesday <- i[lubridate::week(i) == semana_numero & lubridate::wday(i) == 3]

  if (!file.exists(new_file)) {
    file.create(new_file)

    # leo el contenido de la plantilla
    r_txt <- readLines("tidytuesday/_plantilla.qmd")

    # remplazo el año, nombre de carpeta y semana
    r_txt <- gsub(
      pattern = "X_año",
      replacement = año,
      x = r_txt
    )

    r_txt <- gsub(
      pattern = "X_semana",
      replacement = if (semana_numero < 10) paste0("0", semana_numero) else semana_numero,
      x = r_txt
    )

    r_txt <- gsub(
      pattern = "X_fecha",
      replacement = fecha_tidytuesday,
      x = r_txt
    )

    # creo el nuevo script
    writeLines(r_txt, con = new_file)

    mensaje(glue::glue("Script creado para semana {semana_numero}"))

  }

  file.edit(paste0(getwd(), '/', new_file))

}

l <- list.files("tidytuesday/2025/")
m <- l[stringr::str_detect(l, "semana_(.+)qmd")] |>
  stringr::str_extract(pattern = "semana_(.+)\\.qmd", group = 1) |>
  as.numeric() |>
  max()

mensaje(
  glue::glue(
    "Última semana: {crayon::bold(m)}"
  )
)

mensaje(
  glue::glue(
    "Usar {crayon::bold('nueva_semana()')} para iniciar el procesamiento"
  )
)
