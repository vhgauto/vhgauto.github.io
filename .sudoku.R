
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

d <- read_tsv(
  file = "datos/tiempos.txt",
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
    dificultad = factor(dificultad, levels = c(
      "FÁCIL", "MEDIO", "DIFÍCIL"
    ))
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
    tiempo_label = paste0(minutos, "m", segundos, "s")
  )

# líneas ------------------------------------------------------------------

d_label <- d |>
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

# htmltools::html_print(htmltools::HTML(d_label$l[1]))

d2 <- inner_join(
  d, d_label,
  by = join_by(fecha)
)

eje_x <- d2 |>
  distinct(fecha) |>
  mutate(
    dia_chr = str_sub(toupper(weekdays(fecha)), 1, 1)
  ) |>
  mutate(
    dia_dbl = if_else(
      day(fecha) == 1 | day(fecha) %% 5 == 0,
      day(fecha),
      NA
    )
  ) |>
  mutate(
    dia_dbl = if_else(
      dia_dbl < 10,
      paste0("0", dia_dbl),
      paste0(dia_dbl)
    )
  ) |>
  mutate(
    mes = if_else(
      dia_dbl == "01",
      toupper(month(fecha, abbr = TRUE, label = TRUE)),
      NA
    )
  ) |>
  pivot_longer(
    cols = -fecha,
    names_to = "periodo",
    values_to = "valor",
    values_drop_na = TRUE
  ) |>
  reframe(
    l = str_flatten(valor, "\n"),
    .by = fecha
  ) |>
  pull(l)

g <- ggplot(
  d2, aes(
    fecha, tiempo, fill = dificultad, shape = dificultad, color = dificultad,
    group = dificultad
  )
) +
  geom_line_interactive(
    aes(data_id = interaction(fecha)), linewidth = .4, hover_nearest = TRUE
  ) +
  geom_point_interactive(
    aes(tooltip = l, data_id = interaction(fecha)), shape = 21, stroke = .6,
    color = c4, hover_nearest = TRUE
  ) +
  scale_x_date(
    breaks = unique(d2$fecha),
    labels = eje_x,
    expand = c(0, .3)
  ) +
  scale_y_time(
    labels = scales::label_time("%Mm"),
    breaks = scales::breaks_width("10 min"),
    expand = expansion(mult = c(0, .05), add = c(0, 0))
  ) +
  scale_color_manual(
    breaks = c("FÁCIL", "MEDIO", "DIFÍCIL"),
    values = colores
  ) +
  scale_fill_manual(
    breaks = c("FÁCIL", "MEDIO", "DIFÍCIL"),
    values = colores
  ) +
  coord_cartesian(ylim = c(0, NA)) +
  labs(x = NULL, y = NULL, color = NULL, shape = NULL) +
  guides(
    color = guide_legend(override.aes = list(size = 2))
  ) +
  theme_classic(base_family = "Ubuntu") +
  theme(
    text = element_text(color = c2, size = 10),
    plot.background = element_rect(fill = NA, color = NA),
    panel.background = element_blank(),
    panel.grid.major = element_line(
      color = c3, linetype = 1, linewidth = .1
    ),
    panel.spacing.y = unit(1, "line"),
    axis.ticks = element_blank(),
    axis.text = element_text(color = c2, family = "JetBrains Mono"),
    axis.text.y = element_text(vjust = 0),
    axis.line = element_blank(),
    legend.position = "none",
    strip.background = element_blank(),
    strip.clip = "off",
    strip.text = element_text(
      hjust = 0, margin = margin(l = 0, b = 2), face = "bold", color = c1
    )
  )

h <- girafe(
  ggobj = g,
  width_svg = 6,
  height_svg = 2,
  bg = "transparent",
  options = list(
    opts_hover(css = girafe_css(
      css = glue("")
    )),
    opts_tooltip(
      opacity = 1,
      css = glue(
        "background-color:transparent;padding:2px;border: none;
        font-family:JetBrains Mono;font-size:11pt;color:white"
      ),
      use_cursor_pos = FALSE,
      offx = 50,
      offy = -20),
    opts_sizing(width = 1, rescale = TRUE),
    opts_toolbar = opts_toolbar(saveaspng = FALSE),
    opts_hover_inv(css = "opacity:0.3;")
  )
)
