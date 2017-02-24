# including libraries for working with dates and data manipulation 
library(lubridate)
library(dplyr)

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
png(filename = "plot1.png", height=480, width=480)

# making a histogram
hist(
    dataset$Global_active_power,
    col = "red",
    xlab = "Global Active Power (kilowatts)",
    ylab = "Frequency",
    main = "Global Active Power"
)

# close device
dev.off()
