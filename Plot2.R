# Plot2.R
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

##You may find it useful to convert the Date and Time variables to Date/Time 
##classes in R using the strptime()  and as.Date() functions.

# Transforming the Date and Time vars from characters into objects of type Date and POSIXlt respectively
subpowercons$Date <- as.Date(subpowercons$Date, format="%d/%m/%Y")
subpowercons$Time <- strptime(subpowercons$Time, format="%H:%M:%S")
r1 <- nrow(subset(hhpowercons ,hhpowercons $Date=="1/2/2007"))
r2 <- nrow(subset(hhpowercons ,hhpowercons $Date=="2/2/2007"))
subpowercons[1:r1,"Time"] <- format(subpowercons[1:1440,"Time"],"2007-02-01 %H:%M:%S")
subpowercons[r1+1:r2,"Time"] <- format(subpowercons[1441:2880,"Time"],"2007-02-02 %H:%M:%S")


# basic plot function
plot(subpowercons$Time,as.numeric(as.character(subpowercons$Global_active_power)),type="l",xlab="",ylab="Global Active Power (kilowatts)") 

# annotating graph
title(main="Global Active Power Vs Time")

# making plot2.png
dev.copy(png,'plot2.png',width = 480, height = 480, units = "px")
dev.off()
