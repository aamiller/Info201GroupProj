library(httr)
library(jsonlite)
library(dplyr)

#find information about each movie by given id number
#example <- "http://www.omdbapi.com/?i=tt3896198&apikey=c53bd0e4"

find_movie <- function(id) {
  base.uri <- "http://www.omdbapi.com/?"
  query.param <- list(i = id)
  response <- GET(base.uri, query = query.param)
  body <- content(response, "text")
  result <- as.data.frame(fromJSON(body))
  return (result)
}


