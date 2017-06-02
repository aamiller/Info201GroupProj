library(plotly)
library(stringr)
library(Hmisc)
library(dplyr)

joined.movie.data <- read.csv("./bechdel_data/final_joined_bechdel_data.csv", stringsAsFactors = FALSE)

#renders the plotly and making the desired dataframe 
ActorData <- function(input.name) {
   my.data <- select(joined.movie.data, actor_1_facebook_likes, actor_2_facebook_likes, actor_3_facebook_likes, movie_facebook_likes, binary) 
   print(FixAxisLabels(input.name))
   Actor <- my.data[,input.name]
   #renders the plotly with appropriate axis names and layout
  plot <- plot_ly(data=my.data, color = ~binary,colors = c("red", "green"),
                  x = ~Actor, y = ~movie_facebook_likes, mode = 'markers',
                  marker = list(
                    opacity = .5, 
                    size = 10)) %>%
    layout(title = paste(FixAxisLabels(input.name), "Vs.", "Movie likes in Facebook"), xaxis = list(title = FixAxisLabels(input.name)), 
           yaxis = list(title = "Movie popularity"))
      
                    

  return(plot)
}
# changes the labels of the axis to be in a more legible and professional format
FixAxisLabels <- function(input.name) {
  print(input.name)
  if (input.name == "Actor1") { input.name <- "Actor 1 Likes on Facebook"}
  if (input.name == "Actor2") { input.name <- "Actor 2 Likes on Facebook"}
  if (input.name == "Actor3") { input.name <- "Actor 3 Likes on Facebook"}
  if (input.name == "actor_1_facebook_likes") { input.name <- "Actor 1 Likes on Facebook"}
  if (input.name == "actor_2_facebook_likes") { input.name <- "Actor 2 Likes on Facebook"}
  if (input.name == "actor_3_facebook_likes") { input.name <- "Actor 3 Likes on Facebook"}
  
  return(input.name)
}

