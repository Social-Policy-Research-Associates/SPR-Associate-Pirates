#URJ 6Point Sci/Tech
#R Day 1
#Script by Joshua Mallett
#6/16/2018

################################################################################
#    DATA! Working directories
################################################################################

getwd()

setwd("C:/Users/humoroussmile/Desktop/URJ")     # set working directory

################################################################################
#    Flip a coin!
################################################################################

#probability of flipping a head/tail is 50% (or 0.5)
coin <- c(1,2) #if we get a 1, then it's heads, if we get a 2, then it's tails
omega <- 0.5 #probability 50%
N <- 100 #number of times we flip the coin

flip <- sample(coin,
               size = N,
               replace = TRUE,
               prob = c(omega, 1 - omega))

hist(flip,breaks=2, col="darkred",main="Distribution of Coin Flips")

################################################################################
#    Create our own data!
#    Measure: height, age, hair color, name, grade in school, gender
################################################################################

name <- c('Josh','Rachel','Michael')
grade <- c(5, 6, 7)
gender <- c('male', 'female', 'male')
height <- c(50, 60, 70)
age <- c(10, 11, 12)
hair <- c('red','brown','brown')

chugclass <- data.frame(name, grade, gender, height, age, hair, stringsAsFactors = FALSE)
dim(chugclass)
head(chugclass)
summary(chugclass)
summary.factor(chugclass$hair)