#Code related to population ecology

#installing spatstat package
install.packages("spatstat")
#It's a software for point pattern analysis

#Code bei in the spatstat package
bei

#Plot bei
plot(bei)

#changing the dimensions of the points - cex
plot(bei, cex=.2)

#changing the symbol for the points - pch
plot(bei, cex=.2, pch=19)

#Adding another dataset
bei.extra
plot(bei.extra)

#Using only part of the dataset - $
bei.extra$elev
elevation <- bei.extra$elev
plot(elevation)

bei.extra[[1]]

#Passing from points to a countinuous space - density
densitymap <- density(bei)
plot(densitymap)
points(bei, cex=.2)  #add points to the density map

#Setting a variation of colors for the map
cl <- colorRampPalette(c("black", "red", "orange", "yellow"))(100)        #not blue, green and red all together
plot(densitymap, col=cl)

#Changing the gradient
cl <- colorRampPalette(c("black", "red", "orange", "yellow"))(4)         #the yellow color impacts more
plot(densitymap, col=cl)

#Others colors found in Colors in R on Google
clnew <- colorRampPalette(c("dark blue", "blue", "light blue"))(100)
plot(densitymap, col=clnew)


plot(bei.extra)
elev <- bei.extra[[1]] # bei.extra$elev
plot(elev)

# multiframe
par(mfrow=c(1,2))
plot(densitymap)
plot(elev)

par(mfrow=c(2,1))
plot(densitymap)
plot(elev)

par(mfrow=c(1,3))
plot(bei)
plot(densitymap)
plot(elev)
