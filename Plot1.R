## FileName: Plot1.R
## Last Modified: 2015-09-11
##
## Requirements:  Place exdata-data-household_power_consumption.zip in same directory
## Output:        Running script will unzip exdata-data-household_power_consumption.zip, 
##                  subset data, generate Plot1 on screen, and output Plot1.png in same 
##                  directory. 

## Load packages
library(dplyr)

## Define Plot Name
plotName <- "Plot1"

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

## Generate Core Plot on Screen Device
with(hpc, hist(Global_active_power, 
               col="red", 
               main="Total Active Power",
               xlab="Global Active Power (kilowatts)",
               ylab="Frequency"))

## Copy Screen Device plot to PNG; set size
dev.copy(png, file = paste0(plotName, ".png"), width=480, height=480) 
## Close PNG Device
dev.off() 

