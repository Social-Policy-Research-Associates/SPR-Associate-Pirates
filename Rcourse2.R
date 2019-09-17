#URJ 6Point Sci/Tech
#R Day 2
#Script by Joshua Mallett
#6/6/2018

################################################################################
#    DATA! Working directories
################################################################################

getwd()

setwd("C:/Users/humoroussmile/Desktop/URJ")     # set working directory

#tells you all the data you currently have available based on packages
data()

################################################################################
#    Using the R 'datasets' package for plotting
################################################################################

library(datasets)
#women
head(women)
plot(women$height,women$weight)
plot(women$height,women$weight,type="o",col="blue")
title(main="American Women",col.main="darkgreen",font.main=3)
colors() #check colors

################################################################################
#   Explore data
################################################################################

#trying to understand the data
#means table
install.packages("reshape2")
install.packages("data.table")
library(reshape2)
library(data.table)

head(tips)
View(tips)
summary(tips)
summary.factor(tips$day)

tipsjosh<-data.table(tips)
tipsjosh
tipsjosh[,list(mean=mean(total_bill)),by=time] #get mean of total_bill by time in a table

#PIE CHART
install.packages("plyr")
library(plyr)
freqtime <- count(tips, 'time')
pie(freqtime$freq,labels=freqtime$time,
    main="Proportion of people eating Dinner/Lunch")
#add percentages to our pie chart
percent <- round(freqtime$freq/sum(freqtime$freq)*100)
#creates new labels
newlab <- paste(freqtime$time,percent)
newlab <- paste(newlab,"%",sep="")
pie(freqtime$freq,labels=newlab,col=rainbow(length(newlab)),
    main="Proportion of people eating Dinner/Lunch")

#3D PIE CHART
install.packages("plotrix")
library(plotrix)
pie3D(freqtime$freq,labels=newlab,explode=0.1,
    main="Proportion of people eating Dinner/Lunch")

#histograms
hist(tips$total_bill,breaks=5,col="red",
     main="Histogram of Restaurant Bills ($)")
#add a normal distribution curve
h <- hist(tips$total_bill,breaks=10,col="red",
        xlab="Restaurant Bills ($)",
        main="Histogram of Restaurant Bills ($)")
xfit <- seq(min(tips$total_bill),max(tips$total_bill),length=60) 
yfit <- dnorm(xfit,mean=mean(tips$total_bill),sd=sd(tips$total_bill)) 
yfit <- yfit*diff(h$mids[1:2])*length(tips$total_bill) 
lines(xfit, yfit, col="blue", lwd=2) 

#Kernel Densities
d <- density(tips$total_bill)
plot(d)

#compare kernels by groups
install.packages("sm")
library(sm)
sm.density.compare(tips$total_bill,tips$day,xlab="Total Bill ($)")
title(main="Total Bill ($) by Day")
#how do we know how many days in our data?
summary(tips)
# create value labels 
legend("topright", levels(tips$day), fill=2+(0:nlevels(tips$day)))

################################################################################
#   Lots of plots!
################################################################################

install.packages("sm")
library(sm)
head(aircraft)
summary(aircraft)
#dot plots
#cex changes size style
dotchart(aircraft$Speed,cex=2,
         main="Speed of 20th century aircraft",xlab="Speed (km/h)")
plot(aircraft$Length,aircraft$Speed,cex=1.5,pch=11)
# regression line (y~x) 
abline(lm(aircraft$Speed~aircraft$Length), col="red") 

#boxplots
boxplot(aircraft$Range~aircraft$Period,main="Range of 20th Century Aircrafts",
        col="darkgreen",xlab="20th Century Time Period",ylab="Range of Aircraft (km)",
        range=0,plot=FALSE)

#lattice plots
install.packages("lattice")
library(lattice)
xyplot(aircraft$Speed~aircraft$Length|aircraft$Period, scales=list(cex=.5, col="red"),
       xlab="Length (m)", ylab="Speed (km/h)", 
       main="Speed v. Length of Aircraft by Time Period (20th Century)") 
periodfix <- factor(aircraft$Period,levels=c(1,2,3),
                    labels=c("1: Early 20th Century","2: Mid 20th Century","3: Late 20th Century"))
xyplot(aircraft$Speed~aircraft$Length|periodfix, scales=list(cex=.5, col="red"),
       xlab="Length (m)", ylab="Speed (km/h)", 
       main="Speed v. Length of Aircraft by Time Period (20th Century)") 

#advanced scatterplots (lattice plots)
super.sym <- trellis.par.get("superpose.symbol")
splom(aircraft[c(5,7)], group=aircraft$Period, 
      panel=panel.superpose,
      key=list(title="Three Major Time Periods 20th Century", 
               columns=3,points=list(pch=super.sym$pch[1:3],
                                     col=super.sym$col[1:3]),
               text=list(c("1: Early 20th Century","2: Mid 20th Century","3: Late 20th Century"))))

#3D Scatter
install.packages("scatterplot3d")
library(scatterplot3d)
#type = p (points), h (veritcal lines), or l (lines)
scatterplot3d(aircraft$Speed,aircraft$Weight,aircraft$Span,pch=20,
              highlight.3d=TRUE,type="p",main="Speed x Weight x Span of 20th Century Aircrafts")

#shiny scatter
install.packages("rgl")
library(rgl)
plot3d(aircraft$Speed,aircraft$Weight,aircraft$Span, col="red", size=3)

################################################################################
#   SAVE YOUR PLOTS!
################################################################################

png(filename="myplot1.png")
pdf()
jpeg()
#plot() <-----then plot your plot 
dev.off()
