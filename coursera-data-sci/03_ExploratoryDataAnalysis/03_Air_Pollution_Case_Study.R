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
summary(x1)
summary(x0)

# about 5% are missing
mean(is.na(x0))
mean(is.na(x1))

# see the sample.values in relation to each other on box plot
boxplot(x0, x1)

boxplot(log10(x0), log10(x1))
