# Function to build a plot of movies that passed or failed the Bechdel test based on their budget. Scatterplot.
## By Adele

# BuildScatter file: function that returns a plotly map
library(plotly)
library(stringr)
library(Hmisc)
library(dplyr)

### Build Scatter ###
BuildScatter <- function(data.movies, xvar = 'budget', yvar = 'domgross') {
  
  ## Fix chr type columns
  data.movies <- filter(data.movies, xvar != '#N/A', yvar != '#N/A')
  data.movies$domgross <- as.integer(as.character(data.movies$domgross))
  data.movies$intgross <- as.integer(as.character(data.movies$intgross))

  
  # Get x and y max -- Code adapted from graph given in m18 exercise
  xmax <- max(data.movies[,xvar]) * 1.1
  ymax <- max(data.movies[,yvar]) * 1.1
  x.equation <- paste0('~', xvar)
  y.equation <- paste0('~', yvar)
  
  
  plot <- plot_ly(data=data.movies, color = ~binary, colors = c("red", "green"),
          x = eval(parse(text = x.equation)),
          y = eval(parse(text = y.equation)), 
          mode = 'markers',
          marker = list(
            opacity = .4, 
            size = 5
          )) %>% 
    layout(title = paste(FixAxisLabels(xvar), "Vs.", FixAxisLabels(yvar), "Bechdel Financial Analysis"), xaxis = list(range = c(0, xmax), title = FixAxisLabels(xvar)), 
           yaxis = list(range = c(0, ymax), title = FixAxisLabels(yvar))
    )
  
    return(plot)
}


# Fixes capitalization and short-hand names in the data set for display
FixAxisLabels <- function(input.var.name) {
  #print(input.var.name)
  if (input.var.name == 'domgross') { input.var.name <- "Domestic Gross"}
  if (input.var.name == "intgross") { input.var.name <- "International Gross"}
  return(input.var.name)  
}
