
# paquetes ----------------------------------------------------------------

library(tidyverse)

# funciones ---------------------------------------------------------------

# genera los links de los scripts
f_link <- function(x) {
  paste0(
    "https://raw.githubusercontent.com/vhgauto/tidytuesday/refs/heads/main/2023/semana_",
    x, "/2023-s", x, "_script.R"
  )
}

# genera los links de las imágenes
f_imagen <- function(x) {
  paste0(
    "https://raw.githubusercontent.com/vhgauto/tidytuesday/refs/heads/main/2023/semana_",
    x,"/viz.png"
  )
}

# genera el prólogo
f_prologo <- function(semana, fecha, categorias, imagen) {
  p <- gsub("x_semana", semana, prologo)
  p <- gsub("x_fecha", fecha, p)
  p <- gsub("x_categorias", categorias, p)
  p <- gsub("x_imagen", imagen, p)
  return(p)
}

# genera el contenido del .qmd
f_qmd <- function(prologo, script, imagen) {
  p <- gsub("x_prologo", prologo, cuerpo)
  p <- gsub("x_script", script, p)
  p <- gsub("x_imagen", imagen, p)
  return(p)
}

# genera el .qmd a partir de la semana
f_principal <- function(semana) {
  l <- f_link(semana)
  i <- f_imagen(semana)

  ll <- readLines(l)

  categ <- tibble(
    tex = ll
  ) |>
    filter(str_detect(tex, "geom_")) |>
    mutate(tex = str_trim(tex)) |>
    mutate(
      tex = str_extract(tex, "geom_\\w+")
    ) |>
    distinct() |>
    pull() |>
    str_flatten(", ")

  fecha <- ymd(20230101) + weeks(semana)

  prologo <- f_prologo(
    semana = semana, fecha = fecha, categorias = categ, imagen = i
  )

  qmd <- f_qmd(prologo = prologo, script = str_flatten(ll, "\n"), imagen = i)

  writeLines(qmd, paste0("tidytuesday/2023/semana_", semana, ".qmd"))

  print(glue::glue("\n\n--- Semana {semana} --- \n\n"))

}

# variables ---------------------------------------------------------------

prologo <- '---
title: "Semana x_semana"
subtitle: "Figura semana x_semana"
author: Víctor Gauto
date: "x_fecha"
editor_options:
  chunk_output_type: console
categories: [x_categorias]
image: x_imagen
execute:
  eval: false
  echo: true
code-fold: true
---
'

cuerpo <- 'x_prologo

# Script

```{r}
x_script
```

# Figura

![](x_imagen)

'

# ejecución ---------------------------------------------------------------

# una semana específica
f_principal(semana = "07")

# múltiples semanas
semana <- as.character(12:52)
map(semana, f_principal)
