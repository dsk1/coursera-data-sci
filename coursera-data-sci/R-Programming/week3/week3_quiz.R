## 1 
# Take a look at the 'iris' dataset that comes with R. The data can be loaded with the code:
# library(datasets)
# data(iris)
# A description of the dataset can be found by running
# ?iris
# There will be an object called 'iris' in your workspace. In this dataset, what is the mean of 'Sepal.Length' for the species virginica? (Please only enter the numeric result and nothing else.)
# library(iris)

library(datasets)
data(iris)
?iris
str(iris)
names(iris)
head(iris)
?factor
factor(iris$Species)
iris$Species
unique(iris$Species)

# solution
iris[iris$Species == "virginica",]$Sepal.Length
mean(iris[iris$Species == "virginica",]$Sepal.Length)

# Or
mean(iris$Sepal.Length[iris$Species == 'virginica'])

## Question 2
# Continuing with the 'iris' dataset from the previous Question, what R code returns a vector of the means of the variables 'Sepal.Length', 'Sepal.Width', 'Petal.Length', and 'Petal.Width'?

?colMeans
head(iris)
?apply

# Solution
colMeans(iris[, 1:4])

apply(iris[,1:4], 2, mean)

# Question 3
# Load the 'mtcars' dataset in R with the following code
# library(datasets)
# data(mtcars)
# There will be an object names 'mtcars' in your workspace. You can find some information about the dataset by running
# ?mtcars
# How can one calculate the average miles per gallon (mpg) by number of cylinders in the car (cyl)?

data(mtcars)
str(mtcars)
unique(mtcars$cyl)
mtcars$mpg

?split
s <- split(mtcars$mpg, mtcars$cyl)   # split the mpg by cylinder. returns a list grouped by cyl.
s
lapply(s, mean) # apply mean on the list
sapply(s, mean) # reformat

?tapply


s <- split(mtcars, mtcars$cyl)

lapply(s, function(x) colMeans(x[, c("mpg", "hp")], na.rm = TRUE )) # incorrect
sapply(s, function(x) colMeans(x[, c("mpg", "hp")], na.rm = TRUE )) # incorrect

tapply(mtcars$mpg, mtcars$cyl, mean) # correct

# Question 4
# Continuing with the 'mtcars' dataset from the previous Question, 
# what is the absolute difference between the average horsepower of 4-cylinder cars and the average horsepower of 8-cylinder cars?

tapply(mtcars$hp, mtcars$cyl, mean) # and calculate manually

# Or
s <- split(mtcars, mtcars$cyl)
s
mean(s$"4"$hp)

abs(mean(s$`4`$hp) - mean(s$`8`$hp))

# Or
abs(mean(mtcars$hp[mtcars$cyl == 4]) - mean(mtcars$hp[mtcars$cyl == 8])) # correct

# Question 5
# If you run
# debug(ls)
# what happens when you next call the 'ls' function?

debug(ls)
ls()
