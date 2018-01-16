install.packages("dplyr")
library(dplyr)
df <- read.table("household_power_consumption.txt", header=TRUE,
                 sep=";", na.strings ="?")

df$DateTime <- as.POSIXct(strptime(paste(df$Date, df$Time, sep = " "), format = "%d/%m/%Y %H:%M:%S"))
df <- transform(df, Date = as.Date(Date, format = "%d/%m/%Y"))
df <- filter(df, Date == "2007-02-01" | Date == "2007-02-02")

par(mfrow = c(1,1))
with(df, plot(DateTime, Sub_metering_1, type = "l"))
with(df, lines(DateTime, Sub_metering_2, col= "orange"))
with(df, lines(DateTime, Sub_metering_3, col= "blue"))
legend("topright", pch = 95, col = c("black", "orange", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.copy(png, file = "plot3.png")
dev.off()