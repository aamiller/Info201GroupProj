library(shiny)
library(dplyr)
#setwd("~/Desktop/INFO201/Info201GroupProj")
movie.data <- read.csv("./bechdel_data/movies.csv")
source("script/find_movie.R")
#source("script/get_num_in_year.R") <--somehow this doesn't work...

shinyServer(function(input, output){

  output$profitBechdelAssessment <- renderPlot({
    return(movie.data)
  })
  
  
  
  #YOUR SHOULD MODIFY THIS FILE BY ADDINT SOMETHING LIKE THIS???
  #output$pg1 <- renderPlot({ 
  #  return(YOUR.FUNCTION.NAME(movie.data, OTHER.PARAMETER))
  #})
  
  
})
