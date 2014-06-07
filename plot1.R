source("load_dataset.R")

# prevents repeated and redundant loading of the data
if(!exists("data", mode="list"))
  data <- load_data()

png('plot1.png', width=480, height=480)
with(data,
  hist(Global_active_power, xlab="Global Active Power (kilowatts)", main="Global Active Power.", col="red")
)
dev.off()
