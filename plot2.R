
# Read the data file
colcls = c ('character', 'character', rep('numeric', 7))
df <- read.table("household_power_consumption.txt", na.strings="?", head=T, sep=";", colClasses=colcls)

#chage type of Date column
df$Date <- as.Date(strptime(df$Date, format('%d/%m/%Y')))

# subset based data of 2-days period
df.target <- df[df$Date  == "2007-02-01" | df$Date  == "2007-02-02", ]

# Subset global active power days of Thu, Fri and Sat
x <- cbind(weekdays(df.target$Date), 
        df.target[weekdays(df.target$Date) %in% c("Thursday", "Friday", "Saturday"), 
        "Global_active_power"])

# get positions of first Thu, Fri and sat.
pos = c((which(x[, 1]=="Thursday"))[1], (which(x[, 1]=="Friday"))[1], 
      {if(is.na((which(x[, 1]=="Saturday"))[1])) nrow(x) else (which(x[, 1]=="Saturday"))[1]})

# Draw plot to PNG device.
png("plot2.png", height=480, width=480)
plot(x[,2], type="l", xaxt="n", xlab="", ylab="Global Active Power (killowatts)")
axis(1, at=pos, labels=c("Thu", "Fri", "Sat"))
dev.off()