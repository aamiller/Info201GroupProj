library(shiny)
library(dplyr)

#setwd("~/Desktop/INFO201/Info201GroupProj")
movie.data <- read.csv("./bechdel_data/movies.csv", stringsAsFactors =  FALSE)
source("./script/profitBechdelAssessment.R")
source('./script/year.R')
#source("script/get_num_in_year.R") <--somehow this doesn't work...

shinyServer(function(input, output){

  output$profitBechdelAssessment <- renderPlotly({
    return(BuildScatter(movie.data, input$scatterVarX, input$scatterVarY))
  })
  
  output$linegraph <- renderPlotly ({
    modified_data <- year(movie.data)
    modified_data <- modified_data %>% 
      filter(year >= input$slider[1] & year <= input$slider[2])
    p <- plot_ly(x = modified_data$year, y = (modified_data$fail / modified_data$total), 
                 type = "scatter", mode = "lines", color = modified_data$fail, name = "fail") %>% 
      add_trace(x = modified_data$year, y = (modified_data$pass / modified_data$total), 
                type = "scatter", mode = "lines", color = modified_data$pass, name = "pass") %>% 
      layout(title = "passing rate from 1977 to 2013")
    return(p)
  })
  
  #YOUR SHOULD MODIFY THIS FILE BY ADDINT SOMETHING LIKE THIS???
  #output$pg1 <- renderPlot({ 
  #  return(YOUR.FUNCTION.NAME(movie.data, OTHER.PARAMETER))
  #})
  
  
})
