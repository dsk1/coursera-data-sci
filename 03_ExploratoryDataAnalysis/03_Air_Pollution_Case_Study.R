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
mean(is.na(x0))

pm1 <- read.table("./data/RD_501_88101_2012-0.txt", comment.char = "#", header = FALSE, sep = "|", na.strings = "")
head(pm1)
dim(pm1)

# load and cleanup column names 
cnames <- readLines("./data/RD_501_88101_2012-0.txt", 1)
cnames
strsplit(cnames, "|", fixed = TRUE)
strsplit(cnames, "|", fixed = TRUE)[[1]]
cnames
cnames <- strsplit(cnames, "|", fixed = TRUE)[[1]]
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
mean(is.na(x0))
mean(is.na(x1))

# see the sample.values in relation to each other on box plot
boxplot(x0, x1)

boxplot(log10(x0), log10(x1))

# pluck out the negative values and see what we can tell
negative1 <- x1 < 0
sum(negative1, na.rm = TRUE)
sum(x1) # 26K
mean(negative1, na.rm = TRUE) # only 2%

# lets take a look at the other values of negative values
# for example when are these -ve values occuring?
# lets look at the date variable.
# 

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

site0 <- unique(subset(pm0, State.Code == 36, c(County.Code, Site.ID)) )
site1 <- unique(subset(pm1, State.Code == 36, c(County.Code, Site.ID)) )

site0 <- paste(site0[,1], site0[,2], sep = ".")
site1 <- paste(site1[,1], site1[,2], sep = ".")

head(site0)
head(site1)

str(site0) # 33 monitors
str(site1) # 18 monitors

intersect(site0, site1)

bothyrmonitor <- intersect(site0, site1)

bothyrmonitor

# pick out one monitor/site's data from both years in NY
# first create the county.site column in pm data
pm0$county.site <- with(pm0, paste(County.Code, Site.ID, sep = "."))
pm1$county.site <- with(pm1, paste(County.Code, Site.ID, sep = "."))

# pickout the data that is for the monitory in bothyrsmonitor

