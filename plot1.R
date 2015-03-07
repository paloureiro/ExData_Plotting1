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
# Plotting
png(filename = "plot1.png")
hist(consumption_df_excerpt$Global_active_power,col="red",main="Global Active Power",
     xlab="Global Active Power (kilowatts)")
dev.off()

