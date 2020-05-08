library(readr)

## Reading data from the file
householddata <- read.table(file = "household_power_consumption.txt", header = TRUE, sep = ";")

## Converting interest variables
householddata$Date <- strptime(householddata$Date, "%d/%m/%Y")
householddata$Global_active_power <- as.character(householddata$Global_active_power)
householddata$Global_active_power <- parse_number(householddata$Global_active_power, na = c("?", NA))

## Filtering 2007-02-01 and 2007-02-02
householdfiltered <- householddata [householddata$Date == "2007-02-01" | householddata$Date == "2007-02-02", ]

## Plot
with(householdfiltered, hist(Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)"))

dev.copy(png, file = "plot1.png")
dev.off()