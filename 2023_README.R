
# paquetes ----------------------------------------------------------------

library(tidyverse)

l <- "https://raw.githubusercontent.com/vhgauto/tidytuesday/refs/heads/main/2023/README.md"

l_tbl <- readLines(l) |>
  tibble(tex = _) |>
  mutate(fila = row_number())

filas <- l_tbl |>
  mutate(semana = str_detect(tex, "##")) |>
  filter(semana) |>
  pull(fila)

desc <- l_tbl |>
  filter(fila %in% c(filas+2)) |>
  pull(tex)

desc_tbl <- l_tbl |>
  filter(str_detect(tex, "##")) |>
  mutate(desc = desc) |>
  rename(semana = tex) |>
  mutate(semana = str_remove(semana, "## ")) |>
  select(-fila) |>
  arrange(semana) |>
  mutate(
    semana = if_else(semana == "Semana 7", "Semana 07", semana)
  ) |>
  arrange(semana)

