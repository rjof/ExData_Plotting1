## Read data
## Caution!: Loads the 2,075,259 rows
##           and subset it afterwards
a<-read.table("household_power_consumption.txt", na.string="?",sep=";",header=TRUE)
dim(a)
fechas<-strptime(a$Date,"%d/%m/%Y")
bools<-fechas>=as.POSIXlt("2007-02-01") & fechas<=as.POSIXlt("2007-02-02")
subSet<-a[bools,]

## plot4
par(mfrow=c(2,2))

## First one 1,1
d<-data.frame(strptime(paste(subSet$Date,subSet$Time,sep=" "), "%d/%m/%Y %H:%M:%S"),subSet$Global_active_power)
names(d)<-c("posixDate","gap")
plot(d$posixDate,d$gap,type='l',ylab="Global Active Power",xlab="")

## Second one 1,2
v<-data.frame(strptime(paste(subSet$Date,subSet$Time,sep=" "), "%d/%m/%Y %H:%M:%S"),subSet$Voltage)
names(v)<-c("date","voltage")
plot(v$date,v$voltage,type='l',ylab="Voltage",xlab="datetime")

## Third one 2,1
e<-data.frame(strptime(paste(subSet$Date,subSet$Time,sep=" "), "%d/%m/%Y %H:%M:%S"),subSet$Sub_metering_1,subSet$Sub_metering_2,subSet$Sub_metering_3)
names(e)<-c("date","sm1","sm2","sm3")
plot(e$date,e$sm1,type='l',col='black',ylim=range(c(e$sm1,e$sm2,e$sm3)), xlab="",ylab="")
par(new=TRUE)
plot(e$date,e$sm2,type='l',col='red',ylim=range(c(e$sm1,e$sm2,e$sm3)), xlab="",ylab="")
par(new=TRUE)
plot(e$date,e$sm3,type='l',col='blue',ylim=range(c(e$sm1,e$sm2,e$sm3)), xlab="",ylab="Energy sub metering")
legend(legend=c('Sub_metering_1','Sub_metering_2','Sub_metering_3'),"topright",pch=1,col=c('black','red','blue'))

## Fourth one 2,2
grp<-data.frame(strptime(paste(subSet$Date,subSet$Time,sep=" "), "%d/%m/%Y %H:%M:%S"),subSet$Global_reactive_power)
names(grp)<-c("date","grp")
plot(grp$date,grp$grp,xlab="datetime",ylab="Global_reactive_power",type='l')
dev.copy(png,file="plot4.png")
dev.off()
