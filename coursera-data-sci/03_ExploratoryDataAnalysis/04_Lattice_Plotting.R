library(lattice)
xyplot(y ~ x | f * g, data) # f and g are categorical variables

library(datasets)
xyplot(Ozone ~ Wind, data = airquality)

airquality <- transform(airquality, Month = factor(Month))
xyplot(Ozone ~ Wind | Month, data = airquality, layout = c(5, 1))

# example
set.seed(10)      
x <- rnorm(100)
f <- rep(0:1, each = 50)
y <- x + f - f * x + rnorm(100, sd = 0.5)
f <- factor(f, labels = c("Group 1", "Group 2"))

xyplot(y ~ x | f, layout = c(2,1))

# customization using panel functions
xyplot(y ~ x | f, panel = function(x, y, ...){
        panel.xyplot(x, y, ...) ## First call default panel function
        #panel.abline(h = median(y), lty = 2) ## add a median of y values
        
        panel.lmline(x, y, col = 2) ## add a regression line
})
