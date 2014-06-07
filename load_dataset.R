load_data <- function() {
  data_dir <- "tmp"
  data_file_name = "household_power_consumption.txt"
  data_file_name = file.path(data_dir, data_file_name)  
  
  fdata <- read.csv(file=data_file_name, header=TRUE, sep=';', na.strings = "?")
  fdata$DateTime <- strptime(paste(as.character(fdata$Date), as.character(fdata$Time)), "%d/%m/%Y %H:%M:%S")
  range <- as.Date(c("2007-02-01", "2007-02-02"), "%Y-%m-%d")
  data_subset <- fdata[ as.Date(fdata$DateTime) %in% range,]
  return(data_subset)
}