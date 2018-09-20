#
# This is the server logic to implement for choosing the best predictor
# variable in mtcars dataset with mpg variable set as outcome
# 
#

library(shiny)
library(dplyr)

# Define server logic required to find the best predictor
shinyServer(function(input, output) {
  

  output$Plot1 <- renderPlot({
    data(mtcars)
    # initiailize the test by assigning the number predictors to compare 
    z <- input$sliderNumVar
    p <- z - 1
    min <- -Inf
    pvalues <- numeric(p)
    #
    # start comparing preditors on based on pvalue
    #
    for(i in 1:p){
      fit <- lm(mtcars$mpg ~ mtcars[ ,i+1])
      summ <- summary(fit)
      pvalues[i] <- summ$coefficients[2,4]
      if(i == 1) {
        k <- i 
        min <- pvalues[i]
      }
      else{
        if(pvalues[i] <= min){
          min <- pvalues[i]
          k <- i 
        }
      }
    }
    #
    # choose the predictor witht he least pvalue and plot the model fit
    #
    fit <- lm(mtcars$mpg ~ mtcars[ ,k+1])
    plot(mtcars[ ,k+1], mtcars$mpg, xlab = names(mtcars[k+1]),
         ylab = "Milage per Gallon ", cex = 1.5, pch = 16)
    abline(fit, col = "red", lwd = 2)
    #
    # print out the name o the best predictor variable
    #
    output$var <- renderText({
      names(mtcars[k+1])
    })
    #
    # print the pvalue corresponding to the best predictor
    #
    output$pvalue <- renderText({
      pvalues[k]
    })
  })
  
})