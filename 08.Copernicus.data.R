#use the link below to download files
# https://land.copernicus.vgt.vito.be/PDF/portal/Application.html

library(ncdf4) #you need this package because the file we downloaded is a nc file
library(terra)

#set the working directory
setwd("/Users/marti/OneDrive/Desktop") 
soilm2023 <- rast("c_gls_SSM1km_202311250000_CEURO_S1CSAR_V1.2.1.nc")
#plot the image
plot(soilm2023)

#there are two elements and we need to use only the first one for now
plot(soilm2023[[1]])
#create a vector of colors and plot the image using this vector
cl <- colorRampPalette(c("red", "orange", "yellow")) (100)
plot(soilm2023[[1]], col=cl)
#crop the stack to a certain extent (to highlight a specific place), using the crop function
ext <- c(22, 26, 55, 57) #these numbers represent in order minlong, maxlong, minlat, maxlat
soilm2023c <- crop(soilm2023, ext)
#plot the first element again, now that it has been cropped
plot(soilm2023c[[1]], col=cl)
#this process is useful with images showing burned areas; 
# indeed, those areas are usually small, so when you collect data and images,
# you need to crop them and reduce their extent

#now we're going to download the data concerning the day before the fire
#this time there's no need to set the working directory because we've already done it
soilm2023_24 <- rast("c_gls_SSM1km_202311240000_CEURO_S1CSAR_V1.2.1.nc")
#plot the image
plot(soilm2023_24)
#crop the data to the same extension as before and plot it
soilm2023_24c <- crop(soilm2023_24, ext)
plot(soilm2023_24c[[1]], col=cl)
