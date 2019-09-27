#sharing
#this is my website:
#https://urj6point2018.shinyapps.io
#go to rshinyapps.io to set up your own website
#type into console separately from program
#this connects to the Rshiny server
install.packages('rsconnect')
library(rsconnect)
if(!require("devtools"))
  install.packages("devtools")
devtools::install_github("rstudio/rsconnect")

#connect to your specific account with token


#check that it WORKS by running locally first
setwd('C:/Users/humoroussmile/Desktop/URJ/Rshiny')
shiny::runApp()

install.packages('BH')
library(BH)


#Rshiny! TEMPLATE!
library(shiny)
ui <- fluidPage()

server <- function(input, output) {}

shinyApp(ui = ui, server = server)


#or you can just use a single command if WD is set
rsconnect::deployApp('C:/Users/humoroussmile/Desktop/URJ',appName = 'urjExample1')
deployApp(appName='urjExample1')


#Rshiny1
install.packages("reshape2")
install.packages("data.table")
install.packages("plyr")
library(reshape2)
library(data.table)
library(plyr)
head(tips)
View(tips)
summary(tips)
summary.factor(tips$day)

#run the following in rconsole to get up and running with your app
#in the quotes, but the path to your specific app.R or ui.R and server.R
#this gets you running on your WEBSITE
rsconnect::deployApp('C:/Users/humoroussmile/Desktop/URJ/Rshiny',appName = 'urjExample2')
#or
deployApp(appName='urjExample2')

#Rshiny2
setwd('C:/Users/humoroussmile/Desktop/URJ/Rshiny2')
install.packages(c("maps", "mapproj"))
source("helpers.R")
counties <- readRDS("counties.rds")
library(maps)
library(mapproj)
head(counties)
View(counties)
summary(counties)
percent_map(counties$white, "darkgreen", "% White")

#run the following in rconsole to get up and running with your app
#in the quotes, but the path to your specific app.R or ui.R and server.R
#this gets you running on your WEBSITE
rsconnect::deployApp('C:/Users/humoroussmile/Desktop/URJ/Rshiny2',appName = 'urjExample3')
#or
deployApp(appName='urjExample3')

