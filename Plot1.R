# Plot1.R
# Download and Unzip data to directory
if(!file.exists("household_power_consumption.zip") | !file.exists("household_power_consumption.txt") )
{
	fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
	download.file(fileUrl,destfile="household_power_consumption.zip")
	unzip(zipfile="household_power_consumption.zip",exdir=".")
}

#Reading data
hhpowercons <- read.table("household_power_consumption.txt",header=TRUE,sep=";")
subpowercons <- subset(hhpowercons ,hhpowercons $Date=="1/2/2007" | hhpowercons $Date =="2/2/2007")

#calling basic plot function
hist(as.numeric(as.character(subpowercons$Global_active_power)),col="red",xlab="Global Active Power(kilowatts)")

# annotating graph
title(main="Global Active Power")

# making plot1.png
dev.copy(png,'plot1.png',width = 480, height = 480, units = "px")
dev.off()