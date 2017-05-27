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

shinyUI(shinyUI(fluidPage(theme = "style.css",
                      headerPanel(
                        tags$h1("What Affects Passing Bechdel Test?")
                      ),
                      
                      tabsetPanel(
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
                        tabPanel("Year Made (ANNI)", 
                                 tags$h3("Does Year Made Affect Passing Rates?"),
                                 tags$p("The movie genre has changed dramatically for the past 50 years."),
                                 sidebarLayout(
                                   mainPanel(
                                     tags$ul(
                                       tags$li("1970s is a 'creative high point' in the movie industry. Films were
                                               influenced by the hippie movement, free love and civil rights movement,
                                               the language and adult content of the movies changed. These movies used 
                                               new technologies and opened up to political and social issues.Major productions:",
                                               em("The Godfather(1972), Jaws(1975), Close Encounters of the Third Kind(1977).")),
                                       tags$li("Like the 1970s, the 1980s produced a lot of disaster movies, buddy
                                               movies and 'rouge cop' movies.Major productions includes", 
                                               em("Star Wars: The Empire Strikes Back(1980), Ghostbusters(1984), E.T.(1982), 
                                                  Back to the Future(1985).")),
                                       tags$li("In the 1990s, movie productions started to spend a ton of movie on special effects.
                                               Many films costed over $100 million and also led to many high-pay movie stars like 
                                               Arnold Schwarzenegger, Tom Cruise Sylvester Stallone, Mel Gibson, Jim Carrey.However,
                                               low budget independent movies also won their populaity. Major productions:", 
                                               em("Ghost(1990), The Lion King(1994), Independent Day(1996), Pulp Fiction(1995), Titantic(1997).")
                                               ),
                                       tags$li("2000s was strongly influenced by the high technology. ", em("Google, MySpace, Amazon "),
                                               "and many other major websites and social medias took over the internet. The films in this
                                               decade was also influenced by ", em("911 attacks, Asian tsunami and Hurricans."), "Major
                                               productions: ", em("Avatar(2009), Pirates of the Caribbean: The Curse of the Black Pearl (2003),
                                                                  Harry Potter and the Sorcerer's Stone (2001), The Lord of the Rings: The Fellowship of the Ring (2001)")),
                                       tags$li("Entering the 2010s, movie genres had even wider range. However, as the public greater 
                                               aknowledging gender-equality, more and more movies gave the lead role to female charaters.
                                               Major productions: ", em("Inception(2010), moonlight(2016), Marvel Movies, Disney Movies."))
                                       )
                                   ),
                                   sidebarPanel(
                                     tags$img(src = "godfather.jpg", height = 100, width = 70),
                                     tags$img(src = "jaws.jpg", height = 120, width = 80),
                                     tags$img(src = "close.jpg", height = 112, width = 77),
                                     tags$img(src = "avatar.jpg", height = 105, width = 70),
                                     tags$img(src = "buster.png", height = 125, width = 75),
                                     tags$img(src = "empire.jpg", height = 112, width = 77),
                                     tags$img(src = "et.jpg", height = 100, width = 65),
                                     tags$img(src = "future.jpg", height = 105, width = 70),
                                     tags$img(src = "ghost.jpg", height = 105, width = 70),
                                     tags$img(src = "independent.jpg", height = 100, width = 80),
                                     tags$img(src = "lion.jpg", height = 105, width = 75),
                                     tags$img(src = "pirate.png", height = 90, width = 60),
                                     tags$img(src = "pulp.jpg", height = 90, width = 60),
                                     tags$img(src = "titanic.jpg", height = 105, width = 70),
                                     tags$img(src = "rings.jpg", height = 90, width = 60),
                                     tags$img(src = "harry.jpg", height = 105, width = 70),
                                     tags$img(src = "inception.jpg", height = 105, width = 70),
                                     tags$img(src = "moonlight.jpg", height = 105, width = 70),
                                     tags$img(src = "marvel.jpg", height = 75, width = 100),
                                     tags$img(src = "disney.jpg", height = 54, width = 96)
                                   )
                                 ),
                                 tags$blockquote(
                                   tags$h3("The Bechdel test (in case you didn't know) has three passing requirements: "),
                                   tags$ol(
                                        tags$li("a scene with two women talking to each other"),
                                        tags$li("both women have names"),
                                        tags$li("women talk about things other than men")
                                      ),
                                   a(href = "http://bechdeltest.com/", "(for more information)")
                                 ),
                                 tags$hr(), 
                                 tags$p("The graphs below show how year made affect the Bechdel Score. Our data set has major movie 
                                        productions from 1970 - 2013 and is a combination of Bechel Test from FiveThirtyEight and 
                                        a dataset from IMDB api. "),
                                   
                                 tags$hr(), 
                                 tags$p("The sliders on the left side of the page allows you to select the
                                        year range you want to view on the graphs. The radio button allows you to see the films that
                                        passed the test and the ones that failed. The first graph on the right allows you to see the 
                                        trends of the pass/fail rate, and the second graph allows you to see the reason those films
                                        failed or passed the test, as well as the categories of the tests."),
                                  
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
                                   plotlyOutput('testResults')
                                 )
                        ),
                        
                        tabPanel("Country (KEANAN)", 
                                 titlePanel('Does Country Made Affect Passing Rates?'),
                                 mainPanel(
                                   textOutput("countryText")
                                 )
                        )
                      )
                           
                           
                           #YOU SHOULD MODIFY THIS FILE BY ADDING YOUR OUTPUT AFTER THE PAGE NAME LIKE THIS:
                           #tabPanel("Page 1", plotOutput("pg1")) <--I think.....? #
)                           
))