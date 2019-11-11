library(shiny)




josh <- fluidPage(
  selectInput("XVAR",
              label="Variable of Interest",
              choices = c("Total Bill","Size of Party"),
              selected = "Total Bill"),
  
  checkboxGroupInput("gender1",
              label ="Gender of Customer",
              choices = c("Male","Female"),
              selected = c('Female','Male')),
  
  plotOutput("Sav")
)

online <- function(input, output) {
  output$Sav<-renderPlot({
    if (input$XVAR=="Total Bill"){
  plot(tips$total_bill,
       tips$tip,
       cex=0.9,pch=19, col="blue",
       xlab = "Total Bill Paid",
       ylab = "Tip Paid on the Bill",
       main="Scatterplot of Total Bill Paid and Tips")
  abline(lm(tips$tip~tips$total_bill), col="red") }
    if (input$XVAR=="Size of Party"){
      plot(tips$size,
           tips$tip,
           cex=0.9,pch=19, col="blue",
           xlab = "Size of Party",
           ylab = "Tip Paid on the Bill",
           main="Scatterplot of Total Size of Party and Tips")
      abline(lm(tips$tip~tips$size), col="red") }
  })
}

shinyApp(ui = josh, server = online)