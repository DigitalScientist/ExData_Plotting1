
#This is just for the second command
maindf<-read.table("household_power_consumption.txt",sep=";",head=TRUE,nrows=2)

#Partially import from source
thutosat<-read.table("household_power_consumption.txt",sep=";",head=TRUE,skip=63250,nrows=10000,col.names = names(maindf))


thutosat$Time<- as.character(thutosat$Time)
thutosat$Date<-as.Date(as.character(thutosat$Date),"%d/%m/%Y")

#Subset with respect to dates
thutosat<-subset(thutosat, Date=="2007/2/1" | Date== "2007/2/2")

#Create new variable with date and time together
thutosat$DateTime<-paste(thutosat$Date,thutosat$Time," ")

#Avoid incomplete cases
thutosat<-thutosat[thutosat$Global_active_power!="?",]

#Convert DateTime to time format
thutosat$DateTime<-as.POSIXct(thutosat$DateTime, format="%Y-%m-%d %H:%M:%S")

thutosat$Global_active_power<-as.numeric(as.character(thutosat$Global_active_power))

png("plot4.png")

par(mfrow=c(2,2))

plot(thutosat$DateTime,thutosat$Global_active_power,xlab="",ylab="Global Active Power (kilowatts)","n")
lines(thutosat$DateTime,thutosat$Global_active_power)
plot(thutosat$DateTime,thutosat$Voltage,xlab="datetime",ylab="Voltage","n")
lines(thutosat$DateTime,thutosat$Voltage)

plot(thutosat$DateTime,thutosat$Sub_metering_1,xlab="", ylab="Energy sub metering","n",ylim=c(0,50),yaxs="i",frame.plot = TRUE)
lines(thutosat$DateTime,thutosat$Sub_metering_1,col="black")
lines(thutosat$DateTime,thutosat$Sub_metering_2,col="red")
lines(thutosat$DateTime,thutosat$Sub_metering_3,col="blue")
#plot(thutosat$DateTime,thutosat$Sub_metering_2,xlab="", ylab="Energy sub metering","n",ylim=c(0,40),yaxs="i",frame.plot = TRUE)
#plot(thutosat$DateTime,thutosat$Sub_metering_3,xlab="", ylab="Energy sub metering","n",ylim=c(0,40),yaxs="i",frame.plot = TRUE)
legend("topright",col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1),cex=0.8, pt.cex = 1,bty="n")

plot(thutosat$DateTime,thutosat$Global_reactive_power, xlab="datetime",ylab="Global_reactive_power","n")
lines(thutosat$DateTime,thutosat$Global_reactive_power)

dev.off()