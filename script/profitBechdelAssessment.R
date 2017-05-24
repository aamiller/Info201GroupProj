# Function to build a plot of movies that passed or failed the Bechdel test based on their budget. Scatterplot.
## By Adele

# BuildScatter file: function that returns a plotly map
library(plotly)
library(stringr)
library(Hmisc)

### Build Scatter ###
BuildScatter <- function(data, xvar = 'budget', yvar = 'dom_gross') {
  
  # Get x and y max -- Code adapted from graph given in m18 exercise
  xmax <- max(data[,xvar]) * 1.5
  ymax <- max(data[,yvar]) * 1.5
  x.equation <- paste0('~', xvar)
  y.equation <- paste0('~', yvar)
  
  plot_ly(data=data, x = eval(parse(text = x.equation)), 
          y = eval(parse(text = y.equation)), 
          mode='markers', 
          marker = list(
            opacity = .4, 
            size = 10,
            color = data$binary
          )) %>% 
    layout(title = paste(FixAxisLabels(xvar), "Vs.", FixAxisLabels(yvar), "Financial Bechdel Analysis"), xaxis = list(range = c(0, xmax), title = FixAxisLabels(xvar)), 
           yaxis = list(range = c(0, ymax), title = FixAxisLabels(yvar))
    ) %>% 
    return()
}


# Fixes capitalization and short-hand names in the data set for display
FixAxisLabels <- function(input.var.name) {
  input.var.name <- capitalize(input.var.name)
  return(input.var.name)  
}