library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Iris Flower Data Exploratory Analytics"),
  helpText("The Iris dataset consists of 150 samples of attributes of the Iris flowers from the following classes:",
           "Setosa, Virginica and Versicolor.",
           "Each class has 50 samples.",
           "The four attributes are Sepal Width (SW), Sepal Length (SL), Petal Width (PW) and Petal Length (PL)."
           ),
  h4("Select the feature you want to see and adjust the number of bins to observe the change in histograms. A good feature should exhibite clear separation in histograms from different classes with few overlapping."),
  fluidRow(
    column(3,
      selectInput(inputId = "features",
                  label = "",
                  choices = c("Sepal Width", 
                              "Sepal Length", 
                              "Petal Width", 
                              "Petal Length"),
                  selected = "Sepal Width")),
    column(1,
      checkboxInput("se", label = "setosa", value = TRUE)),
    column(1,
      checkboxInput("ve", label = "versicolor", value = TRUE)),
    column(1,
      checkboxInput("vi", label = "virginica", value = TRUE))
  ),
  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    position = "right",
    sidebarPanel(
      sliderInput("bins",
                  "Number of bins:",
                  min = 1,
                  max = 30,
                  value = 10)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot")
    )
  )
))