# REading data from MySQL database
# connecting to a database on a mysql server

# create a connection handle

install.packages("RMySQL")
library(RMySQL)

ucscDb <- dbConnect(MySQL(), user= "genome", host = "genome-mysql.cse.ucsc.edu")
result <- dbGetQuery(ucscDb, "show databases;"); dbDisconnect(ucscDb);
head(result)

hg19 <- dbConnect(MySQL(), user= "genome", db = "hg19", host = "genome-mysql.cse.ucsc.edu")
allTables <- dbListTables(hg19)
allTables[1:5]
length(allTables)

# list the columns of a table
dbListFields(hg19, "affyU133Plus2")

# get number of rows in a table
dbGetQuery(hg19, "select count(*) from affyU133Plus2")

# read from table
affyData <- dbReadTable(hg19, "affyU133Plus2")

query <- dbSendQuery(hg19, "select * from affyU133Plus2 where misMatches between 1 and 3")
affyMis <- fetch(query); quantile(affyMis$misMatches)

# fetch some data only and clear the query thats sitting on the database
affyMisSmall <- fetch(query, n= 10); dbClearResult(query)
affyMisSmall
dbDisconnect(hg19)
