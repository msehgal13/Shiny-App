#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
data("mtcars")

mtcars$cyl<-as.factor(mtcars$cyl)
mtcars$am<-as.factor(mtcars$am)
mtcars$vs<-as.factor(mtcars$vs)
mtcars$gear<-as.factor(mtcars$gear)
mtcars$carb<-as.factor(mtcars$carb)

# Define server logic 
shinyServer(function(input, output) {
        
        pred1<-reactive({
                mtcars[,input$predictors1]        
        })
        color1<-reactive({
                mtcars[,input$color]
        })
        
        output$exploratory<-renderPlot({
                        qplot(y=mtcars$mpg,x=pred1(),ylab="Mpg",xlab=input$predictors1,color=color1(),geom=input$plot_type)+labs(color=input$color)+theme_bw()
                })
        
        fit<-reactive({
                req_data<-mtcars[,c("mpg",input$predictors2)]
                lm(mpg~.,data=req_data)
        })
   
  output$diag <- renderPlot({
          validate(
                  need(input$predictors2!="","Please select at least one predictor")
          )
    #Plot the data and the regression line
    #plot(x=1:length(y),y=y)
    #abline(fit())
          par(mfrow=c(3,2))
          plot(fit(),which=1:6)
          #plot(x=fit()$fitted.values,y=mtcars[,"mpg"])
          #abline(0,1)
    
  })
  
  output$summ<-renderPrint({
          validate(
                  need(input$predictors2!="","Please select at least one predictor")
          )
          summary(fit())
  })
  
  output$error<-renderText("Please select at least one variable for the model")
})
