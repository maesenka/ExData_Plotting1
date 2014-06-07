## Downloads and unzips the data file

data_dir <- "tmp"
data_file_name = "household_power_consumption.zip"
zip_file_name = file.path(data_dir, data_file_name)


url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

if ( !file.exists(data_dir) ) 
  dir.create(data_dir)

download.file(url, destfile= zip_file_name, method= "curl")
unzip(zipfile=zip_file_name, exdir = data_dir)

