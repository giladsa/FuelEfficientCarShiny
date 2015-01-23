library(shiny)


data(mtcars); 
d<-mtcars;#loading data
d$am <- factor(d$am,levels=c(0,1),labels=c("Automatic","Manual")) 
d$cyl <- factor(d$cyl) 
fit <- lm(mpg ~ am+am*cyl,d) #fitting liner model

# The server that performs the actual analysis
shinyServer(function(input, output) {
  
  #reactive section, since both inputs depend on the same predicated value
  predictedMPG <- reactive({
    am = input$am
    cyl = input$cylinders
    inputValues <- data.frame(cyl = cyl,am=am)
    predict(fit,inputValues)
  })
  
  output$predictedMPG <- renderText(predictedMPG())
  output$predictedGalons <- renderText({input$miles / predictedMPG()})
  
})
