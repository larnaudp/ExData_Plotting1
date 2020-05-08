Sys.setlocale("LC_TIME", "C")

library(readr)
library(dplyr)
library(lubridate)
library(lattice)
library(ggplot2)

## Reading data from the file
householddata <- read.table(file = "household_power_consumption.txt", header = TRUE, sep = ";")

## Converting interest variables
householddata$Date <- strptime(householddata$Date, "%d/%m/%Y")
householddata$Global_active_power <- as.character(householddata$Global_active_power)
householddata$Global_active_power <- parse_number(householddata$Global_active_power, na = c("?", NA))

householddata$Global_reactive_power <- as.character(householddata$Global_reactive_power)
householddata$Global_reactive_power <- parse_number(householddata$Global_reactive_power, na = c("?", NA))

householddata$Voltage <- as.character(householddata$Voltage)
householddata$Voltage <- parse_number(householddata$Voltage, na = c("?", NA))

householddata$Sub_metering_1 <- as.character(householddata$Sub_metering_1)
householddata$Sub_metering_1 <- parse_number(householddata$Sub_metering_1, na = c("?", NA))

householddata$Sub_metering_2 <- as.character(householddata$Sub_metering_2)
householddata$Sub_metering_2 <- parse_number(householddata$Sub_metering_2, na = c("?", NA))

householddata$Sub_metering_3 <- as.character(householddata$Sub_metering_3)
householddata$Sub_metering_3 <- parse_number(householddata$Sub_metering_3, na = c("?", NA))

## Filtering 2007-02-01 and 2007-02-02
householdfiltered <- householddata [householddata$Date == "2007-02-01" | householddata$Date == "2007-02-02", ]
householdfiltered <- mutate(householdfiltered, dateandtime = paste(Date, Time, sep = " "))
householdfiltered$dateandtime <- strptime(householdfiltered$dateandtime, "%Y-%m-%d %H:%M:%S")

## Plot
par(lwd = 0.001, mfrow =  c(2,2))

with(householdfiltered, plot(dateandtime, Global_active_power, ylab = "Global Active Power", xlab = NA, type = "l", lwd = 0.001))

with(householdfiltered, plot(dateandtime, Voltage, ylab = "Voltage", xlab = "datetime", type = "l", lwd = 0.001))

with(householdfiltered, plot(dateandtime, Sub_metering_1, type = "n", ylab = "Energy sub metering", xlab = NA))
with(householdfiltered, points(dateandtime, Sub_metering_1, type = "l", col = "black"))
with(householdfiltered, points(dateandtime, Sub_metering_2, type = "l", col = "red"))
with(householdfiltered, points(dateandtime, Sub_metering_3, type = "l", col = "blue"))
legend("topright", c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lwd = 0.001)

with(householdfiltered, plot(dateandtime, Global_reactive_power, xlab = "datetime", type = "l", lwd = 0.001))

dev.copy(png, file = "plot4.png")
dev.off()
