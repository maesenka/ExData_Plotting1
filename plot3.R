source("load_dataset.R")
library(lubridate)
# 
# prevents repeated and redundant loading of the data
if(!exists("data", mode="list"))  
  data <- load_data()

png('plot3.png', width=480, height=480)

varnames <- c()
for(i in 1:3) varnames <- c(varnames,  paste0("Sub_metering_", i))
smcolors <- c("black", "red", "blue")

with(data, 
  {
    plot(Sub_metering_1 ~ as.numeric(DateTime), type="n", xaxt="n", xlab="", ylab="Energy sub metering")
    # generate the formula's from the varnames vector, and use to draw in defined color.
    for (i in 1:3) {
      f <- paste(varnames[i], " ~ ", "as.numeric(DateTime)")
      lines( as.formula(f), col=smcolors[i])
    }    
  })


# Adds legend
legend("topright", varnames, lty=1, col=smcolors)

# Determine locations for labeling by weekday 
## First determine where the day starts
at <- hour(data$DateTime) == 0 & minute(data$DateTime) == 0
## Adds the last value
at[NROW(at)] <- TRUE
# We add 60 secs to time, so that last label will be Saturday
axis(side=1, at= as.numeric(data$DateTime[at]), labels=format(data$DateTime[at] + 60, "%a"),  lwd=0, lwd.ticks=1)
dev.off()