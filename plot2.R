## plot2.R
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

## graph
##
png(file="plot2.png")
plot(utilityData$datetime, utilityData$Global_active_power, xlab="", ylab="Global Active Power (kilowatts)", type="l")
dev.off()