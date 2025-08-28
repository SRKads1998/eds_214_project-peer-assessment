#Importing Libraries

#importing anticipated libraries that may be needed for the analysis and replication

#for cleaning names
library(janitor)
#for data manipulation
library(tidyverse)
library(paletteer)
library(dplyr)
library(lubridate)
source("scripts/") #clean function
source("scripts/plot_fig") #plotting function


#Need to import the data from 3 separate csv files and clean the names
bisley_1 <- read.csv(here::here("data", 'QuebradaCuenca1-Bisley.csv'), na = c("-99999", "")) |> janitor::clean_names()
bisley_2 <- read.csv(here::here("data","QuebradaCuenca2-Bisley.csv"), na = c("-99999", "")) |> janitor::clean_names()
bisley_3 <- read.csv(here::here("data","QuebradaCuenca3-Bisley.csv"), na = c("-99999", "")) |> janitor::clean_names()


#verified the data before working on it
colnames(bisley_1)


#binded the rows to create one data set
bisley_all <- bind_rows(bisley_1,bisley_2,bisley_3) %>% 
  #mutated the date column to date type. Before it was char
  mutate(sample_date = 
           as.Date(sample_date)) %>% 
  arrange(sample_id, sample_date)


#verifying the sample_date format
#We see that the data for some of the columns are string type. Will need  change this
str(bisley_all)


#Further cleaning
bisley_all <- bisley_all %>%
  #mutated the columns of the nutrients we want for our data set from character to numeric
  mutate(across(c(k, no3_n, mg, ca, nh4_n), ~ as.numeric(as.character(.))))


#Above there are some issues/warnings in the previous code line. Saying that there are NAs included. We must ensure all entries are numeric, so we need to: clean/replace characters to numeric, change/replace any special symbols, commas, spaces, empties

#Maybe make this a function
bisley_all <- bisley_all %>%
  mutate(across(
    c(k, no3_n, mg, ca, nh4_n),
    ~ .x |>
      as.character() |>  # ensure character
      str_replace_all(",", "") |>  #removed commas in numbers
      str_trim() |>  #remove stray spaces
      na_if("") |>                        
      as.numeric()  #turn empty string into NA
  ))




