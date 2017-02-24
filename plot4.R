# including libraries for working with dates and data manipulation 
library(lubridate)
library(dplyr)

# setting English
Sys.setlocale(category = "LC_ALL", locale = "english")

# saving the path of file that contains dataset
file_path <- "../household_power_consumption.txt"

# reading dataset
dataset <- read.table(
    file = file_path,
    header = TRUE,
    sep = ";",
    na.strings = "?",
    stringsAsFactors = FALSE
)

# selecting two dates and creating datetime feature
dataset <- dataset %>%
    filter(Date == "1/2/2007" | Date == "2/2/2007") %>%
    mutate(Date_time = dmy_hms(paste(Date, Time)))

# changing graphics device to png
png(filename = "plot4.png", height=504, width=504)

# making 4 multiple plots (2 x 2)
par(mfcol = c(2, 2))

# plot Global Active Power
plot(
    dataset$Date_time,
    dataset$Global_active_power,
    type = "l",
    xlab = "",
    ylab = "Global Active Power"
)

# plot Energy sub metering
plot(
    dataset$Date_time,
    dataset$Sub_metering_1,
    type = "l",
    xlab = "",
    ylab = "Energy sub metering"
)
points(dataset$Date_time, dataset$Sub_metering_2, type = "l", col = "red")
points(dataset$Date_time, dataset$Sub_metering_3, type = "l", col = "blue")
legend(
    "topright",
    lty = 1,
    col = c("black", "red", "blue"),
    legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
    bty = "n"
)

# plot Voltage
plot(
    dataset$Date_time,
    dataset$Voltage,
    type = "l",
    xlab = "datetime",
    ylab = "Voltage"
)

# plot Global_reactive_power
plot(
    dataset$Date_time,
    dataset$Global_reactive_power,
    type = "l",
    xlab = "datetime",
    ylab = "Global_reactive_power"
)

# close device
dev.off()