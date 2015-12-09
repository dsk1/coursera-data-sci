install.packages("data.table")
library(data.table)

DF = data.frame(x = rnorm(9), y = rep(c("a", "b", "c"), each=3), z = rnorm(9))
DT = data.table(x = rnorm(9), y = rep(c("a", "b", "c"), each=3), z = rnorm(9))
