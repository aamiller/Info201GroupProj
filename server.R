library(shiny)
library(dplyr)
setwd("~/Desktop/INFO201/Info201GroupProj")

shinyServer(function(input, output){
  movie.data <- read.csv("bechdel_data/movies.csv")
  source("script/find_movie.R")
  source("script/get_num_in_year.R")
  
})
