library(shiny)
library(ggplot2)
library(reshape2)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  # Expression that generates a histogram. The expression is
  # wrapped in a call to renderPlot to indicate that:
  #
  #  1) It is "reactive" and therefore should re-execute automatically
  #     when inputs change
  #  2) Its output type is a plot
  
  output$distPlot <- renderPlot({
#     x    <- faithful[, 2]  # Old Faithful Geyser data
#     bins <- seq(min(x), max(x), length.out = input$bins + 1)
#     
#     # draw the histogram with the specified number of bins
#     hist(x, breaks = bins, col = 'darkgray', border = 'white')
    binNum = input$bins
    data <- read.csv("data/iris_dataset.csv", header=TRUE, sep="\t")
    colnames(data)[5] <- "class"
    data_long <- melt(data, id="class")
    
    plot_joint_hist <- function(target, n = binNum){
      data_plot <- data_long[data_long$variable==target,]
      bins <- seq(min(data_plot$value), max(data_plot$value), by=(max(data_plot$value) -min(data_plot$value))/n)
      limits_sw <- c(min(data_plot$value), max(data_plot$value))
      m <- ggplot(data_plot,aes(x=value)) 
      a_1 <- 0.0
      a_2 <- 0.0
      a_3 <- 0.0
      if (input$se == TRUE)
        a_1 <- 0.7
      if (input$ve == TRUE)
        a_2 <- 0.7
      if (input$vi == TRUE)  
        a_3 <- 0.7
      m <- m + geom_histogram(data=subset(data_plot,class=='1'),aes(x=value, fill="setosa"), alpha = a_1, breaks=bins, xlim=limits_sw)
      m <- m + geom_histogram(data=subset(data_plot,class=='2'),aes(x=value, fill="versicolor"), alpha = a_2, breaks=bins, xlim=limits_sw)
      m <- m + geom_histogram(data=subset(data_plot,class=='3'),aes(x=value, fill="virginica"), alpha = a_3, breaks=bins, xlim=limits_sw)
      m <- m + guides(fill=guide_legend(title=NULL))
      m <- m + theme_bw()
      m
    }
    feat <- input$features
    
    if (feat == "Sepal Width")
      p <- plot_joint_hist("SW")
    if (feat == "Sepal Length")
      p <- plot_joint_hist("SL")
    if (feat == "Petal Width")
      p <- plot_joint_hist("PW")
    if (feat == "Petal Length")
      p <- plot_joint_hist("PL")
#     plot_joint_hist("SW")
    p
  })
})