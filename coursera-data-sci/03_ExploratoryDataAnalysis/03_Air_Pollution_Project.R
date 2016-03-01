getwd()
setwd("C:/RWDir/coursera-data-sci/coursera-data-sci/03_ExploratoryDataAnalysis/")

# read the files
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

str(NEI)
head(NEI)
str(SCC)
head(SCC)
install.packages("plyr")
library(plyr)

yrtotals <- ddply(NEI, "year", summarise,
                  total = sum(Emissions))
head(yrtotals)
yrtotals
plot(yrtotals$year, yrtotals$total)

