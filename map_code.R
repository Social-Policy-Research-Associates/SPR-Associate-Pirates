getwd()
setwd("P:/")

read.delim("fireball.txt")

fireball<-read.delim("fireball.txt")

head(fireball)
names(fireball)
summary(fireball)
summary(fireball$latitude)

#create dataframe of summary of fireball dataframe
example.table      <- summary(fireball)
example.table.data <- as.data.frame(t(data.frame(unclass(example.table))))
#rename columns
colnames(example.table.data)[colnames(example.table.data)=="X"]   <- "min"
colnames(example.table.data)[colnames(example.table.data)=="X.1"] <- "Q1"
colnames(example.table.data)[colnames(example.table.data)=="X.2"] <- "median"
colnames(example.table.data)[colnames(example.table.data)=="X.3"] <- "mean"
colnames(example.table.data)[colnames(example.table.data)=="X.4"] <- "Q3"
colnames(example.table.data)[colnames(example.table.data)=="X.5"] <- "max"
colnames(example.table.data)[colnames(example.table.data)=="X.6"] <- "NAs"
#save as excel spreadsheet
write.csv(example.table.data,"fireballtable.csv")


install.packages("rworldmap")
library(rworldmap)
newmap <- getMap(resolution = "low")
plot(newmap)
points(fireball$longitude,fireball$latitude, col = "red")

#ggplot, alpha is plot transparency, CLEAN MAP
library(ggplot2)
world_map <- map_data("world")
p <- ggplot() + coord_fixed() + xlab("") + ylab("")

base_world_messy <- p + geom_polygon(data=world_map, aes(x=long, y=lat, group=group), 
                                     colour="blue", fill="light green")
cleanup <- 
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), 
        panel.background = element_rect(fill = 'white', colour = 'white'), 
        axis.line = element_line(colour = "white"), legend.position="none",
        axis.ticks=element_blank(), axis.text.x=element_blank(),
        axis.text.y=element_blank())

base_world <- base_world_messy + cleanup

#convert zipcode to latitude longitude
install.packages("zipcode")
library(zipcode)

zipcode<-c(94612,85050,48820,94618,94070)
fakezips <- data.frame(zipcode)

data(zipcode)