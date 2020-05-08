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

## Filtering 2007-02-01 and 2007-02-02
householdfiltered <- householddata [householddata$Date == "2007-02-01" | householddata$Date == "2007-02-02", ]
householdfiltered <- mutate(householdfiltered, dateandtime = paste(Date, Time, sep = " "))
householdfiltered$dateandtime <- strptime(householdfiltered$dateandtime, "%Y-%m-%d %H:%M:%S")

## Plot
with(householdfiltered, plot(dateandtime, Global_active_power, ylab = "Global Active Power (kilowatts)", xlab = NA, type = "l", lwd = 0.001))

dev.copy(png, file = "plot2.png")
dev.off()
