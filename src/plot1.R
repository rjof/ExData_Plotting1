## Read data
## Caution!: Loads the 2,075,259 rows
##           and subset it afterwards
a<-read.table("household_power_consumption.txt", na.string="?",sep=";",header=TRUE)
dim(a)
fechas<-strptime(a$Date,"%d/%m/%Y")
bools<-fechas>=as.POSIXlt("2007-02-01") & fechas<=as.POSIXlt("2007-02-02")
subSet<-a[bools,]

## plot1
hist(subSet$Global_active_power,main="Global Active Power",xlab="Global Active Power (kilowatts)",col="red")
dev.copy(png,file="plot1.png")
dev.off()
