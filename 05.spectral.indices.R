# Vegetation indices
library(imageRy)
library(terra)

# list the data of the imageRy package
im.list()
#we choose and import the 2019 matogrosso image
m1992 <- im.import("matogrosso_l5_1992219_lrg.jpg")   
#use the bands: 1=NIR, 2=RED, 3=GREEN
im.plotRGB(m1992, r=1, g=2, b=3) #the forest is represented in red, because the color red depicts the NIR reflectance
#shortcut code
im.plotRGB(m1992, 1, 2, 3)
#let's switch the bands
im.plotRGB(m1992, r=2, g=1, b=3) #the forest is represented in green and the soil in purple
im.plotRGB(m1992, r=2, g=3, b=1) #the forest is represented in blue and the soil in yellow

# Now we will import the other image of matogrosso, which is more recent (2006)
m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg")
#plot the image, showing the red color as the wavelength corresponding the red light, 
# green as the wavelength corresponding the green light, 
# and blue as the wavelength corresponding the NIR light
im.plotRGB(m2006, r=2, g=3, b=1) #the forest is in blue, and the bare soil in yellow

# build a multiframe comparing the 1992 and 2006 images
par(mfrow=c(1,2))
im.plotRGB(m1992, r=2, g=3, b=1)
im.plotRGB(m2006, r=2, g=3, b=1)
#as we see, a drastic reduction in the forest coverage happened

#DVI = NIR - RED
# DVI used to monitor the state of vegetation 
# trees absorb most of the red wavelength, so a forestry zone has a low RED and an high NIR, thus an high DVI 

#calculate DVI for the 1992 image, considering that "1" corresponds to the NIR wavelength and "2" corresponds to the red wavelength 
dvi1992 = m1992[[1]] - m1992[[2]] #double square bracket because we are selecting an image
plot(dvi1992)
#create a vector of colors
cl <- colorRampPalette(c("lightyellow", "yellow", "red", "black")) (100)
plot(dvi1992, col=cl) 
#where is darker, DVI is higher and the forest is healthier 

#Exercise: calculate dvi for 2006 image
dvi2006 = m2006[[1]] - m2006[[2]]
plot(dvi2006, col=cl)

#NDVI for 1992 image
ndvi1992 = (m1992[[1]] - m1992[[2]]) / (m1992[[1]] + m1992[[2]])
# or 
ndvi1992 = dvi1992 / (m1992[[1]] + m1992[[2]])
plot(ndvi1992, col=cl)

#NDVI for 2006 image
ndvi2006 = dvi2006 / (m2006[[1]] + m2006[[2]])
plot(ndvi2006, col=cl)

#create a multiframe to compare the two ndvi images together
par(mfrow=c(1,2))
plot(ndvi1992, col=cl)
plot(ndvi2006, col=cl)

#create another multiframe using a different vector of colors to better visualize the degradation
clvir <- colorRampPalette(c("violet", "darkblue", "blue", "green", "yellow"))(100) # specifying a color scheme
par(mfrow=c(1,2))
plot(ndvi1992, col=clvir)
plot(ndvi2006, col=clvir)

#Speeding up calculations
ndvi2006a <- im.ndvi(m2006, 1, 2)
plot(ndvi2006a, col=cl)
