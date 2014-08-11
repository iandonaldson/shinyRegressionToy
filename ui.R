
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#
# to run this shiny application, use 
# runApp()
# on the R command line while in the working directory that contains ui.R and server.R

library(shiny)

shinyUI(fluidPage(
  # Application title
  titlePanel("shiny regression toy"),
  
  sidebarLayout(
    sidebarPanel(title="controls",
                 wellPanel(
                   h4("X"),
                   sliderInput("mean.x", "Choose the mean of X", min = -100, max = 100, value = 0),
                   sliderInput("sd.x", "Choose the std deviation of X", min = 0.1, max = 10, value = 5, step=0.1),
                   br()
                 ),
                 wellPanel(
                   h4("Y"),
                   h5("y = slope * x + intercept + error"),
                   sliderInput("slope", "Choose the slope value", min = -10, max = 10, value = 1, step = 0.1),
                   sliderInput("intercept", "Choose the intercept value", min = -10, max = 10, value = 0, step = 0.1),
                   sliderInput("sd.err", "Choose the std deviation of the error term", min = 0, max = 3, value = 1, step = 0.1)
                 ),        
                 wellPanel(
                   h4("other controls"),
                   sliderInput('no.samples', 'Change the number of samples in the data set',value = 50, min = 3, max = 100, step = 1),
                   sliderInput("bins", "Change the number of bins in histograms", min = 1, max = 100, value = 10)
                 )
                 
    ),
    
    
    mainPanel(#note, this is an arg to sidebarLayout
      tabsetPanel(type = "tabs",
                  tabPanel(title = "instructions", 
                           h4("Instructions"),
                           h6("Step 1"),
                           p("Define a vector of values called X by specifying a mean and a standard deviation."),
                           h6("Step 2"),
                           p("A vector of values called Y will be created from X using the formula:"),
                           code("Y = slope*X + intercept + error"),
                           p("You can specify the values of the linear relationship (slope, intercept and the standard deviation of the error)."),
                           h6("Step 3"),
                           p("The data X,Y will be plotted and a linear regression model will be calculated using the R lm function."),
                           p("The plot and the results of the model can be viewed in the 'model' tab."),
                           h6("Other"),
                           p("Other tabs on this page allow you to view the the actual values of X and Y (info tab) and histograms of the distributions of the X and Y variables (histogram tabs)."),
                           p("You can change the number of XY points in the simulation using the slider at the bottom of the left-hand panel."),
                           p("You can also change the resolution of the histograms."),
                           br(),
                           h6("Looking for the code?"),
                           a("https://github.com/iandonaldson/shinyRegressionToy")
                  ),
                  tabPanel(title = "model",
                           plotOutput("scatterPlot"),
                           verbatimTextOutput("modelSummary")
                  ),
                  tabPanel(title = "info", 
                           h3("X and Y values for all points"),
                           dataTableOutput("xyTable")
                  ),
                  tabPanel(title = "x histogram", plotOutput("plotX")),
                  tabPanel(title = "y histogram", plotOutput("plotY"))
      )
    )
  )
))








