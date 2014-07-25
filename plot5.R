rm(list = ls())
#Open sources

SCC <-readRDS("Source_Classification_Code.rds")
SCC_pm25 <-readRDS("summarySCC_PM25.rds")


#Question 5
#How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
m<- grep("Mobile - On-Road", SCC$EI.Sector, ignore.case = T) #int [1:1,138]
l<- SCC[m,] #1,138 obs of 15 variables
motor_sub <- subset(SCC_pm25, SCC %in% l$SCC) #3,183,602 obs of 6 variables
motor_agg<- aggregate(Emissions ~ year, data = motor_sub, sum)

#plot

png("plot5.png",
    width = 702, height = 419, 
    units = "px")
barplot(motor_agg$Emissions/1000,
        main = "Total emission of PM2.5 from motor vihicle in US",
        names.arg = c("1999", "2002", "2005", "2008"),
        ylab = expression("Emissions  " * PM[2.5] *" in tons"))
dev.off()