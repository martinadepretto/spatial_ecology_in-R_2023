# Why populations disperse over the landscape?

#install sdm and terra
install.packages("sdm")
library(sdm)
install.packages("terra")
library(terra)

#searching a certain file on the package - system.file
file <- system.file("external/species.shp", package="sdm")

# Distribuition of rana alpina
#import points - vect
rana <- vect(file)
rana$Occurrence  #code with presences and absences

plot(rana)  #it has both presences and absences

# Selecting presences
pres <- rana[rana$Occurrence==1,]
plot(pres)

# exercise: select absence and call them abse
abse <- rana[rana$Occurrence==0,]
abse <- rana[rana$Occurence!=1,]
plot(abse)

# exrecise: plot presences and absences, one beside the other
par(mfrow=c(1,2))
plot(pres)
plot(abse)

# In case of graphical nulling:
dev.off()

# exercise: plot pres and abse altogether with two different colours
plot(pres, col="dark blue")
plot(abse, col="light blue")

# Adding points to the previous graphic
points(abse, col="light blue")

# predictors: environmental variables
# file <- system.file("external/species.shp", package="sdm")
# rana <- vect(file)

# elevation predictor
elev <- system.file("external/elevation.asc", package="sdm") 
elevmap <- rast(elev) # from terra package  # importing images - rast
plot(elevmap)
points(pres, cex=.5)

# temperature predictor
temp <- system.file("external/temperature.asc", package="sdm") 
tempmap <- rast(temp) # from terra package
plot(tempmap)
points(pres, cex=.5)

# exercise: do the same with vegetation cover
vege <- system.file("external/vegetation.asc", package="sdm") 
vegemap <- rast(vege) # from terra package
plot(vegemap)
points(pres, cex=.5)

# exercise: do the same with precipitation cover
prec <- system.file("external/precipitation.asc", package="sdm") 
precmap <- rast(prec) # from terra package
plot(precmap)
points(pres, cex=.5)

# final multiframe - par
par(mfrow=c(2,2))

# elev
plot(elevmap)
points(pres, cex=.5)

# temp
plot(tempmap)
points(pres, cex=.5)

# vege
plot(vegemap)
points(pres, cex=.5)

# prec
plot(precmap)
points(pres, cex=.5)
