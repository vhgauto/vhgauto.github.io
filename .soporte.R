
sep <- "<b style='color:red;'>|</b>"
i_link <- "<span class='nf nf-cod-link_external nf-lista'></span>"
i_titulo <- "<span class='nf nf-fa-user_graduate nf-lista'></span>"
i_institucion <- "<span class='nf nf-fa-university nf-lista'></span>"
i_ubicacion <- "<span class='nf nf-fa-location_dot nf-lista'></span>"
i_calendario <- "<span class='nf nf-fa-calendar_days nf-lista'></span>"

f_link <- function(institucion, link) {
  paste0(
    "<a href='",
    link,
    "'> ",
    institucion,
    i_link,
    "</a>"
  )
}

f_div <- function(i, x) {
  glue::glue(
    "\n
    :::: {{.grid style='--bs-columns: 12; --bs-gap: 0rem'}}
    ::: {{.g-col-1 style='text-align: center;'}}
    <p class='estrecho'>{i}</p>
    :::

    ::: {{.g-col-11}}
    <p class='estrecho'>{x}</p>
    :::

    ::::\n
    "
  )
}

f_edu <- function(titulo, institucion, ubicacion, calendario) {
  paste0(
    f_div(i_titulo, paste0("<b style='font-size:1.2em'>", titulo, "</b>")),
    f_div(i_institucion, institucion),
    f_div(i_ubicacion, ubicacion),
    f_div(i_calendario, calendario)
  )
}

f_inv <- function(institucion, ubicacion, calendario) {
  paste0(
    f_div(
      i_institucion, paste0("<b style='font-size:1.2em'>", institucion, "</b>")
    ),
    f_div(i_ubicacion, ubicacion),
    f_div(i_calendario, calendario)
  )
}

# educación ---------------------------------------------------------------

edu4 <- f_edu(
  titulo = "Doctorado en Geomática y Sistemas Espaciales",
  institucion = "Instituto Gulich",
  ubicacion = "Córdoba, Argentina",
  calendario = "En proceso"
)

edu3 <- f_edu(
  titulo = "Maestría en Aplicaciones de Imágenes Espaciales",
  institucion = "Instituto Gulich",
  ubicacion = "Córdoba, Argentina",
  calendario = "2023"
)

edu2 <- f_edu(
  titulo = "MS in Chemical and Biomolecular Engineering",
  institucion = "Sogang University",
  ubicacion = "Seoul, Corea del Sur",
  calendario = "2019"
)

edu1 <- f_edu(
  titulo = "Ingeniería Química",
  institucion = "Universidad Tecnológica Nacional Facultad Regional Resistencia",
  ubicacion = "Chaco, Argentina",
  calendario = "2014"
)

# investigación -----------------------------------------------------------

inv3 <- f_inv(
  institucion = "Grupo de Investigación Sobre Temas Ambientales y Químicos",
  ubicacion = "Chaco, Argentina",
  calendario = "Actualmente"
)

inv2 <- f_inv(
  institucion = "El Instituto de Detección Electromagnética del Medio Ambiente",
  ubicacion = "Milán, Italia",
  calendario = "2022"
)

inv1 <- f_inv(
  institucion = "Laboratorio de Catalizadores a Nanoescala e Ingeniería de Reacciones",
  ubicacion = "Seúl, Corea del Sur",
  calendario = "2019"
)

# colores -----------------------------------------------------------------

r <- readLines("mi_estilo.scss")

f_color <- function(color) {
  r[stringr::str_detect(r, paste0("c-", color, ":"))] |>
    stringr::str_extract("(\\#.+);", 1)
}

c_azul <- f_color("azul")
c_rojo <- f_color("rojo")
c_gold <- f_color("dorado")
