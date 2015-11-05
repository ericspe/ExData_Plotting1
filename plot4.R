install.packages("sqldf")
library("sqldf")

#read the zip file that must be in the working directory and unzip
datafiles <- unzip("exdata-data-household_power_consumption.zip")

#extract the relevant files from the zip archive
pc <- file("./household_power_consumption.txt")
#set the file attributs to be able to read data
attr(pc, "file.format") <- list(sep = ";", header = TRUE) 
#load only the relevant rows
tab <- sqldf('select * from pc where "Date" = "1/2/2007" or "Date" = "2/2/2007"')

#set the graphic device and save the plot as png file in the working directory
png(filename = "plot4.png", width = 480, height = 480)
#make x as DateTime
x <- as.POSIXct(paste(tab$Date, tab$Time), format="%d/%m/%Y %H:%M:%S")
par(mfcol = c(2,2))
plot(x,tab$Global_active_power, type="l", ylab ="Global Active Power (kilowatts)", xlab="")
plot(x,tab$"Sub_metering_1" , type="l", ylab ="Energy sub metering", xlab="")
     lines(x,tab$"Sub_metering_2", col="red" )
     lines(x,tab$"Sub_metering_3", col="blue" )
     legend('topright', names(tab)[7:9] , lty=1, col=c('black', 'red',' blue'), bty="n")
plot(x,tab$"Voltage" , type="l", ylab ="Voltage", xlab="datetime")
plot(x,tab$Global_reactive_power , type="l", ylab ="Global_reactive_power", xlab="datetime")
dev.off()