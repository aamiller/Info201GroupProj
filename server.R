library(shiny)
library(dplyr)
library(scales)
library(ggplot2)
library(plotly)

#setwd("~/Desktop/INFO201/Info201GroupProj")
movie.data <- read.csv("./bechdel_data/movies.csv", stringsAsFactors =  FALSE)
joined.movie.data <- read.csv("./bechdel_data/final_joined_bechdel_data.csv", stringsAsFactors = FALSE)
source("./script/profitBechdelAssessment.R")
source("./script/genreAnalysisGraph.R")
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
      filter(year >= input$slider[1] & year <= input$slider[2]) %>% 
      mutate(pass_ratio = PASS / total)
  
    plot_ly(x = modified_data$year, y = (modified_data[, input$button] / modified_data$total), 
                 type = "scatter", mode = "lines", color = modified_data$pass_ratio, 
                 name = input$button) %>% 
         layout(title = paste(input$button,"rate from 1970 to 2013"))
  })
  
  output$testResults <- renderPlotly({
    group_test <- joined.movie.data %>% 
      filter(binary == input$button) %>% 
      filter(year >= input$slider[1] & year <= input$slider[2]) 
    g <- ggplot(group_test, aes(year, imdb_score)) +
      geom_point(aes(color = content_rating, size = budget.x), alpha = 0.5) +
      facet_grid(clean_test~.)
    ggplotly(g)
  })
  
  output$GenreBechdelAssessmentBar <- renderPlotly({
    BuildGenreBarPlot(joined.movie.data)
  })
  
  output$main_plot <- renderPlot({    
    plot(x, y)}, height = 200, width = 300)

  
  output$budgetText <- renderText({
    return("EDIT YOUR TEXT/CONCLUTION HERE FOR BUDGE PAGE")
  })
  
  output$countryText <- renderText({
    return("EDIT YOUR TEXT/CONCLUTION HERE FOR COUNTRY PAGE")
  })
  #YOUR SHOULD MODIFY THIS FILE BY ADDINT SOMETHING LIKE THIS???
  #output$pg1 <- renderPlot({ 
  #  return(YOUR.FUNCTION.NAME(movie.data, OTHER.PARAMETER))
  #})
  
})
