---
 title: "eds214_bisley"
format: html
editor: visual
---

  {r}
#importing anticipated libraries
library(janitor)
library(tidyr)
library(tidyverse)
library(paletteer)
library(dplyr)
library(zoo)

{r}
#Need to import the data from 3 separate csv files

bisley_1 <- read.csv(here::here("data", "QuebradaCuenca1-Bisley.csv"))
bisley_2 <- read.csv(here::here("data","QuebradaCuenca2-Bisley.csv"))
bisley_3 <- read.csv(here::here("data","QuebradaCuenca3-Bisley.csv"))



{r}

bisley_all <- bind_rows(
  bisley_1 |> mutate(sample_ID = "Q1"),
  bisley_2 |> mutate(sample_ID = "Q2"),
  bisley_3 |> mutate(sample_ID = "Q3")
) |>

  #bisley_all <- bind_rows(bisley_1,bisley_2, bisley_3)

  mutate(sample_date = as.Date(Sample_Date)) |>
  arrange(Sample_Date) |>
  mutate(across(
    c(K, NO3.N,Mg,Ca,NH4.N),
    ~ rollmean(., k = 9, fill =NA, align = "left"),
    .names = "{.col}_rollmean9"
  )) |>
  ungroup()

{r}
colnames(bisley_all)

{r}

bisley_long <- bisley_all |>
  select(Sample_ID, sample_date,
         ends_with("rollmean9")) |>
  pivot_longer(
    cols = ends_with("rollmean9"),
    names_to = "nutrient",
    values_to = "value"
  ) |>
  mutate(
    nutrient = recode(nutrient,
                      K_rollmean9 = "K",
                      NO3.N_rollmean9 = "NO3_N",
                      Mg_rollmean9 = "Mg",
                      Ca_rollmean9 = "Ca",
                      NH4.N_rollmean9 = "NH4.N"
    ),
    value = as.numeric(value)
  ) |>
  filter(!is.na(value))


{r}
#need to verify the columns
str(bisley_long)

bisley_long <- bisley_long %>%
  mutate(value = as.numeric(value))

bisley_long <- bisley_long %>%
  mutate(sample_date = as.Date(sample_date))

bisley_long <- bisley_long %>%
  filter(!is.na(value))



{r}
bisley_long

{r}
hurricane_date <- as.Date("1989-09-18")  # Date Hugo hit Puerto Rico

ggplot(bisley_long, aes(x = sample_date, y = value, color = Sample_ID)) +
  geom_line(linewidth = 0.7) +
  geom_vline(xintercept = as.numeric(hurricane_date),
             linetype = "dashed", color = "black") +
  facet_wrap(~ nutrient, scales = "free_y", ncol = 1) +
  labs(
    title = "Bisley Stream Nutrient Concentrations (9‑week Moving Averages)",
    subtitle = "Vertical line = Hurricane Hugo (1989‑09‑18)",
    x = "Date",
    y = "Concentration (mg/L)",
    color = "Sample_ID"
  ) +
  theme_bw() +
  theme(
    strip.background = element_rect(fill = "grey"),
    panel.grid.minor = element_blank()
  )

{r}
# Loading in the columns we need for the analysis
nutrients <- bisley |>
  select("Sample_Date",
         #"site",
         "K", #potassium_mgL,
         "NO3.N", #nitrate_N_mgL,
         "Mg", #magnesium_mgL,
         "Ca", #calcium_mgL,
         "NH4.N") #ammonium_N_mgL)

{r}
summary(bisley_all$sample_date)

