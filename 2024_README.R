
# paquetes ----------------------------------------------------------------

library(tidyverse)

readme <- "https://raw.githubusercontent.com/vhgauto/tidytuesday/refs/heads/main/2024/README.md"

l_tbl <- readLines(readme) |>
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
  mutate(semana = str_remove(semana, "## Semana")) |>
  mutate(semana = str_trim(semana)) |>
  select(-fila) |>
  arrange(semana) |>
  slice(-1) |>
  mutate(
    semana = if_else(nchar(semana) == 1, paste0("0", semana), semana)
  ) |>
  arrange(semana)

