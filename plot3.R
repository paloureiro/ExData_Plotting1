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
png(filename = "plot3.png")
plot(as.POSIXct(consumption_df_excerpt$timestamp,label=T),consumption_df_excerpt$Sub_metering_1,type="l",
     xlab = "",ylab="Energy sub metering")
lines(as.POSIXct(consumption_df_excerpt$timestamp,label=T),consumption_df_excerpt$Sub_metering_2,type="l",
      col="red")
lines(as.POSIXct(consumption_df_excerpt$timestamp,label=T),consumption_df_excerpt$Sub_metering_3,type="l",
      col="blue")
legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1,col=c("black","red",
                                                                                             "blue"))
dev.off()