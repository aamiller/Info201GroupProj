library(plotly)

#prepare data for page 3
bechdel_data_raw <- read.csv("./bechdel_data/movies.csv", stringsAsFactors = FALSE)
source('./script/year.R')
year_data <- year(bechdel_data_raw)
source('./script/profitBechdelAssessment.R')

shinyUI(shinyUI(navbarPage("Bechdel Test",
                           tabPanel("ADELE", titlePanel('Adjust Rating (PG-13, etc.) Affect Passing Rates?')),
                           tabPanel("ADELE", titlePanel('Does Profit Affect Passing Rates?'),
                           sidebarLayout(
                             
                             # Side panel for controls
                             sidebarPanel(
                               
                               # Input to select variable to map
                               selectInput('scatterVarX', label = 'Variable to Map to X Axis', choices = list('Budget' = 'budget', 'Domestic Gross' = 'domgross', 'International Gross' = 'intgross')),
                               selectInput('scatterVarY', label = 'Variable to Map to Y Axis', choices = list('Budget' = 'budget', 'Domestic Gross' = 'domgross', 'International Gross' = 'intgross'))
                             ),
                             
                             # Main panel: display plotly map
                             mainPanel(
                               plotlyOutput('profitBechdelAssessment')
                             )
                           )
                           ),
                           tabPanel("SHERRI", titlePanel('Does Budget Affect Passing Rates?')),
                           
                           #tab page 3 by Anni
                           tabPanel("ANNI", titlePanel('Does Year Made Affect Passing Rates?')),
                                    
                                    #page 3 side bar lay out
                                    sidebarLayout(
                                      
                                      #page 3 side bar panel
                                      sidebarPanel(
                                        
                                        #page 3 check box widget
                                        sliderInput("slider1", label = h3("Slider"), min = year_data$year[44], 
                                                    max = year_data$year[1], value = year_data$year[44])
                                      ),
                                      
                                      #page 3 main panel
                                      mainPanel(
                                        
                                      )
                                    )
                                    )
                           #tabPanel("KEANAN", titlePanel('Does Genre Made Affect Passing Rates?')) 
                           
                           #YOU SHOULD MODIFY THIS FILE BY ADDING YOUR OUTPUT AFTER THE PAGE NAME LIKE THIS:
                           #tabPanel("Page 1", plotOutput("pg1")) <--I think.....? #
                           
))
