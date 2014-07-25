
rm(list = ls())

# Download Data (https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip)
# and unzip it.

#Open sources
SCC <-readRDS("Source_Classification_Code.rds")
SCC_pm25 <-readRDS("summarySCC_PM25.rds")

#Question 1
#Have total emissions from PM 2.5  decreased in the United States from 1999 to 2008? Using the base
#plotting system, make a plot showing the total PM 2.5  emission from all sources for each of the years
#1999, 2002, 2005, and 2008.

a<- aggregate(Emissions ~ year, data = SCC_pm25, sum) # 4 obs, 2 variables
a <- transform(a, year = factor(year))

#plot

png("plot1.png",
    width = 702, height = 419, 
    units = "px")
barplot(a$Emissions/1000000, 
        main = expression("Total emission " * PM[2.5] * " in United States"),
        ylab = expression("Emissions  " * PM[2.5] *" in tons"),
        names.arg = c("1999", "2002", "2005", "2008"))
dev.off()