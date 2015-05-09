## Program downloads a file and then extracts the data for dates: 2/2/2007 and 1/2/2007
## the data is then charted to a line chart with 3 different lines color coded.

library(data.table)
library(dplyr)

## Download the data from the text file.
hh_power_data <- tbl_df(read.table("./household_power_consumption.txt", 
                                   header = TRUE, sep=";", na.strings="?"))

## Filter on the dates of the file.
power_filtered <- filter(hh_power_data, Date == "2/2/2007" | Date == "1/2/2007")

## Convert to a Date field to Date data type
power_filtered$Date <- as.Date(power_filtered$Date, "%d/%m/%Y")

## Paste the Date and Time variables to one field
power_filtered$Time <- paste(power_filtered$Date, power_filtered$Time, sep=" ")

## Convert Time field to Time data type.
power_filtered$Time <- strptime(power_filtered$Time, 
                                "%Y-%m-%d %H:%M:%S", 
                                tz=Sys.timezone())

## Plot the line chart
png("Plot3.png")
plot(power_filtered$Time, 
     power_filtered$Sub_metering_1, 
     type='l', col="black", xlab='', ylab="Energy sub metering")
lines(power_filtered$Time,
      power_filtered$Sub_metering_2,
      type='l', col="red")
lines(power_filtered$Time,
      power_filtered$Sub_metering_3,
      type='l', col="blue")
legend('topright', c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
                   col=c('black', 'red', 'blue'),
                   lty='solid')
dev.off()



