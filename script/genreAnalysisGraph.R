## Analyzing pass/fail rates by genre
## By Adele, who would like to note that the data wrangling took her a long, long time and produced something she thinks is awesome.
library(plotly)
library(dplyr)
library(plotly)

## Takes final_joined_bechdel_data.csv
BuildGenreBarPlot <- function(bechdel_data_raw) {

passing.data <- filter(bechdel_data_raw, binary == "TRUE")
failing.data <- filter(bechdel_data_raw, binary == "FALSE")

## Combine all genres into one string
genres <- unlist(bechdel_data_raw$genres)
genres.one.str <- paste(genres, sep="", collapse="")
genres <- strsplit(genres.one.str, '|', fixed = TRUE)
genres.unique <- unique(unlist(genres)) ## Stores unique genres, 247 total

genres.unique.list <- as.list(genres.unique)

## Set up dataframe to increment
increment.frame <- data.frame(genres.unique.list, stringsAsFactors = FALSE)
startct <- rep(0, 247)
increment.frame <- rbind(increment.frame, startct, startct) ## Fill with 0s
## ROW 2 = PASS, ROW 3 = FAIL



### NOTE: Did not capture compound genre names for some reason. Which is ok, because we don't need to display
### hundreds of genres. Bug!!!
p.f.list <- as.list(bechdel_data_raw[,7])
genre.list <- as.list(bechdel_data_raw[,26])

  for (i in 1:1725) {
    if (p.f.list[i] == "FAIL") { rownum <- 2 } ## If fail 
    if (p.f.list[i] == "PASS") { rownum <- 3 } ## If pass
  
    genres.combined <- paste(genre.list[i], sep="", collapse="")
    split.genres <- unlist(strsplit(genres.combined, '|', fixed = TRUE))
    split.genres <- as.list(split.genres)
    
    for (z in 1:length(split.genres)) {
      colnum <- as.integer(which(genres.unique.list == unlist(split.genres[z])))
      rownum <- as.integer(rownum)
      increment.frame[rownum,colnum] <- toString(as.integer(increment.frame[rownum,colnum]) + as.integer(1))
     }
  }


## Get desired columns
selected.columns <- select(increment.frame, X.Comedy., X.Fantasy., X.Drama., X.Crime., X.Family., X.History., X.Mystery., X.Horror., X.Adventure., X.Romance., X.Sci.Fi., X.Thriller., X.Animation., X.Music., X.Musical., X.Biography.)


## Set up graph
Genre.titles <- c("Comedy", "Fantasy", "Drama", "Crime", "Family", "History", "Mystery", "Horror", "Adventure", "Romance", "Sci-Fi", "Thriller", "Animation", "Music", "Musical", "Biography")
passed.nums <- as.integer(selected.columns[2,])
failed.nums <- as.integer(selected.columns[3,])

data <- data.frame(Genre.titles, passed.nums, failed.nums)

plot <- plot_ly(data, x = ~Genre.titles, y = ~passed.nums, type = 'bar', name = 'PASS',  marker = list(color = 'rgb(50,205,50)')) %>%
  add_trace(y = ~failed.nums, name = 'FAIL', marker = list(color = 'rgb(220,20,60)')) %>%
  layout(title = "Pass/Fail Rate by Genre",yaxis = list(title = 'Count'), xaxis = list(title = 'Genre'), barmode = 'group', bargap = 0.15, bargroupgap = 0.1)

return(plot)
}