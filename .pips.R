# paquetes ----------------------------------------------------------------

library(glue)
library(ggiraph)
library(tidyverse)

# estilos -----------------------------------------------------------------

c1 <- "white"
c2 <- "grey60"
c3 <- "grey20"
c4 <- "#181818"

colores <- c(
  FÁCIL = c_azul,
  MEDIO = c_rojo,
  DIFÍCIL = c_gold
)

# datos -------------------------------------------------------------------

d_pips <- read_tsv(
  file = "datos/pips.tsv",
  col_types = "cccc"
) |>
  mutate(fecha = dmy(fecha)) |>
  mutate(
    across(
      .cols = -fecha,
      .fns = ms
    )
  ) |>
  pivot_longer(
    cols = -fecha,
    values_to = "tiempo",
    names_to = "dificultad"
  ) |>
  drop_na() |>
  mutate(
    dificultad = toupper(dificultad)
  ) |>
  mutate(
    dificultad = factor(
      dificultad,
      levels = c(
        "FÁCIL",
        "MEDIO",
        "DIFÍCIL"
      )
    )
  ) |>
  mutate(
    minutos = minute(tiempo),
    segundos = second(tiempo)
  ) |>
  mutate(
    across(
      .cols = minutos:segundos,
      .fns = \(.x) if_else(.x < 10, paste0("0", .x), paste0(.x))
    )
  ) |>
  mutate(
    tiempo_label = if_else(
      minutos == "00",
      paste0(segundos, "s"),
      paste0(minutos, "m", segundos, "s")
    )
  )

# líneas ------------------------------------------------------------------

d_label_pips <- d_pips |>
  mutate(
    color = colores[dificultad]
  ) |>
  reframe(
    l = str_flatten(
      glue(
        "<span style='color: {color}'> {dificultad} {tiempo_label} </span> | "
      )
    ),
    .by = fecha
  ) |>
  mutate(
    fecha_label = toupper(format(fecha, "%d/%b/%Y"))
  ) |>
  mutate(
    l = paste0(fecha_label, ": ", l)
  ) |>
  mutate(
    l = str_remove(l, " \\| $")
  )

d2_pips <- inner_join(
  d_pips,
  d_label_pips,
  by = join_by(fecha)
) |>
  mutate(
    color = colores[dificultad]
  ) |>
  mutate(
    dificultad_label = glue("<b style='color: {color};'>{dificultad}</b>")
  ) |>
  mutate(dificultad_label = fct_reorder(dificultad_label, as.numeric(tiempo)))

g_pips <- ggplot(
  d2_pips,
  aes(as.numeric(tiempo), dificultad_label, fill = dificultad)
) +
  geom_point_interactive(
    aes(tooltip = l, data_id = interaction(fecha)),
    position = position_jitter(seed = 2025, height = .2),
    shape = 21,
    stroke = .6,
    color = c4,
    hover_nearest = TRUE,
    show.legend = FALSE
  ) +
  labs(x = NULL, y = NULL, color = NULL, shape = NULL) +
  scale_fill_manual(
    values = colores
  ) +
  scale_x_continuous(
    breaks = scales::breaks_width(60),
    labels = \(x) paste0(x / 60, "m")
  ) +
  theme_classic(base_family = "Ubuntu") +
  theme(
    text = element_text(color = c2, size = 10),
    plot.background = element_rect(fill = NA, color = NA),
    panel.background = element_blank(),
    panel.grid.major = element_line(
      color = c3,
      linetype = 1,
      linewidth = .1
    ),
    panel.spacing.y = unit(1, "line"),
    axis.ticks = element_blank(),
    axis.text = element_text(color = c2, family = "JetBrains Mono"),
    axis.text.y = ggtext::element_markdown(vjust = 0),
    axis.line = element_blank(),
    legend.position = "none",
    strip.background = element_blank(),
    strip.clip = "off",
    strip.text = element_text(
      hjust = 0,
      margin = margin(l = 0, b = 2),
      face = "bold",
      color = c1
    )
  )

h_pips <- girafe(
  ggobj = g_pips,
  width_svg = 7,
  height_svg = 3,
  bg = "transparent",
  options = list(
    opts_hover(
      css = girafe_css(
        css = glue(""),
        point = "r: 3;"
      )
    ),
    opts_tooltip(
      opacity = 1,
      css = glue(
        "background-color:transparent;padding:2px;border: none;
        font-family:JetBrains Mono;font-size:11pt;color:white"
      ),
      use_cursor_pos = FALSE,
      offx = 50,
      offy = -20
    ),
    opts_sizing(width = 1, rescale = TRUE),
    opts_toolbar = opts_toolbar(saveaspng = FALSE),
    opts_hover_inv(css = "opacity:0.2;")
  )
)

# resumen ----------------------------------------------------------------

horas_pips <- d_pips |>
  mutate(
    duracion = as.duration(tiempo)
  ) |>
  reframe(
    s = sum(duracion) / 60 / 60
  ) |>
  pull() |>
  round()

juegos_pips <- d_pips |>
  distinct(fecha, dificultad) |>
  nrow()
