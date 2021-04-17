
setwd("C:/Users/rodriguezm.150/Documents/R")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI$Pollutant <- as.factor(NEI$Pollutant)
NEI$year <- as.factor(NEI$year)
summary(NEI$Emissions)

library(ggplot2)
library(dplyr)

maryland_comp <- subset(x = NEI,subset = NEI$fips=="24510" & NEI$type =="ON-ROAD")
lasang_comp <- subset(x = NEI,subset = NEI$fips=="06037" & NEI$type =="ON-ROAD")

marycomp_by_year <- maryland_comp %>%
  select(year,Emissions) %>%
  group_by(year) %>%
  summarise_each(funs(sum))

losangcomp_by_year <- lasang_comp %>%
  select(year,Emissions) %>%
  group_by(year) %>%
  summarise_each(funs(sum))

marycomp_by_year$city <- "Baltimore City, MD"
losangcomp_by_year$city <- "Los Angeles, CA"

bothcomp <- rbind(marycomp_by_year,losangcomp_by_year)

ggplot(bothcomp, aes(x=factor(year), y=Emissions,fill=city, label = round(Emissions,2))) +
  geom_bar(stat="identity") +
  facet_grid(city~.,scales = "free")+
  xlab("year") +
  ylab(expression("total PM"[2.5]*" emissions in tons")) +
  ggtitle("Emissions from motor vehicle sources in Baltimore City and Los Angeles")+
  geom_label(aes(fill = city),colour = "white", fontface = "bold")

dev.copy(device = png, filename="plot6.png",width=580,height=480)
dev.off()
