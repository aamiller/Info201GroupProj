library(httr)
library(jsonlite)
library(dplyr)

bechdel_data_raw <- read.csv("./bechdel_data/movies.csv", stringsAsFactors = FALSE)
set_to_join <- read.csv("./bechdel_data/movie_metadata_tojoin.csv", stringsAsFactors = FALSE)

## Get the id out of the link URL so can be joined
set_to_join$imdb <- sapply(set_to_join$movie_imdb_link, substring, 27, 35)

## Merge data sets on imdb. NOTE: loses rows from 1794 -> 1725 because not all IDs present in set_to_join.
### Thus bechdel_data_raw is still needed for some things.
total <- merge(bechdel_data_raw, set_to_join, by = "imdb")

write.csv(total, "final_joined_bechdel_data.csv")
