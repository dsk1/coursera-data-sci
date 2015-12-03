getwd()

# 
# setwd("./02_GettingAndCleaningData")
# check and create directory
if(!file.exists("data")){
  dir.create("data")
}

# Download csv file
fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl,destfile="./data/cameras.csv")
list.files("./data")
dateDownloaded <- date()
dateDownloaded

# read the csv file using read.table()
cameraData <- read.table("./data/cameras.csv", sep=",", header = TRUE)
head(cameraData)

# Whereas read.csv sets sep="," and header TRUE
head(cameraData)


# Download Excel file
getwd()
if(!file.exists("data")){dir.create("data")}
fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.xlsx?accessType=DOWNLOAD"

install.packages("xlsx")
library(xlsx)
library(gdata)
