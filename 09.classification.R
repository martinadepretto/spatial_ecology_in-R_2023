# Classifying satellite images and estimate the amount of change through time

library(terra)
library(imageRy)
library(ggplot2)
library(patchwork)

#to see the data contained in the packages, we can use the function im.list
im.list()

#use the link below to download an image of the sun from ESA
# https://www.esa.int/ESA_Multimedia/Images/2020/07/Solar_Orbiter_s_first_views_of_the_Sun6

#we import the image in R
sun <- im.import("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")
#yellow color highlights high energy from the sun, instead black color highlights low energy
# there are 3 levels: yellow, dark yellow and black; 3 levels = 3 clusters

#we classify the image by clusters using the function classify
sunc <- im.classify(sun, num_clusters=3)
#we obtain a map of the three clusters that differentiate the 3 classes of energy;
# a random set of pixels is used to assign each class
plot(sunc)


#Classify satellite data
im.list()
#import the images of Matogrosso's forest from the imageRy package
m1992 <- im.import("matogrosso_l5_1992219_lrg.jpg")
m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg")
plotRGB(m1992)
#the red color represents vegetation, the rest is bare soil or water == 2 clusters

#classify the two images by clusters
# 1992
m1992c <- im.classify(m1992, num_clusters=2)                    
plot(m1992c)
#we have created two classes: forest=1; human=2
# 2006
m2006c <- im.classify(m2006, num_clusters=2)
plot(m2006c)
#visualize both maps one beside the other
par(mfrow=c(1,2))
plot(m1992c[[1]])
plot(m2006c[[1]])

#use freq function to obtain the frequency of the pixels in the same class,
# to understand how many pixels are related to forest and how many to human activities
#first, in the 1992 image: 
f1992 <- freq(m1992c)
f1992
#304437 pixels are related to human activities, 1495563 are related to the forest
#BUT how are the percentages?
# we can calculate the total number of pixels in the image by the function ncell
tot1992 <- ncell(m1992c)
tot1992
# we multiply the freq of one class by 100, and divide the result by the total number 
#  of pixels in the image, to obtain the percentages of the two classes
p1992 <- f1992 * 100 / tot1992 
p1992
#the percentages obtained are: forest = 83%; human = 17%

#we repeat the same procedure for the 2006 image:
f2006 <- freq(m2006c)
f2006
#3937996 pixels are related to human activities, 3262004 are related to the forest
#calculate the total number of pixels in the 2006 image
tot2006 <- ncell(m2006c)
tot2006
#calculate the percentages of the two classes
p2006 <- f2006 * 100 / tot2006 
p2006
#the percentages obtained are: forest = 45%; human = 55%

#build a table to summarize it
# classes, year 1992 and year 2006 will be the three columns of the table
class <- c("forest", "human")
y1992 <- c(83, 17)
y2006 <- c(45, 55) 
#create the data frame using the vectors just generated
tabout <- data.frame(class, y1992, y2006)
tabout

#create a graph for each year, using ggplot2 and patchwork packages
p1 <- ggplot(tabout, aes(x=class, y=y1992, color=class)) + geom_bar(stat="identity", fill="white")
p1
p2 <- ggplot(tabout, aes(x=class, y=y2006, color=class)) + geom_bar(stat="identity", fill="white")
p2
#represent them together
p1 + p2
#they have different scales

#set the same limit for the y axis for both graphs, to make a better confrontation
p1 <- ggplot(tabout, aes(x=class, y=y1992, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p1
p2 <- ggplot(tabout, aes(x=class, y=y2006, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p2
#now that they have the same scale, we represent them together
p1 + p2
