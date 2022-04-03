#### Preamble ####
# Purpose: Prepare and clean the data from NDS of Philippines in 1993
#Author: Zihao Liu
#Date: 2 April 2022
#Contact: zihaohans.liu@mail.utoronto.ca


library(tidyverse)
library(pointblank)

#load in the raw data

raw_age<-read_csv("inputs/raw_data_by_age.csv")
raw_res <- read_csv("inputs/raw_data_by_residence.csv")
raw_region <- read_csv("inputs/raw_data_by_region.csv")

#correct some of the information that are misclassified in the process of OCR
raw_age$dont_know_missing[5] = 0
#Some of the columns were character, so convert them to numeric. 
raw_age$dont_know_missing<-as.numeric(raw_age$dont_know_missing)
raw_age$no_education[c(5,6,7,8)] = c(1.9,2.3,2.3,2.3)
raw_age$elementary_school[c(4,7)] = c(27.7,41.7)
raw_age$high_school[c(4,12)]= c(41.1,21.1)
raw_age$median_years[c(9,11,13)] = c(6.8,6.5,4.9)

raw_res$no_education[2]=9.7

raw_region$no_education[5] = 4.6
raw_region$no_education[15] = 7.8
raw_region$elementary_school[4] = 53.1
raw_region$elementary_school <-as.numeric(raw_region$elementary_school)
raw_region$high_school[9] =22.8
raw_region$college_or_higher[13] = 11.5
raw_region$college_or_higher<-as.numeric(raw_region$college_or_higher)

raw_region$dont_know_missing[c(2,3,4,7,8,9,11,14,15)] = c(0.2,0.2,1.1,0.7,0.0,1.2,2.1,0.4,0.5)
raw_region$total[1] =100
raw_region$median_years[c(2,5,7)] = c(6.9,6.9,6.3)
raw_region$dont_know_missing<-as.numeric(raw_region$dont_know_missing)
#tests for the datasets
#test for raw_age
agent1 <-
  create_agent(tbl = raw_age) %>%
  col_is_character(columns = age)%>%
  col_is_numeric(columns = c(2:9))%>%
  col_vals_in_set(columns = age,
                  set = c("6-9","10-14","15-19","20-24","25-29","30-34","35-39","40-44","45-49","50-54","55-59","60-64","65+"))%>%
  col_vals_between(columns = c(2:7),0,100)%>%
  col_vals_between(columns = c(8),0,5000)%>%
  col_vals_between(columns = c(9),0,12)%>%
  interrogate()

agent1 

#test for raw_res
agent2 <-
  create_agent(tbl = raw_res) %>%
  col_is_character(columns = residence)%>%
  col_is_numeric(columns = c(2:9))%>%
  col_vals_in_set(columns = residence,
                  set = c("Urban","Rural"))%>%
  col_vals_between(columns = c(2:7),0,100)%>%
  col_vals_between(columns = c(8),0,15000)%>%
  col_vals_between(columns = c(9),0,12)%>%
  interrogate()
agent2

#test for raw_region
agent3 <-
  create_agent(tbl = raw_region) %>%
  col_is_character(columns = region)%>%
  col_is_numeric(columns = c(2:9))%>%
  col_vals_in_set(columns = region,
                  set = c("MetroManila","CordilleraAdmin","Tlocos","CagayanValley","C-Luzon",
                          "S-Tagalog", "Bicol","W-Visayas","C-Visayas","E-Visayas",
                          "W-Mindanao","N-Mindanao","S-Mindanao","C-Mindanao","Total"))%>%
  col_vals_between(columns = c(2:7),0,100)%>%
  col_vals_between(columns = c(8),0,30000)%>%
  col_vals_between(columns = c(9),0,12)%>%
  interrogate()
agent3

#save the cleande datasets
write_csv(raw_age, "inputs/cleaned_data_by_age.csv")
write_csv(raw_res, "inputs/cleaned_data_by_residence.csv")
write_csv(raw_region, "inputs/cleaned_data_by_region.csv")

