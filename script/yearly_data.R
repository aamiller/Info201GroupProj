library(dplyr)

#setwd('~/Desktop/info 201 exercises/Info201GroupProj/')
bechdel_data_raw <- read.csv("./bechdel_data/movies.csv", stringsAsFactors = FALSE)
yearly_dataset <- select(bechdel_data_raw, year, imdb, title, clean_test, binary, budget)

yearly_data <- function(input.year) {
  pass_or_fail <- yearly_dataset %>% 
    filter(year == input.year) %>% 
    summarise(year = input.year, fail = sum(binary == "FAIL"), pass = sum(binary == "PASS"), 
              total = length(binary))
  return(pass_or_fail)
}

test <- yearly_data(2013)