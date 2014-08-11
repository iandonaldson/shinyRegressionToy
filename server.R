
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#
# deploying a shiny service on shinyapps.io
# see https://github.com/rstudio/shinyapps/blob/master/guide/guide.md
# and then
# deployApp()
# to deploy or redeploy with saved changes
#
# installing a shiny server on your own machine
# http://table1.org/setting-up-an-ubuntu-server-with-nginx-up-to-run-shiny-applications/
#
# debugging shiny apps
# http://shiny.rstudio.com/articles/debugging.html

library(shiny)


shinyServer(function(input, output) {
  
  #any line that has an input variable in it is reactive (it will change as the user changes the value)
  #as a matter of good form use "input$param" instead of just "param" when referring to a variable set in the ui    
  
  #output for x values tab
  x <- reactive({rnorm(n=input$no.samples, mean=input$mean.x, sd=input$sd.x)})
  output$plotX <- renderPlot({
    bin.breaks <- seq(from=min(x()), to=max(x()), length.out = input$bins + 1)
    #use statments like this for debugging
    #cat("x = ", x()[1], "bin.breaks = ", bin.breaks, "bins = ", input$bins)
    hist(x(), breaks = bin.breaks, main = paste("Histogram of x values"), xlab = "value of x", col = 'darkgray', border = 'white')
  })
  
  #output for y values tab
  error <- reactive(rnorm(n=length(x()), mean=0, sd=input$sd.err))
  y <- reactive({input$slope * x() + input$intercept + error()})
  output$plotY <- renderPlot({
    bin.breaks <- seq(from=min(y()), to=max(y()), length.out = input$bins + 1)
    hist(y(), breaks = bin.breaks, main = paste("Histogram of y values"), xlab = "value of y", col = 'darkgray', border = 'white')
  })
  
  #output for the info tab
  output$text1 <- renderPrint({paste("mu = ", input$mu)})
  xy <- reactive({ as.data.frame(cbind(X=x(), Y=y()) ) })
  output$xyTable <- renderDataTable({ xy()[,] })
  
  #output for x-y scatter plot tab
  fit <- reactive({ lm(Y~X, data=xy()) }) 
  
  output$scatterPlot <- renderPlot({
    plot(xy())   
    abline(fit(), col="red")
  })
  
  output$modelSummary <- renderPrint({ summary(fit()) })
  
  
}
)



