message("Loading CSV ...")
data <- read.csv(
  "../household_power_consumption.txt", 
  nrows = 1050000, 
  colClasses = c("character", "character", "numeric", 
                 "numeric", "numeric", "numeric", 
                 "numeric", "numeric", "numeric"), 
  sep = ";", 
  comment.char = "", 
  na.strings = "?"
)

message("Converting Date Columns ...")
data$DateTime <- strptime(
  paste(data[,"Date"], data[,"Time"]),
  "%d/%m/%Y %H:%M:%S")

message("Filtering only the working subset ...")
data <- subset(
  data, 
  DateTime >= as.POSIXct("2007-02-01") & DateTime < as.POSIXct("2007-02-03")
)

message("Creating plot.png ...")
png(filename = "plot2.png", width = 480, height = 480)
with(data, {
  plot(DateTime, Global_active_power, type = "l",
       xlab="",
       ylab="Global Active Power (kilowatts)")
})
dev.off()
