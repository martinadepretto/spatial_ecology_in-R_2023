#install vegan package, it deals with community
library(vegan)
#select a dataset that you want to analyze, from the vegan package
data(dune)
#or use the head function to see the first few rows of the dataset
head(dune)
#or the function tail to see the last few rows
tail(dune)

#function decorana, to see how different species are correlated <- detrended correspondance analysis
ord <- decorana(dune)

#we are interested in finding how long are the ranges in each axis
#and we can find the information in the last row of the detrended correspondence analysis
ldc1 =  3.7004 
ldc2 =  3.1166 
ldc3 = 1.30055
ldc4 = 1.47888
#sum of the axis lengths
total = ldc1 + ldc2 + ldc3 + ldc4

#calculate the percentage of each length
pldc1 = ldc1 * 100 / total
pldc2 = ldc2 * 100 / total
pldc3 = ldc3 * 100 / total
pldc4 = ldc4 * 100 / total

#we can't take all the variables, so we maintain only the first two, and use them as axis X and Y
pldc1
pldc2
pldc1 + pldc2
#we plot them to see which species interact
plot(ord)
