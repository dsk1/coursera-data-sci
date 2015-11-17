# lapply converts the first parameter to list using as.list internally
# the return object is always of type list

x <- list (a = 1:5, b=rnorm(10))
lapply(x, mean)

x <- list(a = 1:4, b = rnorm(10), c = rnorm(20, 1), d = rnorm(100, 5))
lapply(x, mean)

# another way of calling with runif() and arguments to runif()
# lapply (x, func, ...)
runif(2)
x <- 1:4

lapply(x, runif)

#runif with arguments
lapply(x, runif, min = 5, max = 10)

## lapply with anonymous functions. 
# writing function on the spot if the function is not available
# function to get first column of matrix does not exist
# function goes away after the lapply

a = matrix(1:6, 3, 2)

# to extract first column of matrix
a[, 1]

# list of two matrices
x <- list(a <- matrix(1:6, 3, 2), b <- matrix(1:4, 2, 2))

# extract first column of the two matrices
lapply(x, function(elt) elt[ , 1])

## sapply
# Returns vector if length of each element in the result list is 1
# Returns matix if the result is a list where every element is a vector 
# of same length
# Returns list if it can't figure things out.
sapply(x, function(elt) elt[1, ]) # Returns matrix. two rows

x <- list(a = 1:4, b = rnorm(10), c = rnorm(20, 1))
sapply(x, mean) # Returns a vector of 3 means
sapply(x, mean, 2, 4) # Returns a vector of 3 means

## apply
x <- matrix(rnorm(300), 30, 10)

# Mean of columns. Gives 10 means.
# Preserve the columns (second dimension)
# Collapse rows. 
apply(x, 2, mean) 

# Mean of rows. Gives 30 means.
# Preserve the rows dimension. 
apply(x, 1, mean) 

# Following functions are faster than the above apply()
rowSums(x)
colSums(x)
rowMeans(x)
colMeans(x)

# Another use of apply()
x <- matrix(rnorm(200), 20, 10)
# Calculate quantiles (25% and 75%) of the rows
# Preserve row
# Pass quantile() function, Argumentn for quantile are probs
apply(x, 1, quantile, probs = c(0.25, 0.75))

# apply() on an array of 2x2 matrices
# 
#
x <- array(rnorm(2 * 2 * 10), c(2, 2, 10))
apply(x, c(1, 2), mean)

# The above can also be done using rowMeans()
rowMeans(x, dims = 2)

## mapply()
# mapply is used to apply functions to multiple sets of arguments

list(rep(1,4), rep(2, 3), rep(3, 2), rep(4, 1))

# mapply can be used instead of above statement
mapply(rep, 1:4, 4:1)

# another use of mapply
# get 5 random normal variables with mean 1 and 2 standard deviations
rnorm(5, 1, 2)

# get 4 random normal variables with mean 2 and 2 standard deviations
rnorm(4, 2, 2)

# get 1 random normal variables with mean 1 and 2 standard deviations
rnorm(1, 1, 2)

# get a vector list of random variables
# with above variations
# 1 random normals with mean 1
# 2 random normals with mean 2
# 3 random normals with mean 3
# 4 random normals with mean 4
# 5 random normals with mean 5
rnorm(1:5, 1:5, 2) # incorrect

noise <- function(n, mean, sd){
        rnorm(n, mean, sd)
}

noise(1:5, 1:5, 2)  # incorrect

mapply(noise, 1:5, 1:5, 2)

# above is same as 
list(
        noise(1, 1, 2),
        noise(2, 2, 2),
        noise(3, 3, 2),
        noise(4, 4, 2),
        noise(5, 5, 2)
)

# tapply() to factor(categorize) vectors based 
# on a factor vector
x <- c(rnorm(10), runif(10), rnorm(10,1))
f <- gl(3,10)

tapply(x, f, mean)

tapply(x, f, mean, simplify = FALSE)


tapply(x, f, range)

# split a vector or other objecs into groups
# determined by a factor or list of factors
# 
x <- c(rnorm(10), runif(10), rnorm(10,1))
f <- gl(3, 10)
split(x, f)

# another use of split + lapply
lapply(split(x, f), mean)

# another use of split
# split a dataframe into monthly pieces and calculate 
# column means on other variables
library(datasets)
head(airquality)

# split the dataframe into months
s <- split(airquality, airquality$Month)

lapply(s, length)

# return mean for the three variables
# Ozone, Solar.R, Wind columns for each month
lapply(s, function(x) colMeans(x[, c("Ozone", "Solar.R", "Wind")]))

sapply(s, function(x) colMeans(x[, c("Ozone", "Solar.R", "Wind")], na.rm = TRUE))

## Splitting on more than one level
# split on gender and race. on a combination.

x <- rnorm(10)
f1 <- gl(2, 5, labels = c("male", "female")) # twe levels, male and female
f2 <- gl(5, 2, labels = c("asian", "caucasian", "hispanic", "african", "unknown"))

# combination of levels in the two factors 
# these are the two grouping variables
# combine using interaction()
# 2 levels * 5 levels = 10 levels

interaction(f1, f2)

split(x, interaction(f1, f2))
str(split(x, interaction(f1, f2)))

# Or
list(f1, f2)

split(x, list(f1, f2))
str(split(x, list(f1, f2)))

# drop = TRUE drops empty observations
# Returns only those with values
str(split(x, list(f1, f2), drop = TRUE))









