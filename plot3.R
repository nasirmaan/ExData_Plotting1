
# Read the data file
colcls = c ('character', 'character', rep('numeric', 7))
df <- read.table("household_power_consumption.txt", na.strings="?", head=T, sep=";", colClasses=colcls)

#chage type of Date column
df$Date <- as.Date(strptime(df$Date, format('%d/%m/%Y')))

# subset based data of 2-days period
df.target <- df[df$Date  == "2007-02-01" | df$Date  == "2007-02-02", ]

# Subset global active power days of Thu, Fri and Sat
x <- cbind(weekdays(df.target$Date), 
        df.target[weekdays(df.target$Date) %in% c("Thursday", "Friday", "Saturday"), c(7,8,9)])

# get positions of first Thu, Fri and sat.
pos = c((which(x[, 1]=="Thursday"))[1], (which(x[, 1]=="Friday"))[1], 
      {if(is.na((which(x[, 1]=="Saturday"))[1])) nrow(x) else (which(x[, 1]=="Saturday"))[1]})

# Draw plot to PNG device.
png("plot3.png", height=480, width=480)
plot(x[,2], type="l", xaxt="n", xlab="", ylab="Energy sub metering")
lines(x[,3], type="l", col="red")
lines(x[,4], type="l", col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), 
       col=c("black", "red", "blue"), lty=1, bty="n")
axis(1, at=pos, labels=c("Thu", "Fri", "Sat"))
dev.off()