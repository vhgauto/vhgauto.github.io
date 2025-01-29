
# paquetes ----------------------------------------------------------------

library(glue)
library(ggiraph)
library(ggh4x)
library(tidyverse)

# datos -------------------------------------------------------------------

d <- read_tsv(
  file = "C:/Users/victo/OneDrive/R_recursos/viz/sudoku_tiempos/tiempos.txt"
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
    label = glue(
      "{minute(tiempo)}:{second(tiempo)}"
    )
  )

# barras ------------------------------------------------------------------

lista_y <- list(
  dificultad == "FÁCIL" ~ scale_y_time(
    labels = scales::label_time("%M:%S"),
    breaks = scales::breaks_width("1 min"),
    expand = c(0, 0)
    )
  )

g <- ggplot(
  d, aes(fecha, tiempo, fill = dificultad, shape = dificultad, color = dificultad)
) +
  geom_col_interactive(
    aes(tooltip = label, data_id = interaction(fecha)),
    linewidth = .1, hover_nearest = TRUE
  ) +
  facet_wrap(
    vars(dificultad), scales = "fixed", ncol = 1, axis.labels = "all_x",
    axes = "all_x"
  ) +
  # facetted_pos_scales(
    # y = lista_y
  # ) +
  scale_x_date(
    date_breaks = "1 week",
    date_labels = "%d/%b/%y",
    date_minor_breaks = "1 day",
    expand = c(0, .3)
  ) +
  scale_y_time(
    labels = scales::label_time("%Mm"),
    breaks = scales::breaks_width("10 min"),
    expand = expansion(mult = c(0, .05), add = c(0, 0))
  ) +
  scale_color_manual(
    breaks = c("FÁCIL", "MEDIO", "DIFÍCIL"),
    values = c("#DF8271", "#6FAFD1", "#F6B40E")
  ) +
  scale_fill_manual(
    breaks = c("FÁCIL", "MEDIO", "DIFÍCIL"),
    values = c("#DF8271", "#6FAFD1", "#F6B40E")
  ) +
  coord_cartesian(ylim = c(0, NA)) +
  labs(x = NULL, y = NULL, color = NULL, shape = NULL) +
  guides(
    color = guide_legend(override.aes = list(size = 2))
  ) +
  theme_classic(base_family = "Ubuntu") +
  theme(
    text = element_text(color = "white", size = 10),
    aspect.ratio = .1,
    plot.background = element_rect(fill = NA, color = NA),
    panel.background = element_blank(),
    panel.grid.major = element_line(
      color = "grey20", linetype = 1, linewidth = .2
    ),
    panel.grid.minor.x = element_line(
      color = "grey20", linetype = 1, linewidth = .2
    ),
    panel.spacing.y = unit(1, "line"),
    axis.ticks.y = element_blank(),
    axis.ticks.length.x = unit(-3, "pt"),
    axis.text = element_text(color = "white"),
    axis.text.y = element_text(family = "JetBrains Mono", vjust = 0),
    axis.line = element_blank(),
    legend.position = "none",
    strip.background = element_blank(),
    strip.clip = "off",
    strip.text = element_text(
      hjust = 0, margin = margin(l = 0, b = 2), face = "bold", color = "white"
    )
  ); h <- girafe(
  ggobj = g,
  bg = "transparent",
  options = list(
    opts_hover(css = girafe_css(
      css = glue("")
    )),
    opts_tooltip(
      opacity = 1,
      css = glue(
        "background-color:#181818;padding:2px;border: 1px solid;",
        "font-family:JetBrains Mono;font-size:10pt;"),
      use_cursor_pos = TRUE,
      use_stroke = TRUE,
      offx = 20,
      offy = 20),
    opts_sizing(width = 1, rescale = TRUE),
    opts_toolbar = opts_toolbar(saveaspng = FALSE),
    opts_hover_inv(css = "opacity:0.3;")
  )
)
