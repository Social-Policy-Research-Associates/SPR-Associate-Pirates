library(shiny)
library(plyr)
library(data.table)
library(reshape2)

josh <- fluidPage(
  selectInput("gender",
              label='Pick a Gender to filter the plot',
              choices = c("Male","Female"),
              selected = 'Male'),
  plotOutput("tipplot")
)

eddie <- function(input,output){
  output$tipplot <- renderPlot({
    
  plot(tips[which(tips$sex==input$gender),]$total_bill,
       tips[which(tips$sex==input$gender),]$tip)
  
    })
}

shinyApp(ui=josh,server=eddie)