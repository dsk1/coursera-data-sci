getwd()
outcome <- read.csv("outcome-of-care-measures.csv", colClasses = 'character')
head(outcome)
str(outcome)
ncol(outcome)
nrow(outcome)
names(outcome)

outcome[, "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack"]

outcome[, 11] <- as.numeric(outcome[,11])
outcome[, 11]

hist(outcome[, 11])
