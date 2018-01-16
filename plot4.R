install.packages("dplyr")
library(dplyr)
df <- read.table("household_power_consumption.txt", header=TRUE,
                 sep=";", na.strings ="?")

df$DateTime <- as.POSIXct(strptime(paste(df$Date, df$Time, sep = " "), format = "%d/%m/%Y %H:%M:%S"))
df <- transform(df, Date = as.Date(Date, format = "%d/%m/%Y"))
df <- filter(df, Date == "2007-02-01" | Date == "2007-02-02")

par(mfrow = c(2,2))
with(df, {
  plot(DateTime, Global_active_power, type = "l", ylab = "Global Active Power", xlab = "")
  plot(DateTime, Voltage, type = "l", xlab = "datetime")
  plot(DateTime, Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "datetime")
  lines(DateTime, Sub_metering_2, col= "orange")
  lines(DateTime, Sub_metering_3, col= "blue")
  legend("topright", pch = 95, col = c("black", "orange", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), box.col = "transparent")
  plot(DateTime, Global_reactive_power, type = "l", xlab = "datetime")
})
dev.copy(png, file = "plot4.png")
dev.off()