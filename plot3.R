rm(list = ls())
#Open sources

SCC <-readRDS("Source_Classification_Code.rds")
SCC_pm25 <-readRDS("summarySCC_PM25.rds")

#Question 3
#Of the four types of sources indicated by the  type  (point, nonpoint, onroad, nonroad) variable, which
#of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which
#have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot
#answer this question.
Baltimore<- SCC_pm25[SCC_pm25$fips == "24510", ] # 2096 obs, 6 variables. Emissions Median 0.600, Mean 5.0962, Max 1043.6100
Baltimore_agg<- aggregate(Emissions ~ year + type, data = Baltimore, sum) #16 obs, 3 variables
Baltimore_agg <- transform(Baltimore_agg, year = factor(year))

#plot
library(ggplot2)
png("plot3.png",
    width = 702, height = 419, 
    units = "px")
qplot(year, Emissions, data = Baltimore_agg,
      main = "PM 2.5 emissions in Baltimore City by type of source",
      xlab = "Year",
      ylab = expression("Emissions  " * PM[2.5] *" in tons"),
      facets = .~type)
dev.off()