# LIBRARIES
library(lubridate)

# DATA IMPORT AND PREPARATION
data <- read.csv2(file = "household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", stringsAsFactors = FALSE)

# coerce Date to date object
data$Date <- dmy(data$Date)
# create dateTime variable
data$dateTime <- paste(data$Date, data$Time, sep = " ")
data$dateTime <- strptime(data$dateTime, format = "%Y-%m-%d %H:%M:%S", tz = "GMT")


# create df with necessary data only: 2007-02-01 and 2007-02-02
dateStart <- as.POSIXct("2007-02-01 00:00:00")
dateEnd <- as.POSIXct("2007-02-02 23:59:59")
int <- new_interval(dateStart, dateEnd) # interval of interest
df <- data[data$Date %within% int,]

# coerce other variables to appropirate data types
df1 <- df

df1$Global_active_power <- as.numeric(df1$Global_active_power)
df1$Global_reactive_power <- as.numeric(df1$Global_reactive_power)
df1$Voltage <- as.numeric(df1$Voltage)
df1$Global_intensity <- as.numeric(df1$Global_intensity)
df1$Sub_metering_1 <- as.numeric(df1$Sub_metering_1)
df1$Sub_metering_2 <- as.numeric(df1$Sub_metering_2)
df1$Sub_metering_3 <- as.numeric(df1$Sub_metering_3)

# PLOTTING

# plot2

with(df1, plot(dateTime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)"))

dev.copy(png, "plot2.png", width = 480, height = 480)
dev.off()
