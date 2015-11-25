?rnorm
?dnorm
?pnorm

x <- 1:5
dnorm(x, mean = 0, sd =1, log = FALSE)

x <- rnorm(10)
x

# generate random normal variables with mean 20 and standard 
# deviation 2
x <- rnorm(10, 20, 2)

rnorm(5)

set.seed(1)
rnorm(5)

# random variables from Poisson data
# 
rpois(10, 1)
rpois(10, 2)

## Commulative distribution
## 
ppois(2,2)
ppois(2, 4)
