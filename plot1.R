## Program downloads a file and then extracts the data for dates: 2/2/2007 and 1/2/2007
## the data is then charted to a red histogram.

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

## Create the histogram chart and save it to a png file.
png("Plot1.png")
hist(power_filtered$Global_active_power, 
     xlab = "Global Active Power (kilowatts)", 
     main="Global Active Power",
     col="red")
dev.off()