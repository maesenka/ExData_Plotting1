source("load_dataset.R")
library(lubridate)

# prevents repeated and redundant loading of the data
if(!exists("data", mode="list"))  
  data <- load_data()

png('plot2.png', width=480, height=480)

with(data,
  plot(Global_active_power ~ as.numeric(DateTime),data, type="l", xaxt="n", xlab="", ylab="Global Active Power (kilowatts)")
)

# Determine locations for labeling by weekday 
## First determine where the day starts
at <- hour(data$DateTime) == 0 & minute(data$DateTime) == 0
## Adds the last value
at[NROW(at)] <- TRUE
# We add 60 secs to time, so that last label will be Saturday
axis(side=1, at= as.numeric(data$DateTime[at]), labels=format(data$DateTime[at] + 60, "%a"), lwd=0, lwd.ticks=1)
dev.off()