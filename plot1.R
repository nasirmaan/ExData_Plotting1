
# Read the data file
colcls = c ('character', 'character', rep('numeric', 7))
df <- read.table("household_power_consumption.txt", na.strings="?", head=T, sep=";", colClasses=colcls)

#chage type of Date column
df$Date <- as.Date(strptime(df$Date, format('%d/%m/%Y')))

# subset based data of 2-days period
df.target <- df[df$Date  == "2007-02-01" | df$Date  == "2007-02-02", ]

# Draw histogram plot to PNG device.
png("plot1.png", height=480, width=480)
hist(df.target$Global_active_power, 
     xlab="Global Active Power (kilowatts)", 
     col="red", main="Global Active Power")
dev.off()