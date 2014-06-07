source("load_dataset.R")
library(lubridate)
# 
# prevents repeated and redundant loading of the data
if(!exists("data", mode="list"))
  data <- load_data()

addDateTimeAxis <- function(){
  with(data,{
  at <- hour(DateTime) == 0 & minute(DateTime) == 0
  ## Adds the last value
  at[NROW(at)] <- TRUE
  # We add 60 secs to time, so that last label will be Saturday
  axis(side=1, at= as.numeric(DateTime[at]), labels=format(DateTime[at] + 60, "%a"), lwd=0, lwd.ticks=1)
  })
}

varnames <- c()
for(i in 1:3) varnames <- c(varnames,  paste0("Sub_metering_", i))
smcolors <- c("black", "red", "blue")

png('plot4.png', width=480, height=480)
par(mfcol=c(2,2))
with(data, {
  # First
  plot(Global_active_power ~ as.numeric(DateTime),data, type="l", xaxt="n", xlab="", ylab="Global Active Power")
  addDateTimeAxis()
  #Second
  plot(Sub_metering_1 ~ as.numeric(DateTime), type="n", xaxt="n", xlab="", ylab="Enery sub metering")
  for (i in 1:3) {
    f <- paste(varnames[i], " ~ ", "as.numeric(DateTime)")
    lines( as.formula(f), col=smcolors[i])
  }    
  addDateTimeAxis()
  legend("topright", varnames, lty=1, col=smcolors)
  #Third
  plot(Voltage ~ as.numeric(DateTime), type="l", xaxt="n", xlab="datetime", ylab="Voltage")
  addDateTimeAxis()
  #Fourth
  plot(Global_reactive_power ~ as.numeric(DateTime), type="l", xaxt="n", xlab="datetime")
  addDateTimeAxis()
})
dev.off()