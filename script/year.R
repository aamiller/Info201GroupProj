library(dplyr)

#read in the data table from bechdel table
#setwd('~/Desktop/info 201 exercises/Info201GroupProj/')
bechdel_data_raw <- read.csv("./bechdel_data/movies.csv", stringsAsFactors = FALSE)
yearly_dataset <- select(bechdel_data_raw, year, imdb, title, clean_test, binary, budget)

source('./script/yearly_data.R')

years <- unique(yearly_dataset$year)
test <- yearly_data(years[1])
years <- years[2:44]
for (year in years) {
  year_num <- yearly_data(year)
  test <- rbind(test, year_num)
}
