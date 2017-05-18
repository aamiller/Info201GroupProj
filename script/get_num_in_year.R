## Function that returns the number of movies in an input year
## Created to check how many data points (movies) the movies data set has for each year

library(dplyr)
setwd('..')
movies.data <- read.csv('./bechdel_data/movies.csv', stringsAsFactors = FALSE)

## Valid years: 1970 - 2013
GetNumInYear <- function(input.year) {
 num.in.year <- filter(movies.data, year == input.year) %>% tally()
 return(num.in.year)
}

## Input a number of films minimum that you want each year to have and get list of them back
## For use to determine how many movies minimum should be required to be used in data
GetYearsWithCountAboveInput <- function(input.min) {
  all.movies <- sapply(1970:2013, GetNumInYear)
  return (sum(all.movies >= input.min))
}
