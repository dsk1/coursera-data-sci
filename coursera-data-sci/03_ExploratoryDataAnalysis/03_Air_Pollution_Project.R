getwd()
setwd("C:/RWDir/coursera-data-sci/coursera-data-sci/03_ExploratoryDataAnalysis/")
fileURL <- "http://d396qusza40orc.cloudfront.net/exdata-data-FNEI_data.zip"
if(!file.exists("./data")){
  dir.create("data")
}

download.file(fileURL, destfile = "./data/exdata-data-FNEI_data.zip")
