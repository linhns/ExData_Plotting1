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

png("plot2.png")
plot(x = dt[, datetime], y = dt[, Global_active_power], type = "l", xlab = "", 
     ylab = "Global Active Power (kilowatts)")
dev.off()