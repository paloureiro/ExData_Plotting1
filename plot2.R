Sys.setlocale("LC_TIME", "English")

setwd("~/GitHub/ExData_Plotting1")
library(dplyr)
library(lubridate)

# Extracts and loads data from exdata-data-household_power_consumption.zip and household_power_consumption.txt, 
# respectively
consumption_df <- read.table(unzip("exdata-data-household_power_consumption.zip","household_power_consumption.txt")
                             ,nrows=2075259,header=T,sep = ";",na.strings = "?")

# Parses dates
consumption_df$Date <- consumption_df$Date %>%
        parse_date_time("%d%m%Y")
# Selects only 2 days from the data
consumption_df_excerpt <- consumption_df %>%
        filter(Date >= ymd("2007-02-01") & Date <= ymd("2007-02-02"))

# Merges the "Date" and "Time" columns into a new column called "timestamp"
consumption_df_excerpt <- mutate(consumption_df_excerpt,timestamp = format(as.POSIXct(paste(Date, Time))))

# Transforms the "timestamp" column to a POSIX format and plots the graph 
png(filename = "plot2.png")
plot(as.POSIXct(consumption_df_excerpt$timestamp,label=T),consumption_df_excerpt$Global_active_power,type="l",
     xlab = "",ylab="Global Active Power (kilowatts)")
dev.off()