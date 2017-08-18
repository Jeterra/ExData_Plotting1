# Plot4.R
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


# initiating a composite plot with many graphs
par(mfrow=c(2,2))

# calling the basic plot function that calls different plot functions to build the 4 plots that form the graph
with(subpowercons,{
  plot(subpowercons$Time,as.numeric(as.character(subpowercons$Global_active_power)),type="l",  xlab="",ylab="Global Active Power")  
  plot(subpowercons$Time,as.numeric(as.character(subpowercons$Voltage)), type="l",xlab="datetime",ylab="Voltage")
  plot(subpowercons$Time,subpowercons$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
   with(subpowercons,lines(Time,as.numeric(as.character(Sub_metering_1))))
   with(subpowercons,lines(Time,as.numeric(as.character(Sub_metering_2)),col="red"))
   with(subpowercons,lines(Time,as.numeric(as.character(Sub_metering_3)),col="blue"))
   legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex = 0.6)
  plot(subpowercons$Time,as.numeric(as.character(subpowercons$Global_reactive_power)),type="l",xlab="datetime",ylab="Global_reactive_power")
})

# making plot4.png
dev.copy(png,'plot4.png',width = 480, height = 480, units = "px")
dev.off()

