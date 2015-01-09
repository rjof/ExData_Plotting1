## Read data
## Caution!: Loads the 2,075,259 rows
##           and subset it afterwards
a<-read.table("household_power_consumption.txt", na.string="?",sep=";",header=TRUE)
dim(a)
fechas<-strptime(a$Date,"%d/%m/%Y")
bools<-fechas>=as.POSIXlt("2007-02-01") & fechas<=as.POSIXlt("2007-02-02")
subSet<-a[bools,]

## plot2
d<-data.frame(strptime(paste(subSet$Date,subSet$Time,sep=" "), "%d/%m/%Y %H:%M:%S"),subSet$Global_active_power)
names(d)<-c("posixDate","gap")
plot(d$posixDate,d$gap,type='l',ylab="Global Active Power (kilowatts)",xlab="")
dev.copy(png,file="plot2.png")
dev.off()
