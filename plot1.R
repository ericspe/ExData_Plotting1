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
png(filename = "plot1.png", width = 480, height = 480)
hist(tab$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()