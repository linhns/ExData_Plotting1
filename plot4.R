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

png("plot4.png")
par(mfrow = c(2, 2))

# Plot 1 of 4
plot(dt[, datetime], dt[, Global_active_power], type="l", 
     xlab="", ylab="Global Active Power")

# Plot 2 of 4
plot(dt[, datetime], dt[, Voltage], type="l", 
     xlab="", ylab="Voltage")

# Plot 3 of 4
plot(x = dt[, datetime], y = dt[, Sub_metering_1], type = "l", xlab = "", 
     ylab = "Global Active Power (kilowatts)")
lines(x = dt[, datetime], y = dt[, Sub_metering_2], col = "red")
lines(x = dt[, datetime], y = dt[, Sub_metering_3], col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), lty = c(1, 1))

# Plot 4 of 4
plot(dt[, datetime], dt[, Global_reactive_power], type="l", 
     xlab="", ylab="Global_reactive_power")
dev.off()