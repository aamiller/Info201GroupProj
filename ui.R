library(dplyr)
library(ggplot2)
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
                           
                           #tab page 4 by Anni
                           tabPanel("Year Made (ANNI)", titlePanel('Does Year Made Affect Passing Rates?'),
                                    
                                    #page 4 side bar lay out
                                    sidebarLayout(
                                      
                                      #page 4 side bar panel
                                      sidebarPanel(
                                        
                                        #page 4 slider widget
                                        sliderInput("slider", label = h3("Slider"), min = year_data$year[44], 
                                                    max = year_data$year[1], value = c(year_data$year[40], year_data$year[30])),
                                        
                                        #page 4 radio button widget
                                        radioButtons("button", label = h3("radio buttons"), 
                                                           choices = list("pass" = "PASS", "fail" = "FAIL"),
                                                           selected = "PASS")
                                      ),
                                      
                                      #page 4 main panel
                                      mainPanel(
                                        plotlyOutput('linegraph'),
                                        textOutput("yearMadeText"),
                                        plotlyOutput('testResults')
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