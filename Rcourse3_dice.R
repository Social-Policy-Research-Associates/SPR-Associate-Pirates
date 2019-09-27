#URJ 6Point Sci/Tech
#R Day 3
#Script by Joshua Mallett
#6/9/2018

################################################################################
#    DATA! Working directories
################################################################################

getwd()

setwd("C:/Users/humoroussmile/Desktop/URJ")     # set working directory

#tells you all the data you currently have available based on packages
data()

################################################################################
#    GGPLOT2
################################################################################

install.packages("ggplot2")
install.packages("reshape2")
#load a package ggplot2 for fun plotting, use dataset 'tips'
#time is dinner/lunch
#total_bill is amount paid
#aes builds plot and makes it pretty
#geom_col leaves data as is
library(ggplot2)
library(reshape2)
head(tips)
ggplot(data=tips, aes(x=time, y=total_bill)) + geom_col()
ggplot(data=tips, aes(x=time, y=total_bill,fill=time)) + geom_col()
ggplot(data=tips, aes(x=time, y=total_bill,fill=time)) + geom_col() + guides(fill=FALSE) + xlab("Time of day") + ylab("Total bill") + ggtitle("Average bill for 2 people")

#try on your own
#day, dinner/lunch, total bill
ggplot(data=tips, aes(x=time, y=total_bill, fill=day)) + #fill adds extra group
  geom_col(position=position_dodge()) +                     
  scale_fill_hue(name="Day of week") +      # Set legend title
  xlab("Time of day") + ylab("Total bill") + # Set axis labels
  ggtitle("Average bill") +     # Set title
  theme_bw()


#diamonds dataset or mpg dataset
head(diamonds)
summary(diamonds)

ggplot(data=diamonds, aes(x=cut, y=depth, fill=cut)) + geom_boxplot() + 
  scale_fill_discrete(name="Diamond\nCut",
                      breaks=c("Ideal","Premium","Very Good","Good","Fair")) #changes legend order

ggplot(data=diamonds, aes(x=cut, y=depth, fill=cut)) + geom_boxplot() + 
  scale_fill_manual(values=c("red","green","yellow","black","purple"),
                      name="Diamond Cut",
                      breaks=c("Ideal","Premium","Very Good","Good","Fair")) + #changes legend order
  theme(legend.position="top")

head(mpg)
summary(mpg)
summary.factor(mpg$model)
summary.factor(mpg$manufacturer)
mpg.subset <- subset(mpg,manufacturer=="toyota" | manufacturer=="dodge")
#histogram
ggplot(mpg.subset, aes(x=cty, fill=manufacturer)) +
  geom_histogram(alpha=.5, position="identity") #can use DODGE instead of IDENTITY
#density plot
toydodgplot1 <- ggplot(mpg.subset, aes(x=cty, fill=manufacturer)) +
  geom_density(alpha=.5)
#add mean
install.packages("plyr")
library(plyr)
install.packages("data.table")
library(data.table)
#two ways to get the mean of each group, remember?

#first way
mpgjosh<-data.table(mpg.subset)
mpgjosh
medcty<-mpgjosh[,list(mean=mean(cty),med.cty=median(cty)),by=manufacturer] #get mean by group

#2nd way
meancty<-ddply(mpg.subset, "manufacturer", summarise, cty.mean=mean(cty)) #get mean of each group

toydodgplot2 <- ggplot(mpg.subset, aes(x=cty, fill=manufacturer)) +
  geom_histogram(binwidth=.5,alpha=.5, position="identity") +
  geom_vline(data=meancty, aes(xintercept=cty.mean,  colour=manufacturer),
             linetype="dashed", size=1) +
  geom_vline(data=medcty, aes(xintercept=med.cty,  colour=manufacturer), size=1) +
  ggtitle("City mpg Dodge vs. Toyota")

summary.factor(mpg$trans)
mpg.manual <- subset(mpg,trans=="manual(m5)" | trans=="manual(m6)")
manualplot <- ggplot(mpg.manual, aes(x=hwy, fill=class)) +
  geom_histogram(colour="black", binwidth=10) +
  facet_grid(class~ .) +
  ggtitle("Manual cars Highway speeds, by class of vehicle") +
  theme(legend.position="none")

ggplot(mpg, aes(x=hwy, y=cty)) +
  geom_point(cex=2.5) +
  geom_smooth(method=lm,se=FALSE) +
  ggtitle("Highway mpg vs. City mpg by manufacturer")

allcarsplot <- ggplot(mpg, aes(x=hwy, y=cty, colour=manufacturer)) +
  geom_point(cex=2.5) +
  ggtitle("Highway mpg vs. City mpg by manufacturer")

#assigning variables based on categories
summary.factor(mpg$trans)
mpg$transnew <- ifelse(mpg$trans=="auto(av)", "auto",
                       ifelse(mpg$trans=="auto(l3)", "auto",
                              ifelse(mpg$trans=="auto(l4)", "auto",
                                     ifelse(mpg$trans=="auto(l5)", "auto",
                                            ifelse(mpg$trans=="auto(l6)", "auto",
                                                   ifelse(mpg$trans=="auto(s4)", "auto",
                                                          ifelse(mpg$trans=="auto(s5)", "auto",
                                                                 ifelse(mpg$trans=="auto(s6)", "auto",
                                                                        ifelse(mpg$trans=="manual(m5)", "manual",
                                                                               ifelse(mpg$trans=="manual(m6)", "manual","NA"))))))))))
summary.factor(mpg$transnew)
newvarplot <- ggplot(mpg, aes(x=hwy, y=cty, color=transnew)) + geom_point(shape=1) +
  scale_colour_hue(l=50) + # Use a slightly darker palette than normal
  geom_smooth(method=lm,   # Add linear regression lines
              se=FALSE,    # Don't add shaded confidence region
              fullrange=TRUE) + # Extend regression lines
  ggtitle("Highway mpg vs. City mpg by Transmission type")

#many plots on one page
#make multiple plots
install.packages("Rmisc")
library(Rmisc)
multiplot(newvarplot, allcarsplot, manualplot, toydodgplot2, cols=2)

################################################################################
#    Roll a dice!
################################################################################

# function to generate dice throws
des <- function(time) {
  # this is the theoretical distributions of the resulting values, there is
  # one chance out of 36 to get 2, 2 chance out of 36 to get 3...
  true <- c(1, 2, 3, 4, 5, 6, 5, 4, 3, 2, 1)/36
  # these are the sums of our two throws, and since we are throwing the same
  # number over and over again we have to set replace =TRUE
  res <- sample(1:6, size = time, replace = TRUE) + sample(1:6, size = time, 
                                                           replace = TRUE)
  # a resulting data frame for later use, when time is low there is some
  # chance that we will not get all numbers between 2 and 12, therefore the
  # specification of the Value and Exp column is not that straightforward
  out <- data.frame(Value = c(unique(res)[order(unique(res))], 2:12), 
                    Res = c(table(res)/time,true), 
                    Exp = c(rep("Observed", length(unique(res))), 
                            rep("Theoretical", 11)))
  # plotting
  print(ggplot(out, aes(x = Value, y = Res, fill = Exp)) + 
          geom_histogram(stat = "identity",
                         position = "dodge") + 
          scale_x_discrete(breaks = c(2:12)))
}
des(10)