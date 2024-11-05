#PCA, multivariate analysis

#we need these packages for the lesson
library(imageRy)
library(terra)
library(viridis)

#to see the data contained in the packages, we can use the function im.list
im.list()
#we're going to work again on the image "sentinel.png", contained in the the imageRy package 
sent <- im.import("sentinel.png")

#to see how much the bands are correlated to each other, we use the function pairs
pairs(sent)
#the correlation between sentinel_2 (red) and sentinel_3 (green) is high = 0.98

#perform PCA on sent
sentpc <- im.pca(sent)
#we select the principal component (pc1), that represents 77% of the variability.
pc1 <- sentpc$PC1
#it is possible to do calculations regarding the variability of the data using the pc1
# (this time the calculations are based not only on one band but on all of them, so they're more objective)

#create a new set of colors and plot the pc1
viridisc <- colorRampPalette(viridis(7))(255)
plot(pc1, col=viridisc)

#calculating standard deviation on top of pc1
# using a 3x3 moving window
pc1sd3 <- focal(pc1, matrix(1/9, 3, 3), fun=sd)
plot(pc1sd3, col=viridisc)
#the focal function can be used to calculate other function
# using a 7x7 moving window
pc1sd7 <- focal(pc1, matrix(1/49, 7, 7), fun=sd)
plot(pc1sd7, col=viridisc)

#we plot the original RGB image, the standard deviation from a 3x3 moving window in the NIR, 
# the standard deviation from a 7x7 moving window in the NIR,
# the standard deviation from a 3x3 moving window in the pc1,
# the standard deviation from a 7x7 moving window in the pc1, all together
par(mfrow=c(2,3))
im.plotRGB(sent, 2, 1, 3)
plot(sd3, col=viridisc)
plot(sd7, col=viridisc)
plot(pc1, col=viridisc)
plot(pc1sd3, col=viridisc)
plot(pc1sd7, col=viridisc)

#Alternative way
#stack all the standard deviation layers 
sdstack <- c(sd3, sd7, pc1sd3, pc1sd7)
#name them
names(sdstack) <- c("sd3", "sd7", "pc1sd3", "pc1sd7")
#plot them all together
plot(sdstack, col=viridisc)
