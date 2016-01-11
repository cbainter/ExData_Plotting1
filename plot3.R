## plot3.R
#######################################################################
## This assumes you have downloaded the data into your local directory
## and unarchived it.

## read data in - leave data and time fields as characters and
## adjust once we load and filter data
##
utilityData <- read.table(".\\exdata-data-household_power_consumption\\household_power_consumption.txt", header=TRUE, sep=";", stringsAsFactors = FALSE, colClasses=c("character", "character", "numeric", "numeric", "numeric","numeric","numeric","numeric","numeric"), na.strings=c("?"))
##
## filter for just Feb 1st and 2nd of 2007
##
utilityData <- subset(utilityData, Date == "1/2/2007" | Date =="2/2/2007")
##
## create a true date time field from Date and Time columns
##
utilityData <- transform(utilityData, datetime=strptime(paste(utilityData$Date, utilityData$Time), "%d/%m/%Y %H:%M:%S"))

png(file="plot3.png")
plot(utilityData$datetime, utilityData$Sub_metering_1, type="n", xlab="", ylab="Energy sub metering")
points(utilityData$datetime, utilityData$Sub_metering_1, col="black", type="l")
points(utilityData$datetime, utilityData$Sub_metering_2, col="red", type="l")
points(utilityData$datetime, utilityData$Sub_metering_3, col="blue", type="l")
legend("topright", pch='--', col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()