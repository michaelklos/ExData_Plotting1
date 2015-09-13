## FileName: Plot3.R
## Last Modified: 2015-09-12
##
## Requirements:  Place exdata-data-household_power_consumption.zip in same directory
## Output:        Running script will unzip exdata-data-household_power_consumption.zip, 
##                  subset data, and generate Plot3.png directly via PNG device in same 
##                  directory. 
##
## Note:          Unlike Plot1 and Plot2, the legend does not appear correctly in the PNG
##                  when attempting to perform a dev.copy() from the screen device, and 
##                  so is being generated directly. 

## Load packages
library(dplyr)

## Define Plot Name
plotName <- "Plot3"

unzip("exdata-data-household_power_consumption.zip", 
      files=c("household_power_consumption.txt"), 
      overwrite=TRUE)

## Custom Format for use in colClasses, sourced from
##    http://stackoverflow.com/a/13022441
##    As implemented, this will generate a warning which may be ignored. 
print("The following warning may be ignored:")
setAs("character","myDate", function(from) as.Date(from, format="%d/%m/%Y") )

## Pull in subset of the data and filter down
hpc <- tbl_df(read.table("household_power_consumption.txt", header=TRUE, na.strings="?",
                         colClasses = c("myDate", "character", "numeric", "numeric", "numeric",
                                        "numeric","numeric","numeric","numeric"), sep=";")) %>%
  filter(as.character(Date) >= "2007-02-01" & as.character(Date) <= "2007-02-02")

## Generate Core Plot on PNG Device
png(filename = paste0(plotName, ".png"), width=480, height=480)
## Add in Sub metering 1 values as black line along with axis label
with(hpc, plot(as.POSIXct(paste(Date, Time), format="%Y-%m-%d %H:%M:%S"), 
               Sub_metering_1, 
               type="l",
               col="black", 
               xlab="",
               ylab="Energy Sub-Metering"))
## Add in Sub metering 2 values as red line
with(hpc, lines(as.POSIXct(paste(Date, Time), format="%Y-%m-%d %H:%M:%S"), 
               Sub_metering_2, 
               type="l",
               col="red"))
## Add in Sub metering 3 values as blue line
with(hpc, lines(as.POSIXct(paste(Date, Time), format="%Y-%m-%d %H:%M:%S"), 
                Sub_metering_3, 
                type="l",
                col="blue"))
## Add legend with line segments matching the metering lines previously added
legend("topright", lty = c(1, 1, 1), 
       lwd=c(2.5, 2.5, 2.5),
       col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       cex=0.75)
## Close PNG Device
dev.off() 


