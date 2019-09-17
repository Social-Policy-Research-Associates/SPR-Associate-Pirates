# This is a R tutorial for STAT 675 Spring 2011, the University of Arizona.
# Section Two.
################################################################################
#    functions in R
################################################################################
# square function
square = function(x = 1) return(x*x)
square()                      # use default value
square(5)

# distribution of extreme values
maxx  = function(n = 10, simT = 20, distr = rnorm) {
        maxValue   = NULL
        for (i in 1:simT) {
            z        = distr(n)
            maxValue = c(maxValue,max(z))
        }
        return(list(maxValue = maxValue, mean = mean(maxValue),
                        median = median(maxValue)))
}

maxx()                      # use default value

maxx1 = maxx(n=20, simT = 1000, distr = runif)
maxx1$mean
hist(maxx1[[1]])            # histogram

args(maxx)                  # print arguments in a function
maxx                        # print contents of a function

################################################################################
#    workspace and working directory
################################################################################
x = 5
ls()                             # see all objects
rm(x)                            # remove x

getwd()

setwd("C:/Ning Hao/Teaching/STAT675Spring2011/Rcode")     # set working directory

################################################################################
#    save and load
################################################################################

x = 1:100
save(x,file="x.Rdata")
x = matrix(1,3,4)
x
load("x.Rdata")
x
################################################################################
#    read.table
################################################################################

x=read.table('IRISES.DAT')    # data frame
x

as.matrix(x)                  # convert data frame to matrix

as.matrix(x)[1:10,]

################################################################################
#    Graphics in R
################################################################################
# some fancy graphs
# 1     3D graph
x <- seq(-10, 10, length = 50)
y <- x
rotsinc <- function(x,y)
{
    sinc <- function(x) { y <- sin(x)/x ; y[is.na(y)] <- 1; y }
    10 * sinc( sqrt(x^2+y^2) )
}
sinc.exp <- expression(z == Sinc(sqrt(x^2 + y^2)))

z <- outer(x, y, rotsinc)

par(bg = "white",mfrow=c(1,2),mar=rep(1.5,4))
persp(x, y, z, theta = 30, phi = 30, expand = 0.5, col = "lightblue")
title(sub=".")## work around persp+plotmath bug
title(main = sinc.exp)

persp(x, y, z, theta = 30, phi = 30, expand = 0.5, col = "lightblue",
      ltheta = 120, shade = 0.75, ticktype = "detailed",
      xlab = "X", ylab = "Y", zlab = "Z")
title(sub=".")## work around persp+plotmath bug
title(main = sinc.exp)

# 2    Scatterplot with marginal histograms
def.par <- par(no.readonly = TRUE) # save default, for resetting...

x <- pmin(3, pmax(-3, rnorm(50)))
y <- pmin(3, pmax(-3, rnorm(50)))
xhist <- hist(x, breaks=seq(-3,3,0.5), plot=FALSE)
yhist <- hist(y, breaks=seq(-3,3,0.5), plot=FALSE)
top <- max(c(xhist$counts, yhist$counts))
xrange <- c(-3,3)
yrange <- c(-3,3)
nf <- layout(matrix(c(2,0,1,3),2,2,byrow=TRUE), c(3,1), c(1,3), TRUE)
#layout.show(nf)

par(mar=c(3,3,1,1))
plot(x, y, xlim=xrange, ylim=yrange, xlab="", ylab="")
par(mar=c(0,3,1,1))
barplot(xhist$counts, axes=FALSE, ylim=c(0, top), space=0)
par(mar=c(3,0,1,1))
barplot(yhist$counts, axes=FALSE, xlim=c(0, top), space=0, horiz=TRUE)

par(def.par)

# See more on http://addictedtor.free.fr/graphiques
# Let us start from the fundamental ones
# The reference is An introduction to R Chapter 12.
################################################################################
#    Graphics in R        plot()
################################################################################
par(mfrow=c(1,2))
x = (1:200)/100
plot(x,sin(pi*x))
plot(x,sin(pi*x),type="l",col="blue",xlab="x",ylab="sin(x)",main="sin function")

################################################################################
#    Graphics in R        hist() and qqnorm()
################################################################################
par(mfrow=c(1,2))
x = rnorm(10000)
hist(x);hist(x,breaks=100)

qqnorm(x);qqnorm(runif(10000))

#use ?hist and ?qqnorm for more examples

################################################################################
#    Graphics in R      low-level commands
################################################################################
postscript(file="tri.eps",horizontal=T,height=6)        # another way to save a graph

par(mfrow=c(1,1))
x = (1:200)/100
plot(x,sin(pi*x),type="l",ylab="y",col="red",ylim=c(-3,3))
points(x,cos(pi*x),type="l",col="blue")
lines(x,tan(pi*x),col="purple")
abline(h=0)
legend(x=1.6, y = 3, legend=c("sin(x)", "cos(x)", "tan(x)"),
    col = c("red","blue","purple"), lty=1,  cex=1)

dev.off()
#?legend for more examples
################################################################################
#    Graphics in R
################################################################################
set.seed(2011)
x=(1:1000)/100-5
plot(x,dnorm(x),type='l',lwd=2)
y=rnorm(100)
lines(density(y),lty=2, col="red",lwd=2)               #density
lines(density(rnorm(10000)),lty=2, col="blue",lwd=2)
################################################################################
#    Graphics in R       3D graph
################################################################################
### Example 4.2 (Plot bivariate normal density)

    #the standard BVN density
    f <- function(x,y) {
        z <- (1/(2*pi)) * exp(-.5 * (x^2 + y^2))
        }

    y <- x <- seq(-3, 3, length= 50)
    z <- outer(x, y, f)   #compute density for all (x,y)

    persp(x, y, z)        #the default plot

    persp(x, y, z, theta = 45, phi = 30, expand = 0.6,
          ltheta = 120, shade = 0.75, ticktype = "detailed",
          xlab = "X", ylab = "Y", zlab = "f(x, y)")

# help(persp) and demo(persp) for more examples!

################################################################################
#    Graphics in R
################################################################################
# you may run the R code for chapter 4 on the web
# http://personal.bgsu.edu/~mrizzo/SCR.htm

