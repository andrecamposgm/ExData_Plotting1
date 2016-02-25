message("Loading CSV ...")
data <- read.csv(
  "../household_power_consumption.txt", 
  nrows = 1050000, 
  colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric","numeric", "numeric", "numeric"), 
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
png(filename = "plot3.png", width = 480, height = 480)
with(data, {
  plot(DateTime, 
       Sub_metering_1, 
       type = "l",
       xlab="",
       ylab="Energy sub metering")
  lines(DateTime, Sub_metering_2, col="red")
  lines(DateTime, Sub_metering_3, col="blue")
  legend("topright", 
         c("Sub_metering_1", 
           "Sub_metering_2",
           "Sub_metering_3"),
         col=c("black","red","blue"), 
         lty = 1
         )
})
dev.off()
