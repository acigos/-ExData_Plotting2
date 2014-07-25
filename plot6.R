rm(list = ls())
#Open sources

SCC <-readRDS("Source_Classification_Code.rds")
SCC_pm25 <-readRDS("summarySCC_PM25.rds")


#Question 6
#Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle
#sources in Los Angeles Country, California ( fips == "06037" ). Which city has seen greater
#changes over time in motor vehicle emissions?

# Get Baltimore and Los Angeles emissions from motor vehicle sources
Balt_city<- SCC_pm25[SCC_pm25$fips == "24510", ] # 2096 obs of 6 variables
Calif_city<- SCC_pm25[SCC_pm25$fips == "06037",] #9320 obs of 6 variables

# Create a df 
df<- rbind(Balt_city, Calif_city) #11,416 obs of 6 variables 
colnames(df) <- c("City", "SCC", "Pollutant", "Emissions", "type","year")

g<- grep("Mobile - On-Road", SCC$EI.Sector, ignore.case = T) #int [1:1,138]
f<- SCC[g, ]

calif_balt<- subset(df, SCC %in% f$SCC) # 2099 obs of 6 variables

cb_agg<- aggregate(Emissions ~ City + year, data = calif_balt, sum) #8 obs of 3 variables
cb_agg<- transform(cb_agg, City = factor(City))
levels(cb_agg$City) <- c("Los Angeles, CA", "Baltimore City")

#plot
library(ggplot2)
png("plot6.png",
    width = 702, height = 419, 
    units = "px")
ggplot(cb_agg, aes(x = factor(year), Emissions)) + 
        geom_point(aes(color = City), size = 4, alpha = 1/2) + 
        theme_linedraw() +
        labs(title = expression( PM[2.5] *" emissions from motor vehicle in Baltimore and Los Angeles")) +
        labs(x = "year", y = expression("Total emissions  " * PM[2.5] * " (tons)") )
dev.off()

       