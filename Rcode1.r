# This is a R tutorial for STAT 675 Spring 2011, University of Arizona.
# Section One.
# Note that "air" refer to the reference "An Introdunction to R"
################################################################################
#         R as a Calculator
################################################################################
1 + 1              # Simple Arithmetic

2 + 3 * 4 / 2 - 1  # Operator precedence

3 ^ 2              # Exponentiation

exp(1)             # Basic mathematical functions are available

log(1)

sqrt(10)

pi                  # The constant pi is predefined

(1+2i)*(1-2i)       # complex numbers

################################################################################
#       set values for variables   <- or =
################################################################################
x <- 1

y = 3               # use "<-" or "=" operator to set values

z = 4; w = 5        # use ";" or "enter" to separate two commands

x * y * z / w

X * Y * Z           # Variable names are case sensitive

This.Year <- 2011   # Variable names can include period
This.Year

SimulationTimes = 1000
SimulationTImes

################################################################################
#       vectors
################################################################################
rep(1,10)            # repeats the number 1, 10 times

seq(2,6)             # sequence of integers between 2 and 6
2:6                  # an equavalent way      or c(1:6)
seq(4,20,by=4)       # Arithmetic sequence: Every 4th integer between 4 and 20

x <- c(2,0,1,1)      # Creates vector with elements 2,0,1,1
y <- c(1,9,9,9)      # c is concatenation operator
x + y                # Sums elements of two vectors
x * y                # multiplication pointwise
x * 4                # Multiply a scalar

sqrt(x)              # Function applies to each element
exp(x)
x^2

################################################################################
#       Accessing Vector Elements
################################################################################
x <- c(2,0,1,1)
x[1]                 # Select the first element

x[-1]                # Exclude the first element

x[1] <- 3 ; x

x[-1] = 5 ; x

x < 4                 # Compares each element, returns result (TURE or FALSE) as vector

x[4] = 1; x < 4

x[x<4] = 0; x         # Edits elements marked as TRUE in index vector

x[1:3]                # first 3 elements

y = c(2,4); x[y]      # 2nd and 4th elements

################################################################################
#       matrix  operation I   (of vectors)
################################################################################
x = 1:10; y = 10:1
x
y
c(x,y)                  # concatenation

sum(x * y)              # sum of all elements in a vector (inner product)
x %*% y                 # inner product

t(x) %*% y
x %*% t(y)              # R does not distinguish row and column vectors, it will automatically
                        # find the correct way to matrix multiplication. However, it is safe way
length(x)               # to consider all vectors as columns ones, use transpose operator when needed.

dim(x %*% t(y))

################################################################################
#       matrix  operation II
################################################################################

x = matrix(1:20,nrow=4)
x

y = matrix(1:20,nrow=4,byrow=TRUE)
y
y[1:2,2:4]

x * y               # element-wise multiplication
x %*% y             # dimensions do not match

t(x) %*% y
y %*% t(y)

matrix(1:10,4,5)

################################################################################
#       matrix  operation III
################################################################################
diag(2,4)

x = diag(2,3)
solve(x)             # inverse matrix

y = 1:5
z = diag(1,5)
cbind(y,z)           # conbine by column
rbind(y,z)           # conbine by row
                     # see air 5.7 for more operations related to matrix (eigenvalue/vector,singular value decomposition, etc)
                     # see air ch 5 for array()
################################################################################
#       strings
################################################################################
x = "string"
y = 'another string'
paste(x,y)
paste(x,y,sep="")
paste(x,y,sep=",")

substr("abcdef",2,4)
substring("abcdef",1:6,1:6)  # works for vectors use ?substring for more details

################################################################################
#       use help "?"
################################################################################
?matrix               # help for a function   ? is equivalent to help()
?"%%"

?Syntax               # help for a family of functions
?Arithmetic
?Logic
?Comparison
?Extract
?Control

# OR, you may simply use google! try to google "set operations in r".

################################################################################
#      control statement     (R is more than a calculator)
################################################################################
# if (S1) S2 else S3
x = 5
if (x %% 2 == 0) print("x is an even number") else print("x is an odd number")

# for ( in )                  # loop
Sum  = 0
Prod = 1
for (i in 1:10) {
  Sum  = Sum + i
  Prod = Prod * i            # "break" or "next" may useful
}
Sum
Prod

sum(1:10)                   # avoid loops when possible
prod(1:10)
factorial(10)

# while (S1) S2             # while S1 is false, repeatedly evaluate S2
Sum = 0; i = 1
while (Sum<100) {Sum = Sum + i; i = i + 1}
Sum
i
################################################################################
#   Statistics I
################################################################################
x = rnorm(100)            # general 100 i.i.d standard normal variables
                          #  (or one multivariate normal vector)
x                         # random numbers from many other distributions can be
                          # generated directly in R, see Page 33 of air.
mean(x)                   # use ?rnorm to see more details
sd(x)
median(x)
var(x)

x = matrix(rnorm(20),ncol=2)
var(x)                     # variance-covariance matrix
cov(x)
cov(x,x)
################################################################################
#    Statistics II         a toy simulation
################################################################################
# random numbers
set.seed(2011)              # to make the simulation result repeatable
M1   = NULL
M2   = NULL
simT = 100
for (i in 1:simT){
   vec = rnorm(10)
   M1  = c(M1,mean(vec))
   M2  = c(M2,median(vec))
}

sum(M1^2)/sum(M2^2)          # relative efficiency

# random sample
sample(1:10, size=10, replace = FALSE)
sample(1:10, size=10, replace = TRUE)           # useful in bootstrap
################################################################################
#    list
################################################################################
x = rnorm(1)
y = rnorm(10)
z = matrix(rnorm(25),nrow=5,ncol=5)
w = list(x=x,y=y,z=z)                  # list

w

w$x
w$y
w$z

w[[1]]                                # same as w$x, the 1st object in the list
w[1]                                  # is a sublist of w with only one object
                                      # see air ch6 for more details on the list
################################################################################
#
################################################################################
x = "aaa"
is.numeric(x)

x = 1:10
is.numeric(x)
is.vector(x)
is.matrix(x)
is.matrix(t(x))

y = x %*% x
is.numeric(y)
is.vector(y)
is.matrix(y)

x > 5                     # compare a vector with a number
x > y                     # can not compare a vector with a matrix (even 1 by 1 matrix)
x > as.numeric(y)
x > as.vector(y)


