library(dplyr)
library(ggplot2)
library(plotly)
library(Hmisc)
#install.packages('shinythemes')
library(shiny)

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

shinyUI(shinyUI(navbarPage(theme = shinythemes::shinytheme("sandstone"),
                           
                           title = h5("BECHDEL TEST REPORT", class = "title"), 
                           
                           tabPanel(h5("Home"), 
                                    tags$div(id = "cover",
                                             tags$h3("Introduction", class = "cover-content")
                                             ),
                                    tags$link(rel = "stylesheet", type = "text/css", href = "style.css"),
                                    tags$div(class = "movies",
                                             tags$div(class = "movie",
                                                      tags$img(src = "intro1.png"),
                                                      tags$h3("What is a Bechdel Test?", class = "header"),
                                                      tags$h4("According to ", a(href = "http://bechdeltest.com/", "bechdeltest.com"),
                                                              " the Bechdel Test, sometimes called the Mo Movie Measure or Bechdel Rule 
                                                              is a simple test which names the following three criteria: The test was 
                                                              popularized by Alison Bechdel's comic Dykes to Watch Out For, in a 1985 
                                                              strip called The Rule.", class = "para1")
                                                      ),
                                             tags$div(class = "movie",
                                                      tags$img(src = "intro5.jpg"),
                                                      tags$h3("Statistical Analysis:", class = "header"),
                                                      tags$ol(class = "para2",
                                                              tags$li("Does the budget impact the test result?"),
                                                              tags$li("Does the profit impact the test result?"),
                                                              tags$li("Is there a trend based on the year?"),
                                                              tags$li("Does the genre impact the test result?"),
                                                              tags$li("Is the IMDB rating related to the test result?"),
                                                              tags$li("Does rating (PG-13, R, etc.) affect the test result?")
                                                      )
                                             ),
                                             tags$div(class = "movie",
                                                      tags$img(src = "intro3.jpg"),
                                                      tags$h3("Data Set:", class = "header"),
                                                      tags$h4(class = "para2", "Bechdel Tests of movies from ", 
                                                              a(href = "https://github.com/fivethirtyeight/data/", "FiveThirtyEight.")),
                                                      tags$h4("The Bechdel Test has since become relatively well known and is often 
                                                              referenced in movie reviews. It has become a rather embarassing test 
                                                              to fail, though many movies do fail it.", class = "para2")
                                                      ),
                                             tags$div(class = "movie",
                                                      tags$img(src = "intro4.jpg"),
                                                      tags$h3("Three test categories", class = "header"),
                                                      tags$ol(class = "para1",
                                                              tags$li("it has to have at least two women in it,"), 
                                                              tags$li("who talk to each other, about "),
                                                              tags$li("something besides a man. ")
                                                      )
                                             )
                                    )
                           ),
                           
                           tabPanel(h5("Rating (ADELE)"), 
                                    tags$h3(class = "header",'Adjust Rating (PG-13, etc.) Affect Passing Rates?'),
                                    mainPanel(
                                      plotlyOutput('contentRatingBechdelAssessment'),
                                      tags$h2("Notes", align = "center"),
                                      tags$p("This graph displays the percentages of films that passed by their content 
                                             rating. A large number of films in our data set did not contain ratings, 
                                             therefore these graphs draw from a smaller amount of data than other graphs 
                                             in this project. A future question to investigate is the gender distribution 
                                             of shows and how that might affect the likehood of having two women talk to 
                                             each other, based on the number of women in the cast.", align = "center", 
                                             class = "rating")
                                    ),
                                    
                                    sidebarPanel(
                                      tags$h2(class = "header", "Content Ratings Guide", align = "center"),
                                      tags$p(class = "guide", strong("PG -- "), "Patental guidance suggested, some material may not be suitable for children.", align = "center"),
                                      tags$p(class = "guide", strong("PG-13 --"), "Parents strongly cuationed. Some material may be inappropriate for children under 13.", align = "center"),
                                      tags$p(class = "guide", strong("R -- "), "Restricted, under 17 requires accompanying parent or adult guardian.", align = "center"),
                                      tags$p(class = "guide", strong("NC-17 -- "), "No one 17 and under admitted.", align = "center"),
                                      tags$p(class = "guide", strong("Rating X -- "), "In some countries, X or XXX is or has been a motion picture rating reserved for the most explicit films. Films rated X are intended only for viewing by adults, usually defined as people over the age of 18 or 21.", align = "center"),
                                      tags$p(class = "guide", strong("Rating TV-14 -- "), "Programs rated TV-14 may contain some material that parents or adult guardians may find unsuitable for children under the age of 14. The FCC warns that \"Parents are cautioned to exercise some care in monitoring this program and are cautioned against letting children under the age of 14 watch unattended.\"", align = "center"),
                                      tags$p(class = "guide", strong("Rating G -- "), "General Audiences ??? all ages admitted, meaning there is nothing in theme, language, nudity, sex, violence or other matters that the ratings board thinks would offend parents whose younger children view the picture.", align = "center"),
                                      tags$p(class = "guide", strong("Rating Not Rated -- "), "Movie was never given a content rating. Sometimes used deliberately for explicit movies that might otherwise be rating R or X.", align = "center"),
                                      tags$p(class = "guide", "Ratings descriptions collected from Wikipedia on 5/28/2017.", align = "center")
                                    )
                           ),
                           tabPanel(h5("Profit (ADELE)"), 
                                    tags$h3(class = "header", 'Does Profit or Budget Affect Passing Rates?'),
                                    sidebarLayout(
                                      
                                      # Side panel for controls
                                      sidebarPanel(
                                        
                                        # Input to select variable to map
                                        selectInput('scatterVarX', label = 'Variable to Map to X Axis', choices = list('Budget' = 'budget', 'Domestic Gross' = 'domgross', 'International Gross' = 'intgross')),
                                        selectInput('scatterVarY', label = 'Variable to Map to Y Axis', choices = list('Domestic Gross' = 'domgross', 'Budget' = 'budget', 'International Gross' = 'intgross'))
                                      ),
                                      
                                      # Main panel: display plotly map
                                      mainPanel(
                                        plotlyOutput('profitBechdelAssessment'),
                                        textOutput('profitText'),
                                        tags$h2("Notes"),
                                        tags$p(class = "guide", "It is worth noting that not all movies have a distinct International and a Domestic Gross in our data set, which is visible in a linear line that forms in the dataset."),
                                        tags$p(class = "guide", "Most of the movies that pass the Bechdel Test have a budget below 50 million dollars. Outside of that, the majority do not pass."),
                                        tags$p(class = "guide", "According to Investopedia.com, the average cost for a major studio to produce a movie is 65 million dollars plus 35 million in marketing, which puts most major productions beyond the range where most movies past the Bechdel Test."))
                                    )
                           ),
                           tabPanel(h5("Genre (ADELE)"), 
                                    tags$h3(class = "header", 'Does Genre Affect Passing Rates?'),
                                    #sidebarPanel(add your plot here),
                                    mainPanel(
                                      #plotlyOutput("YOUR PLOT NAME),
                                      plotlyOutput('GenreBechdelAssessmentBar'),
                                      tags$h2("Notes"),
                                      tags$p(class = "guide", "We noticed that adventure genre movies pass frequently, as well as thriller movies. We speculate that this is the case for thriller movies because the topic of conversation is usually about a monster or danger.")
                                    )
                           ),
                           tabPanel(h5("Budget (SHERRI)"), 
                                    tags$h3(class = "header", 'Does Budget Affect Passing Rates?'),
                                    #sidebarPanel(add your plot here),
                                    mainPanel(
                                      #plotlyOutput("YOUR PLOT NAME),
                                      textOutput("budgetText")
                                    )
                           ),
                           
                           #tab page 4 by Anni
                           tabPanel(h5("Year Made (ANNI)"), 
                                    tags$h3(class = "header", "The movie genre has changed dramatically for the past 50 years."),
                                    sidebarLayout(
                                      mainPanel(
                                        tags$ul(class = "year",
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
                                    
                                    tags$hr(),
                                    
                                    tags$h3(class = "header", "The Bechdel test (in case you didn't know) has three passing requirements: "),
                                    tags$ol(class = "year",
                                      tags$li("a scene with two women talking to each other"),
                                      tags$li("both women have names"),
                                      tags$li("women talk about things other than men")
                                    ),
                                    a(href = "http://bechdeltest.com/", "(for more information)"),
                                    
                                    tags$hr(), 
                                    
                                    tags$h3(class = "header", "Does Year Made Affect Passing Rates?"),
                                    tags$p("The graphs below show ", strong("how year made affect the Bechdel Test Result"), ". Our data set has major movie 
                                    productions from ", strong("1970 - 2013"), " and is a combination of Bechel Test from FiveThirtyEight and 
                                    a dataset from IMDB api.", class = "para3"),
                                    
                                    tags$hr(), 
                                    
                                    tags$p("The ", strong("sliders"), " on the left side of the page allows you to select the
                                    year range you want to view on the graphs. The ", strong("radio button"), " allows you to see the films that
                                    passed the test and the ones that failed. The ", strong("first graph"), " on the right allows you to see the 
                                    trends of the pass/fail rate, and the ", strong("second graph"), " allows you to see the reason those films
                                    failed or passed the test, as well as the categories of the tests.", class = "para3"),
                                    
                                    tags$p(class = "para3", "As you can see in this graph, the passing rate increased gradually.
                                           This is might due to public recognition of the importance of gender equality or it could
                                           simply be the pressure by the society."),
                                    
                                    #page 4 side bar panel
                                    sidebarPanel(
                                      
                                      #page 4 slider widget
                                      sliderInput("slider", label = h3("Year Made"), min = year_data$year[44], 
                                                  max = year_data$year[1], value = c(year_data$year[40], year_data$year[30])),
                                      
                                      #page 4 radio button widget
                                      radioButtons("button", label = h3("Test Result"), 
                                                   choices = list("pass" = "PASS", "fail" = "FAIL"),
                                                   selected = "PASS"),
                                      
                                      tags$hr(),
                                      
                                      tags$h4("Result interpretation:", class = "inter"),
                                      
                                      tags$ul(class = "inter",
                                        tags$li("ok -- pass the test"),
                                        tags$li("nowomen -- there aren't two women"),
                                        tags$li("notalk -- two women didn't to each other"),
                                        tags$li("men -- the topic is men"),
                                        tags$li("dubious -- the movie fulfilled the category",
                                                tags$br(), "but the result is dubious")
                                      )
                                    ),
                                    
                                    #page 4 main panel
                                    mainPanel(
                                      plotlyOutput('linegraph'),
                                      plotlyOutput('testResults')
                                    )
                           ),
                           
                           tabPanel(h5("Country (KEENAN)"), 
                                    tags$h3(class = "header", 'Does Country Made Affect Passing Rates?'),
                                    mainPanel(
                                      plotlyOutput('countryGraph', width = "950", height = "700"),
                                      tags$h2("Notes", align = "center"),
                                      textOutput('countryText')
                                    ),
                                    sidebarPanel(
                                      tags$h2(class = "header", "Bechdel Pass by Country", align = "center"),
                                      tags$p(class = "guide", "The graph above shows the ratio of number of films that PASSED the test to the number of  
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
                                             affect the likehood of having two women talk to each other." , align = "center")
                                       )
                           ),
                           
                           tabPanel(h5("About Us"),
                                    tags$h1("About Us", align = "center", class = "header"),
                                    tags$p("We are a group of students in Informatics 200, Technical Foundations, at the University of Washington.", align = "center"),
                                    tags$p("This project was created by Anni, Utako, Adele, Keanan and Sherri as a final for the class.", align = "center"),
                                    tags$p("We chose to use the Bechdel Test data because it has a lot of interesting dimensions to consider and is a great benchmark for films' script quality, among other things.", align = "center"),
                                    tags$img(src = "adele.jpg", height = 120, width = 120, id = "profile"),
                                    tags$img(src = "Anni.jpg", height = 120, width = 140, id = "profile"),
                                    tags$img(src = "Utako.jpg", height = 120, width = 140, id = "profile")
                                    
                           ), 
                           tabPanel(h5("search movie"),
                                    tags$h3("type your movie here", class = "header"),
                                    tags$input(type="text", name="search", placeholder="Search..")
                           )
                           
                           #YOU SHOULD MODIFY THIS FILE BY ADDING YOUR OUTPUT AFTER THE PAGE NAME LIKE THIS:
                           #tabPanel("Page 1", plotOutput("pg1")) <--I think.....? #
)                           
))