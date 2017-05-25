library(shiny)
library(dplyr)

#setwd("~/Desktop/INFO201/Info201GroupProj")
movie.data <- read.csv("./bechdel_data/movies.csv", stringsAsFactors =  FALSE)
joined.movie.data <- read.csv("./bechdel_data/final_joined_bechdel_data.csv", stringsAsFactors = FALSE)
source("./script/profitBechdelAssessment.R")
source('./script/year.R')
source("./script/ratingBarGraph.R")
shinyServer(function(input, output) {

  output$profitBechdelAssessment <- renderPlotly({
    return(BuildScatter(movie.data, input$scatterVarX, input$scatterVarY))
  })
  
  output$contentRatingBechdelAssessment <- renderPlotly({
    return(BuildContentRatingBarGraph(joined.movie.data))
  })
  
  output$linegraph <- renderPlotly ({
    modified_data <- year(movie.data)
    modified_data <- modified_data %>% 
      filter(year >= input$slider[1] & year <= input$slider[2])
    
    p <- plot_ly(x = modified_data$year, y = (modified_data[, input$button] / modified_data$total), 
                 type = "scatter", mode = "lines", color = modified_data$total, name = input$button) %>% 
      # add_trace(x = modified_data$year, y = (modified_data$pass / modified_data$total), 
      #           type = "scatter", mode = "lines", color = modified_data$pass, name = "pass") %>% 
    layout(title = paste(input$button,"rate from 1970 to 2013"))
    
    return(p)
  })
  
  
  output$ratingText <- renderText({
    return("EDIT YOUR TEXT/CONCLUTION HERE FOR RATING PAGE")
  })
  
  output$profitText <- renderText({
    return("EDIT YOUR TEXT HERE FOR PROFIT PAGE")
  })
  
  output$budgetText <- renderText({
    return("EDIT YOUR TEXT/CONCLUTION HERE FOR BUDGE PAGE")
  })
  
  output$yearMadeText <- renderText({
    return("EDIT YOUR TEXT/CONCLUTION HERE FOR YEAR MADE PAGE")
  })
  
  output$countryText <- renderText({
    return("EDIT YOUR TEXT/CONCLUTION HERE FOR COUNTRY PAGE")
  })
  #YOUR SHOULD MODIFY THIS FILE BY ADDINT SOMETHING LIKE THIS???
  #output$pg1 <- renderPlot({ 
  #  return(YOUR.FUNCTION.NAME(movie.data, OTHER.PARAMETER))
  #})
  
})
