
sep <- "<b style='color:red;'>|</b>"
i_titulo <- "<span class='nf nf-fa-user_graduate nf-lista'></span>"
i_institucion <- "<span class='nf nf-fa-university nf-lista'></span>"
i_ubicacion <- "<span class='nf nf-fa-location_dot nf-lista'></span>"
i_calendario <- "<span class='nf nf-fa-calendar_days nf-lista'></span>"

f_edu <- function(titulo, institucion, ubicacion, calendario) {
  paste(
    i_titulo, titulo, "<br>",
    i_institucion, institucion, "<br>",
    i_ubicacion, ubicacion, "<br>",
    i_calendario, calendario, "<br>"
  )
}

f_inv <- function(institucion, ubicacion, calendario) {
  paste(
    i_institucion, institucion, "<br>",
    i_ubicacion, ubicacion, "<br>",
    i_calendario, calendario, "<br>"
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
