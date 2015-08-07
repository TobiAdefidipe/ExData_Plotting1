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

#Code to Plot Plot 1

Plot1 <- hist(Input$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)" , main = "Global Active Power")

# Copy plot from the screen to png file
# 
dev.copy(png, 'plot1.png')
dev.off()
