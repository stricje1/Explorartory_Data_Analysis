################################# PLOT 2 ######################################
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

# Plot a time series plot of the filtered data
with(hpc, {
  plot(Global_active_power~Datetime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
})

# Generate the png formatted plot the working directory  
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()