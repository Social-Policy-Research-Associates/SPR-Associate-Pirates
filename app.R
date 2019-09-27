#Rshiny!

library(shiny)
ui <- fluidPage(
  selectInput("gender", 
              label = "Gender of Customers",
              choices = c("Male","Female","All"),
              selected = "All"),
  selectInput("time", 
              label = "Time of Day",
              choices = c("Lunch","Dinner","All Times"),
              selected = "All Times"),  
  
  sliderInput(inputId = "numx",
              label = "Total Bill Scale of Interest:",
              value = c(3.07, 50.81), min = 3.07, max = 50.81),
  sliderInput(inputId = "numy",
              label = "Tips Scale of Interest:",
              value = c(1, 10), min = 1, max = 10),  
  
  plotOutput("scatter")
  )

server <- function(input, output) {
  output$scatter <- renderPlot({
    library(plyr)
    library(data.table)
    library(reshape2)
    tips.fem <- subset(tips,sex=="Female")
    tips.mal <- subset(tips,sex=="Male")
    tips.l   <- subset(tips,time=="Lunch")
    tips.d   <- subset(tips,time=="Dinner")
    tips.feml<- subset(tips,time=="Lunch" & sex=="Female")
    tips.mall<- subset(tips,time=="Lunch" & sex=="Male")
    tips.femd<- subset(tips,time=="Dinner" & sex=="Female")
    tips.mald<- subset(tips,time=="Dinner" & sex=="Male")

      ifelse(input$gender=="Male",
        tips.final <- switch(input$time, 
                             "Lunch" = tips.mall,
                             "Dinner" = tips.mald,
                             "All Times" = tips.mal),        
      ifelse(input$gender=="All",
        tips.final <- switch(input$time, 
                             "Lunch" = tips.l,
                             "Dinner" = tips.d,
                             "All Times" = tips),
      ifelse(input$gender=="Female",
         tips.final <- switch(input$time, 
                             "Lunch" = tips.feml,
                             "Dinner" = tips.femd,
                             "All Times" = tips.fem))))        

    plot(tips.final$total_bill,tips.final$tip,cex=0.9,pch=19, col="blue",
         xlab = "Total Bill Paid",
         ylab = "Tip Paid on the Bill",
         xlim = range(input$numx[1],input$numx[2]),
         ylim = range(input$numy[1],input$numy[2]),
         main="Scatterplot of Total Bill Paid and Tips")
    abline(lm(tips.final$tip~tips.final$total_bill), col="red") 
    })
}

shinyApp(ui = ui, server = server)