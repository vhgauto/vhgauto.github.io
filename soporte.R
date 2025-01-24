
sep <- "<b style='color:red;'>|</b>"
i_titulo <- "<span class='nf nf-fa-user_graduate nf-lista'></span>"
i_institucion <- "<span class='nf nf-fa-university nf-lista'></span>"
i_ubicacion <- "<span class='nf nf-fa-location_dot nf-lista'></span>"
i_calendario <- "<span class='nf nf-fa-calendar_days nf-lista'></span>"

f_tabla <- function(titulo, institucion, ubicacion, calendario) {
  paste(
    i_titulo, titulo, "<br>",
    i_institucion, institucion, "<br>",
    i_ubicacion, ubicacion, "<br>",
    i_calendario, calendario, "<br>"
  )
}

cv4 <- f_tabla(
  titulo = "Doctorado en Geomática y Sistemas Espaciales",
  institucion = "Instituto Gulich",
  ubicacion = "Córdoba, Argentina",
  calendario = "En proceso"
)

cv3 <- f_tabla(
  titulo = "Maestría en Aplicaciones de Imágenes Espaciales",
  institucion = "Instituto Gulich",
  ubicacion = "Córdoba, Argentina",
  calendario = "2023"
)

cv2 <- f_tabla(
  titulo = "MS in Chemical and Biomolecular Engineering",
  institucion = "Sogang University",
  ubicacion = "Seoul, Corea del Sur",
  calendario = "2019"
)

cv1 <- f_tabla(
  titulo = "Ingeniería Química",
  institucion = "Universidad Tecnológica Nacional Facultad Regional Resistencia",
  ubicacion = "Chaco, Argentina",
  calendario = "2014"
)
