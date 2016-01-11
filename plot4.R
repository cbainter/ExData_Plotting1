## plot4.R
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

png(file="plot4.png")
par(mfrow = c(2,2))
with(utilityData, {
  plot(datetime, Global_active_power, type="l", xlab="", ylab="Global Active Power")
  plot(datetime, Voltage, type="l", xlab="datetime", ylab="Voltage")
  plot(utilityData$datetime, utilityData$Sub_metering_1, type="n", xlab="", ylab="Energy sub metering")
  points(utilityData$datetime, utilityData$Sub_metering_1, col="black", type="l")
  points(utilityData$datetime, utilityData$Sub_metering_2, col="red", type="l")
  points(utilityData$datetime, utilityData$Sub_metering_3, col="blue", type="l")
  #legend("topright", pch='-', col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  usr <- par("usr")
  ## I have no idea why the legend was working w/subplots correctly
  ## so we'll do it the very hard way - ugh
  text(usr[2]-35000, usr[4]-3, "Sub_metering_1", cex=.7)
  text(usr[2]-35000, usr[4]-6, "Sub_metering_2", cex=.7)
  text(usr[2]-35000, usr[4]-9, "Sub_metering_3", cex=.7)
  text(usr[2]-70000, usr[4]-3, "--", col="black")
  text(usr[2]-70000, usr[4]-6, "--", col="red")
  text(usr[2]-70000, usr[4]-9, "--", col="blue")
  plot(datetime, Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
})
dev.off()