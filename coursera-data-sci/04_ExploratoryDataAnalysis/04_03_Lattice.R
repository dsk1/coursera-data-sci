library(lattice)
library(datasets)

xyplot(Ozone ~ Wind, data = airquality)


# simple lattice plot

airquality <- transform(airquality, Month = factor(Month))
xyplot(Ozone ~ Wind | Month, data = airquality, layout(1,5))

# saving in a variable
p <- xyplot(Ozone ~ Wind, data = airquality)
print(p)
