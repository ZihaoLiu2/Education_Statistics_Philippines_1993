#### Preamble ####
# Purpose: Simulate the data from NDS of Philippines in 1993
#Author: Zihao Liu
#Date: 1 April 2022
#Contact: zihaohans.liu@mail.utoronto.ca

library(tidyverse)
##Simulate data##
set.seed(588)

#Simulate dataset of education level by age
simulated_data_by_age<- tibble(
  age = c("6-9","10-14","15-19","20-24","25-29","30-34","35-39","40-44","45-49","50-54","55-59","60-64","65+"),
  total =  rep(100, 13),
  number = rnorm(n=13, mean =2500, sd = 250),
  median_years = rnorm(n=13, mean =5, sd =1.5)
)

#Simulate dataset of education level by residence
simulated_data_by_residence<- tibble(
  residence = c("Urban","Rural"),
  total = rep(100,2),
  number = rnorm(n=2, mean=15000, sd = 100),
  median_years = rnorm(n=2, mean=5, sd =1.5)
)

#Simulate dataset of education level by region
simulated_data_by_region <- tibble(
  region = c("MetroManila","CordilleraAdmin","Tlocos","CagayanValley","C-Luzon",
             "S-Tagalog", "Bicol","W-Visayas","C-Visayas","E-Visayas",
             "W-Mindanao","N-Mindanao","S-Mindanao","C-Mindanao"),
  total = rep(100,14),
  number = rnorm(n=14,mean=2000,sd=500),
  median_years =rnorm(n=14, mean=5, sd =1.5)
  
)

