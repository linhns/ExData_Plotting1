library(data.table)

# Read the data
dt <- fread(input = "household_power_consumption.txt", na.strings = '?')

dt[, Global_active_power := lapply(.SD, as.numeric), 
   .SDcols = c("Global_active_power")]

# Change date column to Date type
dt[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

# Add a POSIXct date to facilitate graphing by time of day
dt[, datetime := as.POSIXct(paste(Date, Time))]
# Select date
dt <- dt[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

png("plot3.png")
plot(x = dt[, datetime], y = dt[, Sub_metering_1], type = "l", xlab = "", 
     ylab = "Global Active Power (kilowatts)")
lines(x = dt[, datetime], y = dt[, Sub_metering_2], col = "red")
lines(x = dt[, datetime], y = dt[, Sub_metering_3], col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), lty = c(1, 1))
dev.off()