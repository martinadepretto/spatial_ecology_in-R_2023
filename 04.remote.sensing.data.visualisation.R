# RS data
#devtools consents to install packages from Github
library(devtools) # packages in R are also called libraries

# install the imageRy package from GitHub
install_github("ducciorocchini/imageRy")  # from devtools

library(imageRy)
library(terra)

# list the data of the imageRy package
im.list()

#im.import is used to import images
#we choose to import an image from the imageRy package, specifically the blue band from Sentinel-2
b2 <- im.import("sentinel.dolomites.b2.tif") 

#create a vector of colors to better visualize the image
cl <- colorRampPalette(c("black", "grey", "lightgrey")) (100)
plot(b2, col=cl)

#Do the same with the green, red and NIR bands
# import the green band from Sentinel-2 (band 3)
b3 <- im.import("sentinel.dolomites.b3.tif") 
plot(b3, col=cl)
# import the red band from Sentinel-2 (band 4)
b4 <- im.import("sentinel.dolomites.b4.tif") 
plot(b4, col=cl)
# import the NIR band from Sentinel-2 (band 8)
b8 <- im.import("sentinel.dolomites.b8.tif") 
plot(b8, col=cl)

# create a multiframe to see the images together
par(mfrow=c(2,2))
plot(b2, col=cl)
plot(b3, col=cl)
plot(b4, col=cl)
plot(b8, col=cl)

# stack the images
stacksent <- c(b2, b3, b4, b8)
dev.off() # it closes off images/graphs
plot(stacksent, col=cl)
#plot only the fourth image, representing the NIR band
plot(stacksent[[4]], col=cl)

# Exercise: plot in a multiframe the bands with different color ramps
#vector of colors for the blue band
clb <- colorRampPalette(c("darkblue", "blue", "lightblue")) (100)
#vector of colors for the green band
clg <- colorRampPalette(c("darkgreen", "green", "lightgreen")) (100)
#vector of colors for the red band 
clr <- colorRampPalette(c("darkred", "red", "pink")) (100)
#vector of colors for the NIR band
cln <- colorRampPalette(c("brown", "orange", "yellow")) (100)
#plot the grath together in a multiframe
par(mfrow=c(2,2))
plot(b2, col=clb)
plot(b3, col=clg)
plot(b4, col=clr)
plot(b8, col=cln)

# RGB space
# stacksent: 
# band2 blue element 1, stacksent[[1]] 
# band3 green element 2, stacksent[[2]]
# band4 red element 3, stacksent[[3]]
# band8 nir element 4, stacksent[[4]]
#we pair a specific wavelength to each color (red, green, blue)
#here, we pair the color red with the wavelength associated with the color red
im.plotRGB(stacksent, r=3, g=2, b=1)
#here, we pair the color red with the NIR wavelength , which is reflected better by the vegetation. Therefore, the red color represents the vegetation 
im.plotRGB(stacksent, r=4, g=3, b=2)
#here, we pair the color green with the NIR wavelength. Therefore, the green color represents the vegetation
im.plotRGB(stacksent, r=3, g=4, b=2)
#here, we pair the color blue with the NIR wavelength. Therefore, the blue color represents the vegetation
im.plotRGB(stacksent, r=3, g=2, b=4)
