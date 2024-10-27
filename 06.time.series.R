#Time series analysis: data that are taken during a period of time
library(imageRy)
library(terra)

im.list()

#we're going to use the first and the last EN (EN01 and EN13)
# import the data
EN01 <- im.import("EN_01.png") #from January 2020
EN13 <- im.import("EN_13.png") #from March 2020

#let's represent the two images together, plotting them automatically with the RGB model
par(mfrow=c(2,1))
im.plotRGB.auto(EN01)
im.plotRGB.auto(EN13)

#see the difference regarding the first band between the first and second images
dif = EN01[[1]] - EN13[[1]]
plot(dif)

#create a new vector of colors and plot the difference
cldif <- colorRampPalette(c("blue", "white", "red")) (100)
plot(dif, col=cldif)
#it is represented in red the values that are higher in January, 
# and in blue the values that are higher in March; 
# so, in red we can see the factories that stopped working in March 


#We're now going to use an image from Copernico site, 
# which contains many data about vegetation, water and ice
#Example: Temperature in Greenland
# import an image of Greenland in year 2000 from the imageRy packet
g2000 <- im.import("greenland.2000.tif")
clg <- colorRampPalette(c("black", "blue", "white", "red")) (100)
plot(g2000, col=clg)
#the blue color represents a zone with very low temperatures (the internal part)

#now, we're going to import the other images of Greenland in the years 2005, 2010, 2015
g2005 <- im.import("greenland.2005.tif")
g2010 <- im.import("greenland.2010.tif")
g2015 <- im.import("greenland.2015.tif")
#plot the image from 2015 with the clg colors
plot(g2015, col=clg)

#compare the image from 2000 to the image from 2015 
par(mfrow=c(1,2))
plot(g2000, col=clg)
plot(g2015, col=clg)

#stack the data to plot the images all together by creating an array with the c() function
stackg <- c(g2000, g2005, g2010, g2015)
plot(stackg, col=clg)

#Exercise: see the difference between the first (2000) and the final (2015) elements of the stack
difg <- stackg[[1]] - stackg[[4]]
# or we could use: difg <- g2000 - g2015
plot(difg, col=cldif)

#Exercise: make a RGB plot using different years
#we put the first image (2000) in the red band, the second image (2005) in the green band,
# and the last image (2015) in the blue band
im.plotRGB(stackg, r=1, g=2, b=3)
#the external part shows temperature values that are higher in 2005, 
# instead the internal part shows temperature values that are higher in 2015
