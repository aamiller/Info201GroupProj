
library(plotly)
library(Hmisc)

#prepare data for page 3

#this is the data from fivethirtyeight
bechdel_data_raw <- read.csv("./bechdel_data/movies.csv", stringsAsFactors = FALSE)

#trying to get yearly data using year function
source('./script/year.R')
year_data <- year(bechdel_data_raw)

#this is the final dataset 
new_data <- read.csv('./bechdel_data/final_joined_bechdel_data.csv')

#profitBechdelAssessment.R
source('./script/profitBechdelAssessment.R')

shinyUI(shinyUI(navbarPage("What Affects Passing Bechdel Test?",
                           tabPanel("Rating (ADELE)", titlePanel('Adjust Rating (PG-13, etc.) Affect Passing Rates?'),
                                    mainPanel(
                                      textOutput("ratingText"),
                                      plotlyOutput('contentRatingBechdelAssessment')
                                    )
                           ),
                           tabPanel("Profit (ADELE)", titlePanel('Does Profit or Budget Affect Passing Rates?'),
                                    sidebarLayout(
                                      
                                      # Side panel for controls
                                      sidebarPanel(
                                        
                                        # Input to select variable to map
                                        selectInput('scatterVarX', label = 'Variable to Map to X Axis', choices = list('Budget' = 'budget', 'Domestic Gross' = 'domgross', 'International Gross' = 'intgross')),
                                        selectInput('scatterVarY', label = 'Variable to Map to Y Axis', choices = list('Budget' = 'budget', 'Domestic Gross' = 'domgross', 'International Gross' = 'intgross'))
                                      ),
                                      
                                      # Main panel: display plotly map
                                      mainPanel(
                                        plotlyOutput('profitBechdelAssessment'),
                                        textOutput('profitText'))
                                    )
                           ),
                           tabPanel("Budget (SHERRI)", 
                                    titlePanel('Does Budget Affect Passing Rates?'),
                                    #sidebarPanel(add your plot here),
                                    mainPanel(
                                      #plotlyOutput("YOUR PLOT NAME),
                                      textOutput("budgetText")
                                    )
                           ),
                           
                           #tab page 3 by Anni
                           tabPanel("Year Made (ANNI)", titlePanel('Does Year Made Affect Passing Rates?'),
                                    
                                    #page 3 side bar lay out
                                    sidebarLayout(
                                      
                                      #page 3 side bar panel
                                      sidebarPanel(
                                        
                                        #page 3 check box widget
                                        sliderInput("slider", label = h3("Slider"), min = year_data$year[44], 
                                                    max = year_data$year[1], value = c(year_data$year[40], year_data$year[30]))
                                      ),
                                      
                                      #page 3 main panel
                                      mainPanel(
                                        plotlyOutput('linegraph'),
                                        textOutput("yearMadeText")
                                      )
                                    )
                           ),
                           
                           tabPanel("Country (KEANAN)", 
                                    titlePanel('Does Country Made Affect Passing Rates?'),
                                    mainPanel(
                                      textOutput("countryText")
                                    )
                           ) 
                           
                           #YOU SHOULD MODIFY THIS FILE BY ADDING YOUR OUTPUT AFTER THE PAGE NAME LIKE THIS:
                           #tabPanel("Page 1", plotOutput("pg1")) <--I think.....? #
)                           
))