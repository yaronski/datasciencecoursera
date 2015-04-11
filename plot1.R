library(dplyr)
library(data.table)

fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
diskFile <- "./data/data.zip"
download.file(fileURL, diskFile)

unzip(diskFile, exdir = "./data")

data <- read.table("./data/household_power_consumption.txt", header = FALSE, skip = 66637, nrows = 2880, na.strings = "?", sep = ";")
header <- read.table("./data/household_power_consumption.txt", header = FALSE, nrows = 1, sep = ";", stringsAsFactors=FALSE)
setnames(data, 1:9, c(as.character(header[,1:9])))

data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

######################################################

png("plot1.png", width = 480, height = 480)

hist(data[, 3], breaks = 12, xlab = "Global Active Power (kilowatts)", ylab = "Frequency", main = "Global Active Power", col = "red")

dev.off()
