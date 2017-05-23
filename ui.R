library(plotly)
shinyUI(shinyUI(navbarPage("Bechdel Test",
                           tabPanel("Page 1"),
                           tabPanel("Page 2"),
                           tabPanel("Page 3"),
                           tabPanel("page 4")
                           
                           #YOU SHOULD MODIFY THIS FILE BY ADDING YOUR OUTPUT AFTER THE PAGE NAME LIKE THIS:
                           #tabPanel("Page 1", plotOutput("pg1")) <--I think.....? 
                           
)))
