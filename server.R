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
source("./script/country.graph.R")
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
     return("The graph above shows the ratio of number of films that PASSED the test to the number of  
            TOTAL number of films produced in the country. Solid blue countries indicates a 100% passage
            rate. Solid red countries indicate a 0% passage rate. Most of the countries with these 
            extreme passage rates have very few data points, for example: Mexico has a 0% passage rate
            but this rate is based on only one film that was produced in the country. Some countries have
            had very few movies represented in the Bechdel data, therefore some of the country ratios
            do not have enough data for them to be entirely accurate. For example: many countries (Russia,
            India, Thailand, Israel, Brazil, Peru, Mexico, Norway, Finland, Columbia, Taiwan, Cameroon,
            the Czech Republic, Italy, the Netherlands, South Africa, and South Korea) have fewer than
            5 movies that have been evaluated by the Bechdel test. We still found value in showing the data
            by country which helps us see general trends in countries around the world.
            We noticed that more countries considered to be more progressive (based on the social
            progress index of 2016) like Germany and Canada did much better than less progressive countries
            such as China. While there isn't enough data here to evaluate performance based on social progress, 
            a future question to investigate is how the overwhelming political ideologies in these countries 
            affect the likehood of having two women talk to each other.")
  })
  
  output$countryGraph <- renderPlotly({
    return(countryGraph(joined.movie.data))
  })
  
  #YOUR SHOULD MODIFY THIS FILE BY ADDINT SOMETHING LIKE THIS???
  #output$pg1 <- renderPlot({ 
  #  return(YOUR.FUNCTION.NAME(movie.data, OTHER.PARAMETER))
  #})
  
})
