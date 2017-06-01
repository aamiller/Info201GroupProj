#loading required libraries
library(shiny)
library(dplyr)
library(scales)
library(ggplot2)
library(plotly)
library(knitr)

#loading required sources
source("./script/profitBechdelAssessment.R")
source("./script/genreAnalysisGraph.R")
source('./script/year.R')
source("./script/ratingBarGraph.R")
source("./script/country.graph.R")
source("./script/ActorData.R")

#making useful dataframes
movie.data <- read.csv("./bechdel_data/movies.csv", stringsAsFactors =  FALSE)
joined.movie.data <- read.csv("./bechdel_data/final_joined_bechdel_data.csv", stringsAsFactors = FALSE)

#making a server with input and output
shinyServer(function(input, output) {
  
  #returns a graph that shows adjust rating affect the passing rate
  output$contentRatingBechdelAssessment <- renderPlotly({
    return(BuildContentRatingBarGraph(joined.movie.data))
  })
  
  #returns a scatter plot of budget affect the passing rate
  output$profitBechdelAssessment <- renderPlotly({
    return(BuildScatter(movie.data, input$scatterVarX, input$scatterVarY))
  })
  
  #returns a line graph of years affect the passing rate
  output$linegraph <- renderPlotly ({
    modified_data <- year(movie.data)
    modified_data <- modified_data %>% 
      filter(year >= input$slider[1] & year <= input$slider[2]) %>% 
      mutate(pass_ratio = PASS / total)
    
    plot_ly(x = modified_data$year, y = (modified_data[, input$button] / modified_data$total), 
            type = "scatter", mode = "lines", color = modified_data$pass_ratio, 
            name = input$button) 
  })
  
  #returns a dot graph of test results and years
  output$testResults <- renderPlotly({
    group_test <- joined.movie.data %>% 
      filter(binary == input$button) %>% 
      filter(year >= input$slider[1] & year <= input$slider[2]) 
    g <- ggplot(group_test, aes(year, imdb_score)) +
      geom_point(aes(color = content_rating, size = budget.x), alpha = 0.5) +
      facet_grid(clean_test~.)
    ggplotly(g)
  })
  
  #returns a barplot of genre affect the passing rate
  output$GenreBechdelAssessmentBar <- renderPlotly({
    BuildGenreBarPlot(joined.movie.data)
  })
  
  #returns a plot??
  output$main_plot <- renderPlot({    
    plot(x, y)}, height = 200, width = 300)
  
  #returns a plot??
  output$popularity <- renderPlotly({
    return(ActorData(input$scatterX))
  })
  
  #returns a map of countries affect the passing rate
  output$countryGraph <- renderPlotly({
    return(countryGraph(joined.movie.data))
  })
  
  #return a table of a dataset
  output$movieInfo <- renderDataTable({
    movie_title <- joined.movie.data %>%
      select(title, imdb, year, clean_test, binary, genres,
             movie_imdb_link, imdb_score)
    return(movie_title)
  })
  
})
