#URJ 6Point Sci/Tech
#R Day 3
#Script by Joshua Mallett
#6/9/2018

################################################################################
#    DATA! Working directories
################################################################################

getwd()

setwd("C:/Users/humoroussmile/Desktop/URJ")     # set working directory


################################################################################
#    reading in datasets and plotting on a map!
################################################################################

fireball <- read.delim("C:/Users/humoroussmile/Desktop/URJ/fireball.txt")
head(fireball)
ls(fireball)
summary(fireball)
dim(fireball)

install.packages("rworldmap")
library(rworldmap)
newmap <- getMap(resolution = "low")

plot(newmap)
points(fireball$longitude,fireball$latitude, col = "red")

meteor <- read.delim("C:/Users/humoroussmile/Desktop/URJ/meteor.txt")
head(meteor)
ls(meteor)
summary(meteor)
dim(meteor)
plot(newmap)
points(meteor$reclong,meteor$reclat, col = "red")

#ggplot, alpha is plot transparency, CLEAN MAP
world_map <- map_data("world")
p <- ggplot() + coord_fixed() +
  xlab("") + ylab("")

base_world_messy <- p + geom_polygon(data=world_map, aes(x=long, y=lat, group=group), 
                                     colour="light green", fill="light green")
cleanup <- 
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), 
        panel.background = element_rect(fill = 'white', colour = 'white'), 
        axis.line = element_line(colour = "white"), legend.position="none",
        axis.ticks=element_blank(), axis.text.x=element_blank(),
        axis.text.y=element_blank())

base_world <- base_world_messy + cleanup

#now let's plot it!
base_world +
  geom_point(data=fireball, 
             aes(x=longitude, y=latitude, size=altitudekm), colour="Red", 
             fill="Pink",pch=21, alpha=I(0.7)) 

base_world +
  geom_point(data=meteor, 
             aes(x=reclong, y=reclat, colour=massgrams), alpha=I(0.7)) 

################################################################################
#    modeling
################################################################################
fit.fireball1<- lm(calculated_total_impact_energykt ~ altitudekm + 
                     Velocitykmsx + Velocitykmsy + Velocitykmsz + total_radiated_energyj,
                   data=fireball)
summary(fit.fireball1)
anova(fit.fireball1)

fit.fireball2 <- lm(calculated_total_impact_energykt ~ total_radiated_energyj,
                   data=fit.fireball1$model)
summary(fit.fireball2)
anova(fit.fireball1,fit.fireball2)

