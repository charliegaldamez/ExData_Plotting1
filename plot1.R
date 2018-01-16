install.packages("dplyr")
library(dplyr)
df <- read.table("household_power_consumption.txt", header=TRUE,
                 sep=";", na.strings ="?")

df$DateTime <- as.POSIXct(strptime(paste(df$Date, df$Time, sep = " "), format = "%d/%m/%Y %H:%M:%S"))
df <- transform(df, Date = as.Date(Date, format = "%d/%m/%Y"))
df <- filter(df, Date == "2007-02-01" | Date == "2007-02-02")

par(mfrow = c(1,1), bg = "white")
hist(df$Global_active_power, col = "orange", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.copy(png, file = "plot1.png")
dev.off()
