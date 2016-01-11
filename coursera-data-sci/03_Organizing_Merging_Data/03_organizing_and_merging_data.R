set.seed(13435)
x <- data.frame("var1"=sample(1:5), "var2"=sample(6:10), "var3"=sample(11:15))
x
x<- x[sample(1:5),]; x$var2[c(1,3)] = NA
x

# subsetting 
x[,1]
x[, "var1"]

# Where clause with &, |
x[(x$var1 <= 3 & x$var3 > 11),]

# Dealing with missing values
# Where clause

x[x$var2>8,] # this will return NAs as well

x[which(x$var2>8),]

# ordering
x[order(x$var1),]


# ordering with plyr package
# 
library(plyr)
arrange(x, var1)
arrange(x, desc(var1))

# add new column
x$var4 <- rnorm(5)
x

# another way of adding column
y <- cbind(rnorm(5), x)
y
y <- cbind(x, rnorm(5))
y
