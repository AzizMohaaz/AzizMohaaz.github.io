#
# Define a UI for an application that finds the best single predictor 
# variable in the dataset mtcars setting Miles per gallon (mpg) is as
# outcome variable
#

library(shiny)

# User inputs the number of predictors to test using a slider
# The number to enter ranges from 2 to 11
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Best Single Variable Predictor for MPG"),
  # Slider input for number of variables 
  sidebarLayout(
    sidebarPanel(
      sliderInput("sliderNumVar",
                   "Enter the number of predictors:",
                   value = 4, min = 2, max = 11, step = 1),
      checkboxInput("ShowPredValue", "Show/Hide best predicted value", value = TRUE)
    ),
    
    # Show a plot of the generated best predictor
    mainPanel(
      h3("Graph of Best Predictor vs. MPG with Model Fit Line"),
      plotOutput("Plot1"),
      h3("Best Predictor is:"),
      textOutput("var"),
      h3("The Pvalue for the Best Predictor is:"),
      textOutput("pvalue")
    )
    )
))