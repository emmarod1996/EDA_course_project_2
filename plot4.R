
setwd("C:/Users/rodriguezm.150/Documents/R")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI$Pollutant <- as.factor(NEI$Pollutant)
NEI$year <- as.factor(NEI$year)
summary(NEI$Emissions)

library(ggplot2)

mrg_us  <- merge(NEI,SCC,by = "SCC") 

coal_match <- grepl("coal",mrg_us$Short.Name,ignore.case = TRUE)

coal_comb <- mrg_us[coal_match,]

agg_by_year <- aggregate(Emissions ~ year,coal_comb,sum)

barplot(names.arg = agg_by_year$year,height = agg_by_year$Emissions,xlab = "Year",
        ylab = expression("Total" ~Pm[2.5] ~ "Emissions (tons)"),col = agg_by_year$year)
title(expression("US ~ PM[2.5] ~ Emissions by year (tons"))

dev.copy(device = png, filename="plot4.png",width=580,height=480)
dev.off()  
