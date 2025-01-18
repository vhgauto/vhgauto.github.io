
sep <- "<b style='color:red;'>|</b>"
ubicacion <- "<span style='color:red'>{{< fa location-dot size=large >}}</span>"
calendario <- "<span style='color:red'>{{< fa calendar-days size=large >}}</span>"
titulo <- "<span style='color:red'>{{< fa user-graduate size=large >}}</span>"
institucion <- "<span style='color:red'>{{< fa building-columns size=large >}}</span>"

f_edu <- function(tit, ins, ubi, cal) {
  paste(
    titulo, tit, "<br>",
    institucion, ins, "<br>",
    ubicacion, ubi, "<br>",
    calendario, cal, "<br>"
  )
}



