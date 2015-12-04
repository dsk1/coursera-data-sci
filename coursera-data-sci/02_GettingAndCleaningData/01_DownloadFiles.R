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
download.file(fileUrl, destfile = "./data/cameras2.xlsx", mode = 'wb') # download the excel file as a binary file

# install xlsx pacakge for reading excel file
install.packages("xlsx")
library(xlsx)

cameraData <- read.xlsx("./data/cameras2.xlsx", sheetIndex = 1, header = TRUE)

head(cameraData)
str(cameraData)

colIndex <- 2:3
rowIndex <- 1:4

cameraDataSubset <- read.xlsx("./data/cameras2.xlsx", sheetIndex = 1, colIndex = colIndex
                              , rowIndex = rowIndex)
cameraDataSubset

## Reading xml file
## REad a sample xml file on the internet 
## Read menu items and prices
library(XML)
fileUrl <- "http://www.w3schools.com/xml/simple.xml"
doc <- xmlTreeParse(fileUrl, useInternal = TRUE)

rootNode <- xmlRoot(doc)
xmlName(rootNode)
names(rootNode)

# accessing parts of the xml document
rootNode[[1]]

rootNode[[1]][[2]]

# programmatically extract parts of the file
xmlSApply(rootNode, xmlValue)

xpathSApply(rootNode, "//name", xmlValue)
xpathSApply(rootNode, "//price", xmlValue)

## Read nfl team names. ## not working. ## But this is an example
fileUrl <- "http://espn.go.com/nfl/team/_/name/bal/baltimore-ravens"
doc <- htmlTreeParse(fileUrl, useInternal = TRUE)
scores <- xpathSApply(doc, "//li[@class='score']", xmlValue)
teams <- xpathSApply(doc, "//li[@class=team-name]", xmlValue)

scores
teams

## Reading JSON file
library(jsonlite)
jsonData <- fromJSON("https://api.github.com/users/jtleek/repos")
names(jsonData)
jsonData$name

jsonData$owner
names(jsonData$owner)
jsonData$owner$login

myjson <- toJSON(iris, pretty = TRUE)
cat(myjson)

iris2 <- fromJSON(myjson)
head(iris2)
