# AIR POLLUTION CASE STUDY

getwd()
setwd("c:\\RWDir/coursera-data-sci/coursera-data-sci/03_ExploratoryDataAnalysis/data")
getwd()

pm0 <- read.table("RD_501_88101_1999-0.txt", comment.char = "#", header = FALSE, sep = "|", na.strings = "")

dim(pm0) 

head(pm0)

cnames <- readLines("RD_501_88101_1999-0.txt", 1)
cnames
cnames <- strsplit(cnames, "|", fixed = TRUE)
cnames[[1]]

names(pm0) <- cnames[[1]]

head(pm0)

names(pm0) <- make.names(cnames[[1]])

x0 <- pm0$Sample.Value
class(x0)
summary(x0)

# see the proportion of missing values. about 11% are missing.
mean(is.na(x0))

pm1 <- read.table("RD_501_88101_2012-0.txt", comment.char = "#", header = FALSE, sep = "|", na.strings = "")
head(pm1)
dim(pm1)

# load and cleanup column names 
cnames <- readLines("RD_501_88101_2012-0.txt", 1)
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
summary(x1)
summary(x0)

# about 5% are missing
mean(is.na(x1))

