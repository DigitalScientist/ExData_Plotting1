
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

png("plot3.png")

plot(thutosat$DateTime,thutosat$Sub_metering_1,xlab="", ylab="Energy sub metering","n",ylim=c(0,40),yaxs="i",frame.plot = TRUE)
plot(thutosat$DateTime,thutosat$Sub_metering_2,xlab="", ylab="Energy sub metering","n",ylim=c(0,40),yaxs="i",frame.plot = TRUE)
plot(thutosat$DateTime,thutosat$Sub_metering_3,xlab="", ylab="Energy sub metering","n",ylim=c(0,40),yaxs="i",frame.plot = TRUE)



#axis.POSIXct(side=1, x = "" , at = weekdays(thutosat$Date),format="%d") 

lines(thutosat$DateTime,thutosat$Sub_metering_1,col="black")
lines(thutosat$DateTime,thutosat$Sub_metering_2,col="red")
lines(thutosat$DateTime,thutosat$Sub_metering_3,col="blue")

legend("topright",col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1))


dev.off()