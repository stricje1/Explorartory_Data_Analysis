################################# PLOT 1 ######################################
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
  path <- setwd("C:/Users/jeff/Documents/R/Exploratory Data Analysis/Exploratory_Data_Analysis/")
}  

# Read in full data set from semicolon delimited file
hpc_all <- read.csv("household_power_consumption.txt", header=TRUE, sep=';', 
                    na.strings="?", nrows=2075259, check.names=F, quote='\"')

# Filter data for only dates required for analysis
hpc <- subset(hpc_all, Date %in% c("1/2/2007","2/2/2007"))

#Print dataset header and first 8 rows of data
head(hpc,9)

# Get dataset dimension size and perform comparative memory test 
print(paste("number of data points:", dim(hpc)))
print(paste("memory requirement filtered data is:",object.size(hpc)/1000000, "megabytes"))
print(paste("memory requirement full data is:",object.size(hpc_all)/1000000, "megabytes"))

# Set date format as needed for plotting
hpc$Date <- as.Date(hpc$Date, format="%d/%m/%Y")
datetime <- paste(as.Date(hpc$Date), hpc$Time)
hpc$Datetime <- as.POSIXct(datetime)

# Plot a histogram of the filtered data
hist(hpc$Global_active_power, main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

# Generate the png formatted plot the working directory  
dev.copy(png, "plot1.png", width=480, height=480)
dev.off()