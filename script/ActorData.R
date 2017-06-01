library(plotly)
library(stringr)
library(Hmisc)
library(dplyr)
ActorData <- function(input.name) {
   my.data <- select(joined.movie.data, actor_1_facebook_likes, actor_2_facebook_likes, actor_3_facebook_likes, movie_facebook_likes, binary) 
   print(input.name)
   b <- FixAxisLabels(input.name)
   print(b)
   Actor <- my.data[,b]
  plot <- plot_ly(data=my.data, color = ~binary,colors = c("red", "green"),
                  x = ~Actor, y = ~movie_facebook_likes, mode = 'markers',
                  marker = list(
                    opacity = .5, 
                    size = 10)) %>%
    layout(title = paste(FixAxisLabels(b), "Vs.", "Movie likes in Facebook"))
                                      
                    

  return(plot)
}
FixAxisLabels <- function(input.name) {
  print(input.name)
  if (input.name == "Actor1") { input.name <- "Actor1 popularity"}
  if (input.name == "Actor2") { input.name <- "Actor2 popularity"}
  if (input.name == "Actor3") { input.name <- "Actor2 popularity"}
  
  return(input.name)
}

