library(data.table)

# Read the data
dt <- fread(input = "household_power_consumption.txt", na.strings = '?')

dt[, Global_active_power := lapply(.SD, as.numeric), 
   .SDcols = c("Global_active_power")]

# Change date column to Date type
dt[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

# Select date
dt <- dt[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

png("plot1.png")
hist(dt[, Global_active_power], col = "red", xlab = "", ylab = "", main = "")
title("Global active power", xlab = "Global Active Power (kilowatts)",
      ylab = "Frequency")
dev.off()