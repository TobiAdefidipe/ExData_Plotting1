library(data.table)
#Read data
#

filepath <- "U:/Nexen Work/household_power_consumption.txt"  #insert file path for data

#Grab Input Data
Input <- read.table(file = filepath, header = TRUE, sep = ";", stringsAsFactors = FALSE, na.strings = "?")
Input <- data.table(Input)
Input[, Date := as.Date(Date, format = "%d/%m/%Y")]  #Convert Date to Date class
Input <- Input [Date >= as.Date("01/02/2007", format = "%d/%m/%Y") & Date <= as.Date("02/02/2007", format = "%d/%m/%Y"), ] #Subset to only required data
Input <- data.frame(Input)
Input$Time <- as.POSIXct(strptime(Input$Time, format = "%H:%M:%S")) #Convert time to class time
Input$Time <- strftime(Input$Time, format = "%H:%M:%S")


# Set layout
# 
par (mfrow = c(2,2))

#First Plot

plot (Input$Global_active_power ~ as.POSIXct(paste(Input$Date, Input$Time)), type = "l", xlab = "", ylab = "Global Active Power")

# Second Plot

plot (Input$Voltage ~ as.POSIXct(paste(Input$Date, Input$Time)), type = "l", xlab = "datetime", ylab = "Voltage")

#Third Plot

plot (as.POSIXct(paste(Input$Date, Input$Time)),Input$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
points(as.POSIXct(paste(Input$Date, Input$Time)),Input$Sub_metering_2, type = "l", col = "red")
points(as.POSIXct(paste(Input$Date, Input$Time)),Input$Sub_metering_3, type = "l", col = "blue")
legend ("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1,1), col = c("black", "red", "blue"), cex= 0.5, xjust = 0)

# Fourth Plot
# 
plot (Input$Global_reactive_power ~ as.POSIXct(paste(Input$Date, Input$Time)), type = "l", xlab = "datetime", ylab = "Global_reactive_power")


# Copy plot from the screen to png file
# 
dev.copy(png, 'plot4.png')
dev.off()
