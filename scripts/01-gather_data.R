#### Preamble ####
# Purpose: Gather the data from NDS of Philippines in 1993
#Author: Zihao Liu
#Date: 1 April 2022
#Contact: zihaohans.liu@mail.utoronto.ca

#Load package for OCR, which transfer image to text 
library(tesseract)

#load the packages for transfering text into datasets
library(janitor)
library(purrr)
library(tidyverse)
library(stringi)

#transfer the table from the selected DHS report into text
text <- tesseract::ocr(("https://github.com/ZihaoLiu2/Education_Statistics_Philippines_1993/raw/main/inputs/table%20_NDS_1993.png"), engine = tesseract("eng"))
cat(text)
#Split text into rows 
text_1 <-text%>%stri_split_lines(text)

#select the text for education info by age
text_2<- text_1[[1]][8:20]

#transfering the text into a dataset
data_by_age <- tibble(all = text_2)
data_by_age <- data_by_age%>%
  separate(col = all,
           into = c("age","no_education","elementary_school","high_school","college_or_higher","dont_know_missing","total","number","median_years"),
           sep = " ",
           remove = TRUE,
           fill = "right",
           extra = "drop"
  )
#save the data 
write_csv(data_by_age, "inputs/raw_data_by_age.csv")

#select the text for education info by residence
text_3<-text_1[[1]][22:23]

#transfering the text into a dataset
data_by_residence <- tibble(all = text_3)
data_by_residence <- data_by_residence%>%
  separate(col = all,
           into = c("residence","no_education","elementary_school","high_school","college_or_higher","dont_know_missing","total","number","median_years"),
           sep = " ",
           remove = TRUE,
           fill = "right",
           extra = "drop"
  )
#save the data 
write_csv(data_by_residence, "inputs/raw_data_by_residence.csv")

#select the text for education info by Region
text_4<-text_1[[1]][25:39]

#transfering the text into a dataset
data_by_region<- tibble(all = text_4)
data_by_region <- data_by_region%>%
  mutate(all = str_replace(all, "Metro, Manila", "MetroManila"))%>%
  mutate(all = str_replace(all, "Cordillera Admin.", "CordilleraAdmin"))%>%
  mutate(all = str_replace(all, "Cagayan Valley", "CagayanValley"))%>%
  separate(col = all,
           into = c("region","no_education","elementary_school","high_school","college_or_higher","dont_know_missing","total","number","median_years"),
           sep = " ",
           remove = TRUE,
           fill = "right",
           extra = "drop"
  )
#save the data 
write_csv(data_by_region, "inputs/raw_data_by_region.csv")
