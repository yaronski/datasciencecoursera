library(dplyr)
library(data.table)

fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
diskFile <- "./data/data.zip"
download.file(fileURL, diskFile)

unzip(diskFile, exdir = "./data")

data <- read.table("./data/household_power_consumption.txt", header = FALSE, skip = 66637, nrows = 2880, colClasses=c("character", "character", rep("numeric", 7)), na.strings = "?", sep = ";")
header <- read.table("./data/household_power_consumption.txt", header = FALSE, nrows = 1, sep = ";", stringsAsFactors=FALSE)
setnames(data, 1:9, c(as.character(header[,1:9])))

data$Date <- as.POSIXlt(paste(as.Date(data$Date, format="%d/%m/%Y"), data$Time, sep=" "))

######################################################

png("plot2.png", width = 480, height = 480)

plot(data[, 1], data[, 3], type = "l", xlab = "", ylab = "Global Active Power (kilowatts)",  bg = "white")

dev.off()
