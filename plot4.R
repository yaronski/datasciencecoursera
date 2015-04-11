library(dplyr)
library(data.table)

fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
diskFile <- "./data/data.zip"
download.file(fileURL, diskFile)

unzip(diskFile, exdir = "./data")

data <- read.table("./data/household_power_consumption.txt", header = FALSE, skip = 66637, nrows = 2880, colClasses=c("character", "character", rep("numeric", 7)), na.strings = "?", sep = ";") #colClasses = c("numeric", "character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric")
header <- read.table("./data/household_power_consumption.txt", header = FALSE, nrows = 1, sep = ";", stringsAsFactors=FALSE)
setnames(data, 1:9, c(as.character(header[,1:9])))

data$Date <- as.POSIXlt(paste(as.Date(data$Date, format="%d/%m/%Y"), data$Time, sep=" "))

######################################################

png("plot4.png", width = 480, height = 480)

par(mar = c(5, 4, 2, 2),
    mfcol = c(2, 2)
    )

#### plot 1####

plot(data[, 1], data[, 3], 
     type = "l", 
     xlab = "", 
     ylab = "Global Active Power (kilowatts)",  
     bg = "white")

####plot 2####

plot(data[, 1], data[, 7], 
     type = "l", 
     xlab = "", 
     ylab = "Energy sub metering",  
     bg = "white")

lines(data[, 1], data[, 8], col = "red")
lines(data[, 1], data[, 9], col = "blue")

legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c(names(data[, 7:9])))

####plot 3####

plot(data[, 1], data[, 5], 
     type = "l", 
     xlab = "datetime", 
     ylab = "Voltage",  
     bg = "white")

####plot 4####

plot(data[, 1], data[, 4], 
     type = "l", 
     xlab = "datetime", 
     ylab = "Global_reactive_power"",  
     bg = "white")

dev.off()