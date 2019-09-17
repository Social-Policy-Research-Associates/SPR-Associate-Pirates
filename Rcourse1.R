#URJ 6Point Sci/Tech
#R Day 1
#Script by Joshua Mallett
#6/4/2018

########################################################
#Let's write stuff!
########################################################
print("Hello World!")

########################################################
#Calculator!
########################################################

#add and subtract
1+1

10-2

#multiply and divide
10*11

2562/4

#order of operations
2*2+4/3-1

#exponents
10^2

#special numbers
pi

#math functions
sqrt(10000)

########################################################
#Variables!
########################################################

#assign values
x <- 2

y = 4

z = 10; m <- 200

#use our variables
x*m-z*y

#case
X+y-M

#variable names
my.variable <- 2018
my.variable

last.year <- 2017
Last.Year

########################################################
#Proportions/Percentages
########################################################

prop <- 1/2
percent <- prop*100

prop
print("prop is a proportion")

percent
print("percent is a percentage format")

50*prop

########################################################
#HELP!
########################################################

#how to activate help
?
help()

#help examples
?plot
?pi

########################################################
#Advanced Calculator
########################################################

#let's make conditional statements!
x=4
if (x %% 2 == 0) print("x is an even number") else print("x is an odd number")

#loops
Sum = 0
Product = 1
for (i in 1:10) {
  Sum = Sum + i
  Product = Product * i
}
Sum
Product

#while statements
Sum = 0; i = 1
while (Sum<200) {Sum = Sum + i; i = i + 1}
Sum
i

########################################################
#Statistics!
########################################################

#mean, median, mode, standard deviation
?rnorm
x = rnorm(10000)

mean(x)
median(x)
sd(x)
summary(x)

################################################################################
#    Create your own functions!
################################################################################
# square function
square = function(x = 1) return(x*x)
square()                      # use default value
square(5)

################################################################################
#    What variables have I created?
################################################################################
x = 5
ls()                             # see all objects
rm(x)                            # remove x

################################################################################
#    Generate random numbers
################################################################################

#UNIFORM DISTRIBUTIONS
runif(1)
# Get a vector of 4 numbers
runif(4)
# Get a vector of 3 numbers from 0 to 100
runif(3, min=0, max=100)
# Get 3 integers from 0 to 100
# Use max=101 because it will never actually equal 101
floor(runif(3, min=0, max=101))
# This will do the same thing
sample(1:100, 3, replace=TRUE)
# To generate integers WITHOUT replacement:
sample(1:100, 3, replace=FALSE)

#NORMAL DISTRIBUTIONS
rnorm(4)
# Use a different mean and standard deviation
rnorm(4, mean=50, sd=10)
# To check that the distribution looks right, make a histogram of the numbers
x <- rnorm(400, mean=50, sd=10)
hist(x)