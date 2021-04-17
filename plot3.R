
setwd("C:/Users/rodriguezm.150/Documents/R")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI$Pollutant <- as.factor(NEI$Pollutant)
NEI$year <- as.factor(NEI$year)
summary(NEI$Emissions)


library(ggplot2)
library(dplyr)

maryland_3 <- subset(x = NEI,subset = NEI$fips=="24510")

by_type <- maryland_3 %>%
  select(year,type,Emissions)%>%
  group_by(year,type) %>% 
  summarise_each(funs(mean))

qplot(x = as.numeric(as.character(year)),y = Emissions,data = by_type, color=type,geom = "line")+
  ggtitle(expression("Baltimore City" ~ PM[2.5] ~ "Emissions by Source Type and Year"))+
  xlab("Year")+ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tons)"))

dev.copy(device = png, filename="plot3.png",width=580,height=480)
dev.off()
