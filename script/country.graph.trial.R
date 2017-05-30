
library(dplyr)
library(shiny)
library(plotly)

bechdel <- read.csv("./bechdel_data/movies.csv", stringsAsFactors = FALSE)
full_data <- read.csv("./bechdel_data/final_joined_bechdel_data.csv")


country.data <- select(full_data, country, binary)
my.data.year <- country.data %>% group_by(country) %>% summarise("number.passed" = sum(binary == "PASS"),
                                                                 "number.failed" = sum(binary == "FAIL"))
my.data.year <- mutate(my.data.year, "passage.rate" = number.passed/(number.passed + number.failed))
my.data.year <- mutate(my.data.year, "number.movies" = number.passed + number.failed)                
my.data.year <- my.data.year[-c(22), ] #remove "official site", cannot be mapped as location.
my.data.year <- my.data.year[-c(31), ] #remove west germany, no longer a representable country
trace1 <- list(
  z = my.data.year$passage.rate,
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
p <- plot_ly()
p <- add_trace(p, z=trace1$z, autocolorscale=trace1$autocolorscale, colorbar=trace1$colorbar, locations=trace1$locations, marker=trace1$marker, colors=trace1$colors, reversescale=trace1$reversescale, type=trace1$type, zmin=trace1$zmin)
p <- layout(p, geo=layout$geo, title=layout$title)
