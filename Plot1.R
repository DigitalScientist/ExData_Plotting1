

#For the whole assignment: 

#I could not change the language of the weekdays. This is because my OS is in spanish. 
#"Jue" stands for "Jueves", which is Thusrday in english (Thu). Same happens with "vie" (viernes), 
#which is Friday and "sáb" (sabado), which translates to saturday.  


#This is just for the second command
maindf<-read.table("household_power_consumption.txt",sep=";",head=TRUE,nrows=2)

#Partially import from source
thutosat<-read.table("household_power_consumption.txt",sep=";",head=TRUE,skip=63250,nrows=10000,col.names = names(maindf))


#thutosat$Time<-strptime(thutosat$Time,format= "%H:%M:%S")
thutosat$Date<-as.character(thutosat$Date) #"%y/%m/%d")

#Subset to relevant dates
thutosat<-subset(thutosat, Date=="1/2/2007" | Date== "2/2/2007")

#Avoid incomplete cases
thutosat<-thutosat[thutosat$Global_active_power!="?",]

#thutosat<-thutosat[weekdays(thutosat$Date)=="jueves" | weekdays(thutosat$Date)=="viernes" | weekdays(thutosat$Date)=="sábado" , ] #& thutosat$Global_reactive_power!="?" & thutosat$Voltage!="?" & thutosat$Global_intensity!="?" & thutosat$Sub_metering_1!="?" & thutosat$Sub_metering_2!="?" & thutosat$Sub_metering_3!="?", ]

#In order to make the histogram
thutosat$Global_active_power<-as.numeric(as.character(thutosat$Global_active_power))

png("plot1.png")

hist(thutosat$Global_active_power,col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)")

dev.off()
