#Measurement of RS based variability

#we need these packages
library(imageRy)
library(terra)
library(viridis) #it's a set of colors

#to see the data contained in the packages, we can use the function im.list
im.list()
#we're going to work on the image "sentinel.png", contained in the the imageRy package 
sent <- im.import("sentinel.png")
#this file contains 3 layers:
# one that reports the band 1 representing NIR, 
# the other that reports the band 2 representing red, 
# and the last that reports the band 3 representing green

#plot the image using the RGB model
im.plotRGB(sent, r=1, g=2, b=3)
#the vegetation is in red
#plot the image using different band associations
im.plotRGB(sent, r=2, g=1, b=3)
#here the vegetation is in green

#we select the NIR layer to work on it
nir <- sent[[1]]
plot(nir)
#we're going to move around windows of 3x3 pixels to compare the standard deviations of the windows
# we use the function focal on the NIR layer and create a random matrix of 9 pixels 
sd3 <- focal(nir, matrix(1/9, 3, 3), fun=sd)
plot(sd3)
#create a new set of colors to plot the image with
viridisc <- colorRampPalette(viridis(7))(255)
plot(sd3, col=viridisc)
#higher variability in the NIR reflectance associated with an higher variability in the geomorphology

#Exercise: calculate variability in a 7x7 pixels moving window
sd7 <- focal(nir, matrix(1/49, 7, 7), fun=sd)
plot(sd7, col=viridisc)


#Exercise 2: plot via par(mfrow()) the 3x3 and the 7x7 standard deviation together
par(mfrow=c(1,2))
plot(sd3, col=viridisc)
plot(sd7, col=viridisc)
#the 3x3 window gives a local calculation of the standard deviation,
# the 7x7 window is larger and has more pixels, so it can detect more details respect to the other

#plot together the original RGB image with the 7x7 standard deviation
par(mfrow=c(1,2))
im.plotRGB(sent, r=2, g=1, b=3)
plot(sd7, col=viridisc)
#high standard deviation means that the light signal catches a multitude of information,
# meaning that an  high geological variability is present
