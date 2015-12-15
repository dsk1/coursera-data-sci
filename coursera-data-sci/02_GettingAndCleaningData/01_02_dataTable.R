install.packages("data.table")
library(data.table)

DF = data.frame(x = rnorm(9), y = rep(c("a", "b", "c"), each=3), z = rnorm(9))
DT = data.table(x = rnorm(9), y = rep(c("a", "b", "c"), each=3), z = rnorm(9))

DF
DT
tables()

# Subsetting rows
DT[2,]
DT[DT$y=="a",]
DT[c(2,3)]

# subsetting columns
DT[, c(2,3)] # this does not subset the columns
DT

# use expressions to subset columns
{
x = 1
y = 2
}
k = {print(10); 5}
print(k)

DT[,list(mean(x),sum(z))]
DT[,table(y)]

x
y
z

DT[, list(mean(x), sum(z))]
DT[, table(y)]
# adding new column
DT[, w:=z^2]

# COPYING data table
# adding new column

DT2 <- DT
DT[, y:=2] # this will not work as desired. so use copy function
head(DT, n = 3)
head(DT2, N=3)

DT2 <- copy(DT)
DT[, p:=1]
DT
DT2

# Multiple operations on DATA Table
DT[, m:= {tmp <- (x+z); log2(tmp+5)}]
DT

# plyr like operations (grouping based on condition)
DT[, a:=x>0]
DT
DT[, b:= mean(x+w), by=a]
DT

# special variables to count()
# .N
set.seed(123)
DT <- data.table(x=sample(letters[1:3], 1E5, TRUE))
DT
head(DT)
DT[, .N, by=x]

# keys in data table
DT <- data.table(x=rep(c()))

DT <- data.table(x=rep(c("a", "b", "c"), each=100), y=rnorm(300))
DT

# Where clause after setting key
setkey(DT, x)
DT['a']


# merging tables
DT1 <- data.table(x=c('a', 'b', 'c', 'd'), y=1:4)
DT1
DT2 <- data.table(x=c('a', 'b', 'p'), Z=5:7)
DT2

merge(DT1, DT2) # Errors because there is no key set in the tables
setkey(DT1, x); setkey(DT2,x)
merge(DT1, DT2)


# Fast reading from the disk
