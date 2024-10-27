#External data

#use terra package to bring the image
library(terra)

#We download the image of Najaf sea from NASA Earth Observatory
#Set the working directory based on your path to be able to import the image in R,
# with the "" because it's external to R
setwd("/Users/marti/OneDrive/Desktop")
#use rast function because the image is a raster
naja <- rast("naja2003.jpg")
#plot the image using the RGB model
plotRGB(naja, r=1, g=2, b=3) 

#Exercise: Download the second image from the same site and import it in R
# we don't need to reset the working directory now
najaaug <- rast("naja2023.jpg")
plotRGB(najaaug, r=1, g=2, b=3)

#plot both images together
par(mfrow=c(2,1))
plotRGB(naja, r=1, g=2, b=3)
plotRGB(najaaug, r=1, g=2, b=3)

#Multitemporal change detection
najadif = naja[[1]] - najaaug[[1]] 
cl <- colorRampPalette(c("brown", "grey", "orange")) (100)
plot(najadif, col=cl)
#highest difference between the two is highlighted in orange

#Download an image about typhoon Mawar from Earth Observatory
typhoon <- rast("typhoon.jpg")
#plot it with different colors
plotRGB(typhoon, r=1, g=2, b=3)
plotRGB(typhoon, r=2, g=1, b=3)
plotRGB(typhoon, r=3, g=2, b=1)

# The Mato Grosso image can be downloaded directly from EO-NASA
mato <- rast("matogrosso1992.jpg")
plotRGB(mato, r=1, g=2, b=3) #the red color represents the red band
plotRGB(mato, r=2, g=1, b=3) #the green color represents the red band
