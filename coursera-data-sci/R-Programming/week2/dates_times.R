# Date function
# Dates uses Date class
x <- as.Date("1970-01-01")

weekdays(x)

months(x)

quarters(x)

# time stored as integer
x <- Sys.time()

#Times use the POSIXct and POSIXlt class
# time stored as a list 
p <- as.POSIXlt(x)

# Times in R
#strptime() conversts characters to POSIXlt time format
datestring <- c("November 16, 2015 16:05", "December 9, 2014 9:10")
x <- strptime(datestring, "%B %d, %Y %H:%M")

x <- as.Date("2013-11-16")

y <- strptime("November 16, 2015 16:05", "%B %d, %Y %H:%M")

x - y

x <- as.POSIXlt(x)

#Date keeps track of leap years, leap seconds, dts, timezones etc
x <- as.Date("2012-03-01")
y <- as.Date("2012-02-28")

x-y

# timezones
x <- as.POSIXct("2015-11-16 01:00:00")

y <- as.POSIXct("2015-11-16 06:00:00", tz = "GMT" )

x -y 


