################################# PLOT 4 ######################################
# Jeffrey Strickland
# Load required libraries
library(tibbletime)
library(dplyr)

# Set filename of dataset to load in working directory
filename <- "household_power_consumption.txt"

# Check whether datset exist
# If cannot fine file using getwd working diectory, then
# set working directory to project directory
getwd()
if (!file.exists(filename)){
  path <- setwd("C:/Users/jeff/Documents/R/Exploratory Data Analysis/")
}  

# Read in full data set from semicolon delimited file
hpc_all <- read.csv("household_power_consumption.txt", header=TRUE, sep=';', 
                    na.strings="?", nrows=2075259, check.names=F, quote='\"')

# Filter data for only dates required for analysis
hpc <- subset(hpc_all, Date %in% c("1/2/2007","2/2/2007"))

# Set date format as needed for plotting
hpc$Date <- as.Date(hpc$Date, format="%d/%m/%Y")
datetime <- paste(as.Date(hpc$Date), hpc$Time)
hpc$Datetime <- as.POSIXct(datetime)

#Plot times series for 3 sub-metering variables:
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(hpc, {
  plot(Global_active_power~Datetime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~Datetime, type="l", 
       ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~Datetime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~Datetime, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="")
})
## Saving to file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()

# Reset plot area
par(mfrow=c(1,1))