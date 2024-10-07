# relation among species in time
library(overlap)
#the overlap package shows the relations among species in time, giving a coefficient to the convergence of species's activities

#we'll use the data from a park in Indonesia
data(kerinci)
#head function shows the zones, the species and the time.
head(kerinci)
#summary function makes an abstract of the data
summary(kerinci)

#to selesct onlt the data about the tigers
kerinci[kerinci$Sps=="tiger",]
tiger <- kerinci[kerinci$Sps=="tiger",]

#this data works in a circular manner, so we need to convert it from linear to circular using the radiants
#in this way, we can represent the data in a day
kerinci$Time * 2 * pi
kerinci$timeRad <- kerinci$Time * 2 * pi #to add a new column in the data, called "timeRad"
head(kerinci) #it shows the addition of the new column

timetig <- kerinci$timeRad
#density is a function about kernel diversity. It shows the amount of time in a axis 
densityPlot(timetig, rug=TRUE) #rug is to obtain a smoother line

# Exercise: select only the data on macaque individuals
macaque <- kerinci[kerinci$Sps=="macaque",]
head(macaque)
timemac <- macaque$timeRad
densityPlot(timemac, rug=TRUE)

#overlap the two graphs to see the moments during the day when the two species meet
#when it happens, the macaques are in danger and the tigers wake up to hunt
overlapPlot(timetig, timemac)
