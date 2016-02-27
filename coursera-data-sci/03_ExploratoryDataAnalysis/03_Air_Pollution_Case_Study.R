# AIR POLLUTION CASE STUDY

getwd()
setwd("c:\\RWDir/coursera-data-sci/03_ExploratoryDataAnalysis")
if(!file.exists("data")){
  dir.create("data")
}
getwd()

# download file
fileUrl <- "https://raw.githubusercontent.com/jtleek/modules/master/04_ExploratoryAnalysis/CaseStudy/pm25_data/RD_501_88101_1999-0.txt"
file2Url <- "https://raw.githubusercontent.com/jtleek/modules/master/04_ExploratoryAnalysis/CaseStudy/pm25_data/RD_501_88101_2012-0.txt"


download.file(fileUrl, destfile = "./data/RD_501_88101_1999-0.txt")
download.file(file2Url, destfile = "./data/RD_501_88101_2012-0.txt")

list.files("./data")

#####################
# read the first file (exclude header line)
pm0 <- read.table("./data/RD_501_88101_1999-0.txt", comment.char = "#", header = FALSE, sep = "|", na.strings = "")
dim(pm0) 
head(pm0)

# read the columnames present in first line
cnames <- readLines("./data/RD_501_88101_1999-0.txt", 1)
cnames

# split the first line into column names
cnames <- strsplit(cnames, "|", fixed = TRUE)
cnames[[1]]

# assign to the variable names of data table
names(pm0) <- cnames[[1]]

# look at the data
head(pm0)

# remove spaces, replace with dots in the variable names
names(pm0) <- make.names(cnames[[1]])

# see the sample.value variable
x0 <- pm0$Sample.Value
class(x0)
summary(x0)

# see the proportion of missing values. about 11% are missing.
mean(is.na(x0)) # 11% NAs

# read the second file (exclude the header line)
pm1 <- read.table("./data/RD_501_88101_2012-0.txt", comment.char = "#", header = FALSE, sep = "|", na.strings = "")
head(pm1)
dim(pm1)

# load and cleanup column names 
cnames <- readLines("./data/RD_501_88101_2012-0.txt", 1)
cnames
strsplit(cnames, "|", fixed = TRUE)
strsplit(cnames, "|", fixed = TRUE)[[1]]

cnames <- strsplit(cnames, "|", fixed = TRUE)[[1]]
# replace the spaces with dots
cnames <- make.names(cnames)
cnames

# assign the cnames to column names
names(pm1) <- cnames

head(pm1)

x1 <- pm1$Sample.Value
str(x1)
# see sample.value for both years
summary(x0)
summary(x1) # why is there -ve data?

# about 5% are missing
mean(is.na(x0)) #11%
mean(is.na(x1)) #5.5%

# see the sample.values in relation to each other on box plot
boxplot(x0, x1)

boxplot(log10(x0), log10(x1))

# pluck out the negative values and see what we can tell
negative1 <- x1 < 0
# How many are negative?
sum(negative1, na.rm = TRUE) #4.9 K

# how many total?
length(x1) #169k

# how many NAs
sum(is.na(x1)) #9.3k

# how many -ves
length(x1[x1<0 & !is.na(x1)]) #4.9 k
sum(x1<0, na.rm=TRUE) # 4.9k 

# remaining: non NAs and postivies
sum(x1>=0, na.rm = TRUE) #155.2K

summary(x1)
#% of NAs 
mean(is.na(x1))  # 5.5%

# % of -ves
mean(x1<0, na.rm = TRUE) # 3.1%


# lets take a look at the other variables of Negative or NA values
# for example when are these -ve values occuring?
# lets look at the date variable.
# 
# create a logical vector of negatives

negatives1 <- x1<0

# format the Date variable
str(pm1$Date)
dates1 <- pm1$Date
dates1 <- as.Date(as.character(dates1), "%Y%m%d" )
str(dates1)

# just take a look at the histogram of data around months
hist(dates1, "month")

# take a look at where the -ve values are occuring 
hist(dates1[negative1], "month") # lot of -ves in dec, jan, feb timeframe
# investigate the -ve values later as it is only 2% of the total data


##### analyze the pollution at one location #####
# pick out on monitor thats there in 1999 and 2012 and compare the two
# pick out the distinct counties and sites in New York state

# view the subset data for NY state
subset(pm0, State.Code ==36)
subset(pm1, State.Code ==36)

# create a vector of the subset data
site0 <- unique(subset(pm0, State.Code == 36, c(County.Code, Site.ID)) )
site1 <- unique(subset(pm1, State.Code == 36, c(County.Code, Site.ID)) )

# paste (concatinate) state and county to form a vector of unique keys
site0 <- paste(site0[,1], site0[,2], sep = ".")
site1 <- paste(site1[,1], site1[,2], sep = ".")

length(site0) # 33 monitors
length(site1) # 18 monitors

# intersect to get the sites monitored in both years
intersect(site0, site1)
bothyrmtrs <- intersect(site0, site1)

bothyrmtrs

# Now compare the 2 years data for these monitors
# pick out one monitor/site's data from both years in NY
# 
# first create the county.site column in pm data
# pm0$county.site <- paste(pm0$County.Code, pm0$Site.ID, sep = ".")
?with
pm0$county.site <- with(pm0, paste(County.Code, Site.ID, sep = "."))
pm1$county.site <- with(pm1, paste(County.Code, Site.ID, sep = "."))


# pickout the data that is for the monitor in bothyrsmonitor
site0sub <- subset(pm0, county.site %in% bothyrmtrs)
site1sub <- subset(pm1, county.site %in% bothyrmtrs)
# check the subset data
str(site0sub)
head(site0sub)

#pick a monitor that has the most readings in each year
# see how many readings are there at each monitor
split(site0sub, site0sub$county.site)
sapply(split(site0sub, site0sub$county.site), nrow)
sapply(split(site1sub, site1sub$county.site), nrow)

# pick county.site = 63.2008
mtr <- 63.2008
mtr0 <- subset(site0sub, county.site %in% mtr)
dim(mtr0)
mtr1 <- subset(site1sub, county.site %in% mtr)
dim(mtr1)

# compare pm2.5 values in both years at this monitor
# get the pm2.5 data out for y axis
pm0mtr <- mtr0$Sample.Value
pm1mtr <- mtr1$Sample.Value
length(pm0mtr)

# get the dates for x axis
pm0dates <- as.Date(as.character(mtr0$Date), "%Y%m%d")
str(pm0dates)
pm1dates <- as.Date(as.character(mtr1$Date), "%Y%m%d")
str(pm1dates)

# plot the data
plot(pm0dates, pm0mtr)
plot(pm1dates, pm1mtr)

par(mfrow = c(1,2), mar = c(4,4,2,1))
plot(pm0dates, pm0mtr, pch=20)
abline(h=median(pm0mtr, na.rm = TRUE))
plot(pm1dates, pm1mtr, pch=20)
abline(h=median(pm1mtr, na.rm = TRUE))

# Since the two year's data is in different ranges, fix it and plot them
# find the range of data
range(pm0mtr, pm1mtr, na.rm = T)
rng <- range(pm0mtr, pm1mtr, na.rm = T)
par(mfrow=c(1,2), mar = c(4,4,2,1))

plot(pm0dates, pm0mtr, pch=20, ylim = rng)
abline(h = median(pm0mtr, na.rm = T))

plot(pm1dates, pm1mtr, pch=20, ylim = rng)
abline(h = median(pm1mtr, na.rm = T))

# do another analysis
# compare avg of each state in two years
head(pm0)
str(pm0)

sapply(split(pm0, pm0$State.Code), avg(pm0$Sample.Value))
