
setwd("C:/Users/rodriguezm.150/Documents/R")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI$Pollutant <- as.factor(NEI$Pollutant)
NEI$year <- as.factor(NEI$year)
summary(NEI$Emissions)


library(ggplot2)
library(dplyr)

maryland_4 <- subset(x = NEI,subset = NEI$fips=="24510" & NEI$type =="ON-ROAD")

mary_by_year <- maryland_4 %>%
  select(year,Emissions) %>%
  group_by(year) %>%
  summarise_each(funs(mean))

ggplot(mary_by_year, aes(x=factor(year), y=Emissions,fill=year, label = round(Emissions,2))) +
  geom_bar(stat="identity") +
  xlab("year") +
  ylab(expression("total PM"[2.5]*" emissions in tons")) +
  ggtitle("Emissions from motor vehicle sources in Baltimore City")+
  geom_label(aes(fill = year),colour = "white", fontface = "bold")

dev.copy(device = png, filename="plot5.png",width=580,height=480)
dev.off()