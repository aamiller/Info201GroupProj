library(dplyr)

#Anni: this is a dataset that using function find_movie to search movie info
#using imdb ids from bechdel data

#the code below finds the movie info about movie in 2013 from omdb api

#read in the data table from bechdel table
bechdel_data_raw <- read.csv("./bechdel_data/movies.csv", stringsAsFactors = FALSE)

#read in the function that searches movie
source("./script/find_movie.R")

#get the imdb_id
imdb_id <- bechdel_data_raw$imdb

#get the year range
years <- unique(bechdel_data_raw$year)
#for (year_given in years) {  -- I'm just trying to get it make tables of each years movie, but failed

#2013 movies
sample <- filter(bechdel_data_raw, year == 2013)

#pass in id number to each function
for (id in sample$imdb) {
  if (!exists("result_table")) {
    result_table <- find_movie(sample$imdb[1])
  } else {
    result_table <- merge(result_table, find_movie(id), all = TRUE)
    result_table[is.na(result_table)] <- 0
  }
}

#rename the data table
assign(paste(2013, "table"), result_table)
#}
