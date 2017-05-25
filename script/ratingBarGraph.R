## Does rating affect how likely something is to fail the Bechdel Test?
### By Adele
library(dplyr)
library(plotly)

BuildContentRatingBarGraph <- function(movie.data) {
## Filter data set
filtered.data <- movie.data %>% select(content_rating, binary)
GetPercentageWithRatingTestType <- function(input.rating) {
  filter.rating <- filter(filtered.data, content_rating == input.rating)
  sum <- filter.rating %>% tally()
  passed <- filter(filter.rating, binary == "PASS") %>% tally()
  failed <- abs(passed - sum)
  return(c(as.double((passed/sum) * 100), as.double((failed/sum)*100)))
}

## Based on unique ratings
rating.titles <- c('PG-13', 'X', 'G', 'R', 'PG', 'NC-17', 'Unrated', 'Not Rated', 'TV-14')
rate.pg13 <- GetPercentageWithRatingTestType("PG-13")
rate.x <- GetPercentageWithRatingTestType("X")
rate.g <- GetPercentageWithRatingTestType("G")
rate.r <- GetPercentageWithRatingTestType("R")
rate.pg <-GetPercentageWithRatingTestType("PG")
rate.nc17 <- GetPercentageWithRatingTestType("NC-17")
rate.unrated <- GetPercentageWithRatingTestType("Unrated")
rate.notrated <- GetPercentageWithRatingTestType("Not Rated")
rate.tv14 <- GetPercentageWithRatingTestType("TV-14")

## Organize data for bar graph
formatted.pass <- c(rate.pg13[1], rate.x[1], rate.g[1], rate.r[1], rate.pg[1], rate.nc17[1], rate.unrated[1], rate.notrated[1], rate.tv14[1])
formatted.fail <- c(rate.pg13[2], rate.x[2], rate.g[2], rate.r[2], rate.pg[2], rate.nc17[2], rate.unrated[2], rate.notrated[2], rate.tv14[2])


data <- data.frame(rating.titles, formatted.pass, formatted.fail)

p <- plot_ly(data, x = ~formatted.pass, y = ~rating.titles, type = 'bar', orientation = 'h', name = 'Pass',
             marker = list(color = 'green')) %>%
  add_trace(x = ~formatted.fail, name = 'Fail',
            marker = list(color = 'rgba(58, 71, 80, 1.0)')) %>%
  layout(barmode = 'stack',
         xaxis = list(title = "Percentage"),
         yaxis = list(title ="Rating"),
         title = 'Percentages of Films Passing or Failing Bechdel Test by Content Rating') %>% return()
}
