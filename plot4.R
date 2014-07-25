rm(list = ls())
#Open sources

SCC <-readRDS("Source_Classification_Code.rds")
SCC_pm25 <-readRDS("summarySCC_PM25.rds")



#Question 4
#Across the United States, how have emissions from coal combustion?related sources changed from
#1999–2008?
x<- grep("Coal", SCC$EI.Sector, ignore.case = T) #int [1:99]. find from SCC$EI. Sector the word Coal
y<- SCC[x,] #99 obs. of 15 variables subset from SCC what is in x

coal_sub<- subset(SCC_pm25, SCC_pm25$SCC %in% y$SCC) #28480 obs of 6 variables
coal_agg <- aggregate(Emissions ~ year, data = coal_sub, sum)

#plot

png("plot4.png",
    width = 702, height = 419, 
    units = "px")
barplot(coal_agg$Emissions/1000,
        main = "Total emission of PM2.5 from coal combustion in US",
        names.arg = c("1999", "2002", "2005", "2008"),
        ylab = expression("Emissions  " * PM[2.5] *" in tons"))
dev.off()