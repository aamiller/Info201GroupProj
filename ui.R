library(plotly)

#prepare data for page 3
bechdel_data_raw <- read.csv("./bechdel_data/movies.csv", stringsAsFactors = FALSE)
source('./script/year.R')
year_data <- year(bechdel_data_raw)

shinyUI(shinyUI(navbarPage("Bechdel Test",
                           tabPanel("Page 1"),
                           tabPanel("Page 2"),
                           
                           #tab page 3 by Anni
                           tabPanel("Page 3", 
                                    
                                    #page 3 side bar lay out
                                    sidebarLayout(
                                      
                                      #page 3 side bar panel
                                      sidebarPanel(
                                        
                                        #page 3 check box widget
                                        checkboxGroupInput("year", label = h3("Year to display"), 
                                                           choices = year_data$year,
                                                           selected = year_data$year[1])
                                      ),
                                      
                                      #page 3 main panel
                                      mainPanel(
                                        
                                      )
                                    )
                                    ),
                           tabPanel("page 4")
                           
                           #YOU SHOULD MODIFY THIS FILE BY ADDING YOUR OUTPUT AFTER THE PAGE NAME LIKE THIS:
                           #tabPanel("Page 1", plotOutput("pg1")) <--I think.....? 
                           
)))
