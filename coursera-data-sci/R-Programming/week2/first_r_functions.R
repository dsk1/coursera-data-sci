add2 <- function(x,y){
  x + y
}

above10 <- function(x){
  use <- x > 10
  x[use]
}

# default arguments
columnmean <- function(x, removeNA = FALSE){
  nc <- ncol(x)
  means <- numeric(nc)
  for(i in 1:nc){
    means[i] <- mean(x[ , i], na.rm = removeNA)
  }
  means
}

# Lazy evaluation 1
f <- function(a, b){
  a^2
}


# Lazy evaluation 2
f2 <- function(a, b){
  print(a)
  print(b)
}

# The "..." Argument
myplot <- function(x, y, type = "1", ...){
    plot(x, y, type = type, ...)
}

# existing ... arguments in existing functions
args(paste)
args(cat)