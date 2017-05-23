library(httr)
library(jsonlite)
library(dplyr)

#find information about each movie by given id number
#example <- "http://www.omdbapi.com/?i=tt3896198&apikey=c53bd0e4"

find_movie <- function(id) {
  base.uri <- "http://www.omdbapi.com/?"
  query.param <- list(i = id, apikey='23e78b2d')
  response <- GET(base.uri, query = query.param)
  body <- content(response, "text")
  result <- as.data.frame(fromJSON(body))
  data <- result[1, ]
  #data <- data %>% select(Title, Year, Rated, Genre, Director, Writer, Actors, Plot, Language, 
                         # Country, Awards, Ratings.Source, imdbRating, imdbVotes, imdbID, Production)
  return (data)
}

#find_movie("tt1711425")


