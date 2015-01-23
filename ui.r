library(shiny)

# Define UI for the application that facilitates the selection of car's features
shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("Fuel Efficient Car"),
  
  # Sidebar with a slider input for number of miles
  sidebarPanel(
    p("This application aims to help you select car type that is fuel efficient. Specify the parameters and see the results on the right. The first step is to select the range of your daily commuting"),
    h4("Number of miles per day:"),
    sliderInput("miles", 
                "", 
                min = 0,
                max = 100, 
                value = c(10,30)),
    
    p("Then select the transmission type. For automatic you need also to specify the number of cylinders"),
    h4("Transmission Type:"),
    radioButtons("am", "",
                 c("Automatic" = "Automatic",
                   "Manual" = "Manual"
                   ),selected = "Automatic"),
    #Number of cylinders relevant only for automatic, thus this is a conditional panel
    conditionalPanel(
      condition = "input.am == 'Automatic'",
      h4("Number of cylinders:"),
      radioButtons("cylinders", "",
                   c("4" = "4",
                     "6" = "6",
                     "8" = "8"),selected = 6)
    )

  ),
  
  # Show the results based on the server
  mainPanel(
    h4("Predicated fuel consumptions [Miles Per Galon]:"),
    verbatimTextOutput("predictedMPG"),
    h4("Predicated galons per day:"),
    verbatimTextOutput("predictedGalons")
  )
))
