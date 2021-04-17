setwd("C:/Users/rodriguezm.150/Documents/R")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI$Pollutant <- as.factor(NEI$Pollutant)
NEI$year <- as.factor(NEI$year)

maryland <- subset(x = NEI,subset = NEI$fips=="24510")

ma_years <- maryland$year
ma_pm2.5 <- maryland$Emissions

means_ma <- tapply(ma_pm2.5,ma_years,mean)

plot(x = names(means_ma),y = means_ma,type="l",pch=20,xlab = "Year",
     
     ylab = "PM2.5 emissions",main = "Total PM2.5 emissions pey Year in Maryland, US")

dev.copy(device = png, filename="plot2.png",width=580,height=480)
dev.off()