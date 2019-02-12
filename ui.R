#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("The most profitable movies"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       sliderInput("year",
                   "Year:",
                   min = 1920,
                   max = 2018,
                   value = c(1968,2018), sep = "", dragRange = TRUE),
       sliderInput("budget",
                   "Budget:",
                   min = 3000000,
                   max = 430000000,
                   value = c(10000,430000000), sep = ",", dragRange = TRUE),
           sliderInput("number",
                    "Top n Movies. n = :",
                    min = 3,
                    max = 100,
                    value = 10), 
       radioButtons("bubble", "Plot against Budget: ", c("Gross-WorldWide","Return"))
        )   ,

    mainPanel(
       plotlyOutput("Plot")
    )
  )
))
