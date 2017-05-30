
library(dplyr)
library(shiny)
library(plotly)




countryGraph <- function(country.movie.data) {
country.movie.data <- country.movie.data %>% group_by(country) %>% summarise("number.passed" = sum(binary == "PASS"),
                                                                 "number.failed" = sum(binary == "FAIL"))
country.movie.data <- mutate(country.movie.data, "passage.rate" = number.passed/(number.passed + number.failed))
country.movie.data <- mutate(country.movie.data, "number.movies" = number.passed + number.failed)                
country.movie.data <- country.movie.data[-c(22), ] #remove "official site", cannot be mapped as location, not a location.
country.movie.data <- country.movie.data[-c(31), ] #remove west germany, no longer a representable country
trace1 <- list(
  z = country.movie.data$passage.rate,
  autocolorscale = FALSE, 
  colorbar = list(title = "Passage Rates"), 
  colors = 'RdYlBu',
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
  title = "World Map"
)
p <- plot_ly(text = ~paste("Total # of Movies: ", country.movie.data$number.movies))
p <- add_trace(p, z=trace1$z, autocolorscale=trace1$autocolorscale, colorbar=trace1$colorbar, locations=trace1$locations, marker=trace1$marker, colors=trace1$colors, 
               reversescale=trace1$reversescale, type=trace1$type, zmin=trace1$zmin)
p <- layout(p, geo=layout$geo, title=layout$title)

  return (p)
}

