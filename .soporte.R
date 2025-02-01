
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

# f_edu <- function(titulo, institucion, ubicacion, calendario) {
#   paste(
#     i_titulo, "<b style='font-size:1.2em'>", titulo, "</b>", "<br>",
#     i_institucion, institucion, "<br>",
#     i_ubicacion, ubicacion, "<br>",
#     i_calendario, calendario, "<br>"
#   )
# }

# f_inv <- function(institucion, ubicacion, calendario) {
#   paste(
#     i_institucion, "<b style='font-size:1.2em'>", institucion, "</b>", "<br>",
#     i_ubicacion, ubicacion, "<br>",
#     i_calendario, calendario, "<br>"
#   )
# }

ff <- function(i, x) {
  glue::glue(
    "\n
    :::: {{.grid style='--bs-columns: 12; --bs-gap: 0rem'}}
    ::: {{.g-col-1 style='text-align: right;'}}
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
    ff(i_titulo, paste0("<b style='font-size:1.2em'>", titulo, "</b>")),
    ff(i_institucion, institucion),
    ff(i_ubicacion, ubicacion),
    ff(i_calendario, calendario)
  )
}

f_inv <- function(institucion, ubicacion, calendario) {
  paste0(
    ff(i_institucion, paste0("<b style='font-size:1.2em'>", institucion, "</b>")),
    ff(i_ubicacion, ubicacion),
    ff(i_calendario, calendario)
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
