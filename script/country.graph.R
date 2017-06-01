library(dplyr)
library(shiny)
library(plotly)

# this function outputs a choropleth world map that shows some data relating different companies
countryGraph <- function(country.movie.data) {

  # the next few lines of code clean up the data and make a new data frame out of it only including the
# information needed for the plot.
country.movie.data <- country.movie.data %>% group_by(country) %>% summarise("number.passed" = sum(binary == "PASS"),
                                                                 "number.failed" = sum(binary == "FAIL"))
country.movie.data <- mutate(country.movie.data, "passage.rate" = number.passed/(number.passed + number.failed))
country.movie.data <- mutate(country.movie.data, "number.movies" = number.passed + number.failed)                
country.movie.data <- country.movie.data[-c(22), ] #remove "official site", cannot be mapped as location, not a location.
country.movie.data <- country.movie.data[-c(31), ] #remove west germany, no longer a representable country
# the trace variable will be used to hold all of the specifications for this plot.
# some lines and variables come from stack overflow as noted.
trace1 <- list(
  z = country.movie.data$passage.rate,
  autocolorscale = FALSE, 
  colorbar = list(title = "Passage Rates"), 
  colors = 'RdYlBu',
  # passing in three letter country codes that can be read by plotly and turned into the world map.
  # only includes countries that have data from bechdel test.
  # the next couple lines of code are adapted from stack overflow
  locations =c("AUS","BRA","CMR", "CAN", "CHN", "COL", "CZE", "DNK", "FIN", "FRA", "DEU", "HKG", "IND", "IRL", 
               "ISR", "ITA", "JPN", "MEX", "NLD", "NZL", "NOR", "PER", "RUS", "ZAF", "KOR", "ESP", "TWN", "THA", "GBR", "USA"), 
  marker = list(line = list(
    color = "rgb(180,180,180)", 
    width = 0.5
  )), 
  reversescale = FALSE, 
  type = "choropleth", 
  zmin = 0
)
data <- list(trace1)
layout <- list(
  geo = list(
    projection = list(type = "Mercator"), 
    showcoastlines = TRUE, 
    showframe = FALSE
  ), 
  title = "Passage Rates by Country"
)
p <- plot_ly(text = ~paste("Total # of Movies: ", country.movie.data$number.movies))
p <- add_trace(p, z=trace1$z, autocolorscale=trace1$autocolorscale, colorbar=trace1$colorbar, locations=trace1$locations, marker=trace1$marker, colors=trace1$colors, 
               reversescale=trace1$reversescale, type=trace1$type, zmin=trace1$zmin)
p <- layout(p, geo=layout$geo, title=layout$title)

  return (p)
}

