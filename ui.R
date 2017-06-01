#install.packages('shinythemes')
#install.packages("Hmisc")
library(dplyr)
library(ggplot2)
library(plotly)
library(Hmisc)
library(shiny)
library(shinythemes)

#reading data from fivethirtyeight
bechdel_data_raw <- read.csv("./bechdel_data/movies.csv", stringsAsFactors = FALSE)
new_data <- read.csv('./bechdel_data/final_joined_bechdel_data.csv', stringsAsFactors = FALSE)
year_data <- year(bechdel_data_raw)

#sourcing functions in different file 
source('./script/year.R')
source('./script/profitBechdelAssessment.R')

#Shiny App UI 
shinyUI(shinyUI(navbarPage(theme = shinythemes::shinytheme("sandstone"),
                           
                           title = "BECHDEL TEST REPORT",
                           
                           #Home page 
                           tabPanel(h5("Home"), 
                                    #this is the introduction page
                                    tags$div(id = "cover",
                                             tags$h3("Introduction", class = "cover-content"),
                                             tags$script(HTML("var slideIndex = 0;
                                                              carousel();
                                                              
                                                              function carousel() {
                                                              var i;
                                                              var x = document.getElementsByClassName('cover-content');
                                                              for (i = 0; i < x.length; i++) {
                                                              x[i].style.display = 'none'; 
                                                              }
                                                              slideIndex++;
                                                              if (slideIndex > x.length) {slideIndex = 1} 
                                                              x[slideIndex-1].style.display = 'block'; 
                                                              setTimeout(carousel, 2000); // Change image every 2 seconds
                                                              }"))
                                    ),
                                    #using style sheet
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
                           
                           #Rating tab 
                           tabPanel(h5("Rating"), 
                                    tags$h3(class = "header",'Adjust Rating (PG-13, etc.) Affect Passing Rates?'),
                                    
                                    #main panel for plot and summary 
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
                                    
                                    #sidebar panel for explanation about different rating 
                                    sidebarPanel(
                                      tags$h2(class = "header", "Content Ratings Guide", align = "center"),
                                      tags$p(class = "guide", strong("PG -- "), "Patental guidance suggested, some material may not be suitable for children.", align = "center"),
                                      tags$p(class = "guide", strong("PG-13 --"), "Parents strongly cuationed. Some material may be inappropriate for children under 13.", align = "center"),
                                      tags$p(class = "guide", strong("R -- "), "Restricted, under 17 requires accompanying parent or adult guardian.", align = "center"),
                                      tags$p(class = "guide", strong("NC-17 -- "), "No one 17 and under admitted.", align = "center"),
                                      tags$p(class = "guide", strong("Rating X -- "), "In some countries, X or XXX is or has been a motion picture rating reserved for the most explicit films. Films rated X are 
                                             intended only for viewing by adults, usually defined as people over the age of 18 or 21.", align = "center"),
                                      tags$p(class = "guide", strong("Rating TV-14 -- "), "Programs rated TV-14 may contain some material that parents or adult guardians may find unsuitable for children under 
                                             the age of 14. The FCC warns that \"Parents are cautioned to exercise some care in monitoring this program and 
                                             are cautioned against letting children under the age of 14 watch unattended.\"", align = "center"),
                                      tags$p(class = "guide", strong("Rating G -- "), "General Audiences ??? all ages admitted, meaning there is nothing in theme, language, nudity, sex, violence or other matters 
                                             that the ratings board thinks would offend parents whose younger children view the picture.", align = "center"),
                                      tags$p(class = "guide", strong("Rating Not Rated -- "), "Movie was never given a content rating. Sometimes used deliberately for explicit movies that might otherwise be rating 
                                             R or X.", align = "center"),
                                      tags$p(class = "guide", "Ratings descriptions collected from Wikipedia on 5/28/2017.", align = "center")
                                    )
                           ),
                           
                           #profit tab 
                           tabPanel(h5("Profit&Budget"), 
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
                                        tags$p(class = "guide", "It is worth noting that not all movies have a distinct 
                                               International and a Domestic Gross in our data set, which is visible in a linear line 
                                               that forms in the dataset."),
                                        tags$p(class = "guide", "Most of the movies that pass the Bechdel Test have a budget below 50 
                                               million dollars. Outside of that, the majority do not pass."),
                                        tags$p(class = "guide", "According to Investopedia.com, the average cost for a major studio to 
                                               produce a movie is 65 million dollars plus 35 million in marketing, 
                                               which puts most major productions beyond the range where most movies past the Bechdel Test."))
                                    )
                           ),
                           
                           #popularity tab 
                           tabPanel(h5("Popularity"), 
                                    tags$h3(class = "header", 'Does Popularity Affect Passing Rates?'),
                                    sidebarPanel(
                                      # Input to select variable to map
                                      selectInput('scatterX', label = 'Variable to Map to X Axis', choices = list('Actor1' = 'actor_1_facebook_likes', 'Actor2' = 'actor_2_facebook_likes', 'Actor3' = 'actor_3_facebook_likes'))),
                                    mainPanel(
                                      plotlyOutput("popularity")
                                    )
                           ),
                           
                           #genre tab 
                           tabPanel(h5("Genre"), 
                                    tags$h3(class = "header", 'Does Genre Affect Passing Rates?'),
                                    #main panel for plot and summary 
                                    mainPanel(
                                      plotlyOutput('GenreBechdelAssessmentBar'),
                                      tags$h2("Notes"),
                                      tags$p(class = "guide", "We noticed that adventure genre movies pass frequently, 
                                             as well as thriller movies. We speculate that this is the case for thriller 
                                             movies because the topic of conversation is usually about a monster or danger.")
                                    )
                           ),
                           
                           #year made tab 
                           tabPanel(h5("Year Made"), 
                                    
                                    #a group of five pictures that will show text if hover over the img
                                    tags$div(class = "hvrbox",
                                             tags$img(src = "godfather.jpg",class = "hvrbox-layer_bottom"),
                                             tags$div(class = "hvrbox-layer_top",
                                                      tags$p("1970s is a 'creative high point' in the movie industry. These movies used
                                                             new technologies and opened up to political and social issues.Major productions:",
                                                             em("The Godfather(1972), Jaws(1975), Close Encounters of the Third Kind(1977)."),
                                                             class = "hvrbox-text"))
                                    ),
                                    
                                    tags$div(class = "hvrbox",
                                             tags$img(src = "empire.jpg", class = "hvrbox-layer_bottom"),
                                             tags$div(class = "hvrbox-layer_top",
                                                      tags$p("Like the 1970s, the 1980s produced a lot of disaster movies, buddy
                                                             movies and 'rouge cop' movies.Major productions includes",
                                                             em("Star Wars: The Empire Strikes Back(1980), Ghostbusters(1984), E.T.(1982),
                                                                Back to the Future(1985)."), class = "hvrbox-text"))
                                    ),
                                    
                                    tags$div(class = "hvrbox", 
                                             tags$img(src = "titanic.jpg", class = "hvrbox-layer_bottom"),
                                             tags$div(class = "hvrbox-layer_top",
                                                      tags$p("In the 1990s, movie productions started to make special effects.
                                                             Many films costed over $100 million. 
                                                             However,low budget independent movies also won their populaity. Major productions:", 
                                                             em("Ghost(1990), The Lion King(1994), Pulp Fiction(1995), 
                                                                Titantic(1997)."), class = "hvrbox-text"))
                                    ),
                                    
                                    tags$div(class = "hvrbox", 
                                             tags$img(src = "harry.jpg", class = "hvrbox-layer_bottom"),
                                             tags$div(class = "hvrbox-layer_top",
                                                      tags$p("2000s was strongly influenced by the high technology. Many major websites and social medias took over the internet. The films in this
                                                             decade was also influenced by 911 attacks, Asian tsunami and Hurricans.Major
                                                             productions: ", em("Avatar(2009), Pirates of the Caribbean(2003),
                                                                                Harry Potter and the Sorcerer's Stone (2001)"), class = "hvrbox-text"))
                                    ),
                                    
                                    tags$div(class = "hvrbox", 
                                             tags$img(src = "frozen.jpg", class = "hvrbox-layer_bottom"),
                                             tags$div(class = "hvrbox-layer_top",
                                                      tags$p("Entering the 2010s, movie genres had even wider range. However, as the public greater 
                                                             aknowledging gender-equality, more and more movies gave the lead role to female charaters.
                                                             Major productions: ", em("Inception(2010), moonlight(2016), Marvel Movies, Disney Movies."),
                                                             class = "hvrbox-text"))
                                    ),
                                    
                                    tags$hr(), 
                                    
                                    #the background of this data analysis
                                    tags$h3(class = "header", "Does Year Made Affect Passing Rates?"),
                                    tags$p("The graphs below show ", strong("how year made affect the Bechdel Test Result"), ". Our data set has major movie 
                                           productions from ", strong("1970 - 2013"), " and is a combination of Bechel Test from FiveThirtyEight and 
                                           a dataset from IMDB api.", a(href = "http://bechdeltest.com/", "(for more information)"),
                                           class = "para3"),
                                    
                                    tags$hr(), 
                                    
                                    #the data visualization of year and passing rate
                                    tags$h3(class = "header", "Passing rate from 1970 - 2013"),
                                    fluidRow(
                                      column(3, offset = 2,
                                             #slider widget for choosing year made 
                                             sliderInput("slider", label = h3("Year Made"), min = year_data$year[44], 
                                                         max = year_data$year[1], value = c(year_data$year[40], year_data$year[30])),
                                             
                                             #radio button widget for choosing the test result 
                                             radioButtons("button", label = h3("Test Result"), 
                                                          choices = list("pass" = "PASS", "fail" = "FAIL"),
                                                          selected = "PASS"),
                                             
                                             tags$h4("Result interpretation:", class = "inter"),
                                             
                                             #explaining what each word means
                                             tags$ul(class = "inter",
                                                     tags$li("ok -- pass the test"),
                                                     tags$li("nowomen -- there aren't two women"),
                                                     tags$li("notalk -- two women didn't to each other"),
                                                     tags$li("men -- the topic is men"),
                                                     tags$li("dubious -- the movie fulfilled the category",
                                                             tags$br(), "but the result is dubious")
                                             )
                                      ),
                                      column(6, 
                                             plotlyOutput('linegraph'),
                                             plotlyOutput('testResults')
                                      )
                                    ),
                                    tags$hr(),
                                    
                                    #giving conclusions for this data analysis
                                    tags$h3("Conclusion:", class = "header"),
                                    tags$p("The ", strong("sliders"), " on the left side of the page allows you to select the
                                           year range you want to view on the graphs. The ", strong("radio button"), " allows you to see the films that
                                           passed the test and the ones that failed. The ", strong("first graph"), " on the right allows you to see the 
                                           trends of the pass/fail rate, and the ", strong("second graph"), " allows you to see the reason those films
                                           failed or passed the test, as well as the categories of the tests.", class = "para3"),
                                    
                                    tags$p(class = "para3", "As you can see in this graph, the passing rate increased gradually.
                                           This might due to public recognition of the importance of gender equality or it could
                                           simply be the pressure by the society.")
                                    
                           ),
                           
                           #country tab 
                           tabPanel(h5("Country"), 
                                    tags$h3(class = "header", 'Does Country Made Affect Passing Rates?'),
                                    #main panel for plot and text 
                                    mainPanel(
                                      plotlyOutput('countryGraph', width = "100%", height = "auto")
                                    ),
                                    #sidebar panel for summary 
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
                           
                           #search movie tab 
                           tabPanel(h5("search movie"),
                                    tags$h3("Movie library", class = "header", align = "center"),
                                    dataTableOutput("movieInfo")
                           ),
                           
                           #about us tab
                           tabPanel(h5("About Us"),
                                    tags$h1("About Us", align = "center", class = "header"),
                                    tags$p("We are a group of students in Informatics 201, Technical Foundations, at the University of Washington.", align = "center"),
                                    tags$p("This project was created by ", strong("Adele, Anni, Utako, Keanan and Sherri"), "as a final for the class.", align = "center"),
                                    tags$p("We chose to use the Bechdel Test data because it has a lot of interesting dimensions to consider and is a great benchmark for films' script quality, among other things.", align = "center"),
                                    tags$img(src = "adele.jpg", height = 120, width = 120, id = "profile"),
                                    tags$img(src = "anni.png", height = 120, width = 120, id = "profile"),
                                    tags$img(src = "utako.png", height = 120, width = 120, id = "profile"),
                                    tags$img(src = "Keanan.jpg", height = 120, width = 120, id = "profile"),
                                    tags$img(src = "sherri.jpg", height = 120, width = 120, id = "profile")
                           )
)                           
))