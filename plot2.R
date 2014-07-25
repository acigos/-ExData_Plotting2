rm(list = ls())
#Open sources

SCC <-readRDS("Source_Classification_Code.rds")
SCC_pm25 <-readRDS("summarySCC_PM25.rds")

#Question 2
#Have total emissions 
#from PM 2.5  decreased in the Baltimore City, Maryland ( fips == "24510" ) from
#1999 to 2008? Use the base plotting system to make a plot answering this question.

Baltimore<- SCC_pm25[SCC_pm25$fips == "24510", ] # 2096 obs, 6 variables. Emissions Median 0.600, Mean 5.0962, Max 1043.6100
Baltimore_ag<- aggregate(Emissions ~ year, data = Baltimore, sum) # 4obs, 2 variables

#plot

png("plot2.png",
    width = 702, height = 419, 
    units = "px")
barplot(height = Baltimore_ag$Emissions, names.arg = Baltimore_ag$year,
        xlab = "Years", 
        ylab = expression("Emissions  " * PM[2.5] *" in tons"),
        main = expression("Total emissions from " * PM[2.5] *" in Baltimore City"))
dev.off()