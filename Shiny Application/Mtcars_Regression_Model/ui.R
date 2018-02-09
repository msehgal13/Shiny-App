#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
data("mtcars")

# Define UI for application that draws a histogram
shinyUI(fluidPage(
        
        #Set the different tabs
        tabsetPanel(
                tabPanel("Documentation",fluid=TRUE,
                                 mainPanel(
                                         h3("Documentation on how to use this app"),
                                         p("This app is created to do some exploratory analysis on the mtcars
                                           dataset and to select predictor to fit a model to predict mpg. It contains two tabs - 1) Explor and 2) Diagnostic"),
                                         tags$ol(
                                                 tags$li("Explor"),
                                                 p("This tab is used to do some exploratory analysis on the mtcars dataset using plots.
                                                   The user need to provide three inputs on the left hand sidebar"),
                                                 tags$ol(
                                                         tags$li("Predictor - Select the predictor from the drop down to select the predictor against which the 
                                                                 user wants to see a plot of mpg"),
                                                         tags$li("Variable for color coding - Select a variabled from the drop down. The data points in the plot
                                                                 will be color coded by the values of the variable selected from this option"),
                                                         tags$li("Type of plot - This option is used to select the type of chart to be plotted for the selected variables")
                                                 ),
                                                 strong("Click on submit button to see the updated graph"),
                                                 br(""),
                                                 tags$li("Diagnostic"),
                                                 p("This tab is used to select the variables for creating a regression model and see the diagnostic
                                                 plots of the regression created. The user need to select 
                                                   the variables from the left sidebar. At least one 
                                                   variable is required to create a regression model. 
                                                   Once the variables are selected the user will see the
                                                   diagnostic plots and the summary of the regression 
                                                   model on the main panel on the right"),
                                                 strong("Click on submit button to see the updated results")
                                         )
                                 )
                         
                        
                ),
                tabPanel("Explor",fluid=TRUE,
                         # Sidebar with a checkbox input for selecting predictors
                         sidebarLayout(
                                 sidebarPanel(
                                         selectInput("predictors1", "Select predictors for Plot with Mpg",
                                                            c(names(mtcars)[-1]),selected = "cyl"),
                                         selectInput("color", "Select variable for color coding data",
                                                     c(names(mtcars)[-1]),selected = "cyl"),
                                         selectInput("plot_type", "Select plot type",
                                                     c("point","line","boxplot","violin"),selected = "cyl"),
                                         submitButton("Submit")
                                 ),
                                 mainPanel(
                                         h3("Exploratory Plots"),
                                         plotOutput("exploratory")
                                 )
                         )
                ),
                tabPanel("Diagnostic",fluid=TRUE,
                         sidebarLayout(
                                 sidebarPanel(
                                         checkboxGroupInput("predictors2","Select predictors for regression",c(names(mtcars)[-1]),selected="cyl"),
                                         submitButton("Submit")
                                 ),
                                 mainPanel(
                                         h3("Diagnostic Plots"),
                                        plotOutput("diag"),
                                         verbatimTextOutput("summ")
                                 )
                                 )
                         )
                         )
        )
)
