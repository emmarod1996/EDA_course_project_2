#setting the r directory
setwd("C:/Users/rodriguezm.150/Documents/R")

#reading the databases
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#changing to factor the variables
NEI$Pollutant <- as.factor(NEI$Pollutant)
NEI$year <- as.factor(NEI$year)
summary(NEI$Emissions)

#getting the two vectors, year and pm2.5
years <- NEI$year
pm2.5 <- NEI$Emissions

#getting the mean
means_em <- tapply(pm2.5,years,mean)


plot(x = names(means_em),y = means_em,type="l",pch=20,xlab = "Year",
     
     ylab = "PM2.5 emissions",main = "Total PM2.5 emissions pey Year")

dev.copy(device = png, filename="plot1.png",width=580,height=480)
dev.off()

