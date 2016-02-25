library(ggplot2)
str(mpg)
?qplot

# qplot()
# looks for data in a data frame, similar to lattice,
# or in the parent environment
# plots = aesthetics(size, shape, color) and geoms(points, lines)
# Factors are important for indicating subsets of the data

qplot(x = displ, y = hwy, data = mpg)

## factor the data with color
qplot(x = displ, y = hwy, data = mpg, col = drv)

## add statistics with geom
qplot(x = displ, y = hwy, data = mpg, geom = c("point", "smooth"))

qplot(x = hwy, data = mpg, fill = drv)

?qplot

qplot(x = displ, y = hwy, data = mpg, facets = .~drv)

# facets are for panels
# rows~cols
qplot(x = hwy, data = mpg, facets = drv~.)

# explore the Mouse Allergen and Asthma data
# download the data 
getwd()
fileURL <- "https://github.com/lupok2001/datasciencecoursera/blob/master/maacs.Rda"
if(!file.exists("data")){dir.create("data")}
download.file(fileURL, destfile = "./data/maacs.Rda", mode = 'w')

# load data into data frame
load("./data/maacs.Rda")
str(maacs)

# eno - exhaled nitrogen oxide. shows inflamation.
# pm25 - less than 2.5 micro diameter dust particle
# mopos - a mouse positive indicator. whether they are allergitic to mouse allergen. yes/no.

qplot(x = log(eno), data = maacs, fill = mopos)

# view statistics
qplot(x = log(eno), data = maacs, geom = "density")
qplot(x = log(eno), data = maacs, geom = "density", col = mopos)

# view scatter plots - view relations
qplot(x = log(pm25), y = log(eno), data = maacs, col = mopos, 
      geom = "smooth", method = "lm")

qplot(x = log(pm25), y = log(eno), data = maacs, col = mopos, 
      geom = c("point", "smooth"), method = "lm")

qplot(x = log(pm25), y = log(eno), data = maacs, facets = mopos~., 
      geom = c("point", "smooth"), method = "lm")

qplot(x = log(pm25), y = log(eno), data = maacs, facets = .~mopos, 
      geom = c("point", "smooth"), method = "lm")

# ggplot in depth
str(maacs)
qplot(x = logpm25, y = NocturnalSympt, data = maacs, facets = .~bmicat)

qplot(x = logpm25, y = NocturnalSympt, data = maacs, facets = .~bmicat,
      geom = c("point", "smooth"), method = "lm")

## GGPlot allows you to make all custom plots

## Components of GGPlot ##########
#
# data frame
# aesthetic mapping
# geoms: geometric objects like points, lines, shapes
# facets: for conditional plots
# stats: statistical transformations like binning, quantiles, smoothing
# scales: what scale an aesthetic map uses (ex: male = red, female = blue)
# coordinate system
#
# Plot the data -> overlay summary -> metadata and annotation


# store ggplot object and develop it in steps or layers
## take the data into the plot first
## use aes() to define the aesthetics
## 
g <- ggplot(maacs, aes(logpm25, NocturnalSympt))

g ## will error - no layer in plot. 
        ## as it doesnt yet know how to plot the data as points or lines

# add layer of points
p <- g + geom_point()
p ## auto print
print(p)

# keep adding more things such as geoms
g + geom_point() + geom_line()

g + geom_point() + geom_smooth()

# linear model
g + geom_point() + geom_smooth(method = "lm")

# add facets
g + geom_point() + geom_smooth(method = "lm") + facet_grid(. ~ bmicat)

# Change other things such as color
g + geom_point(col = "steelblue", size = 4, alpha = 1/2) + geom_smooth(method = "lm") + facet_grid(. ~ bmicat)

# use aes() to define the aesthetics again
g + geom_point(aes(col = bmicat), size = 4, alpha = 1/2)

g + geom_point(aes(col = bmicat)) + labs(title = "MAACS Cohort") + labs(x = expression("log  " * PM[2.5]), y = "Nocturnal Symptoms")  + geom_smooth(size =4, method = "lm", linetype = 3, se= FALSE)

## change the theme
g + geom_point(aes(col = bmicat)) + theme_bw(base_family = "Times")


#### About Axis Limits - Removing Outliers ####
#### 
# create some test data
testdata <- data.frame(x = 1:100, y = rnorm(100))

# add outlier
testdata[50,2] <- 100

# just exlore the data
plot(testdata$x)
plot(testdata$y)
?plot
plot(testdata$x, testdata$y, type = "l")

# view limited data
plot(testdata$x, testdata$y, type = "l", ylim = c(-3, 3))

# plot it using ggplot

g <- ggplot(testdata, aes(x = x, y = y))
print(g) ## layers not added. this will error I think.

# add layer and print
g + geom_line()

# now, remove the outlier
# 
# 2 types
# outlier missing
g + geom_line() + ylim(-3, 3)

# outlier included
g + geom_line() + coord_cartesian(ylim = c(-3, 3))

#### More complex example ####
# Categorized the data on NO2. NO2 is continuous. 

## Calculate the deciles of the data
# 0%, 33%, 66%, 100
cutpoints <- quantile(maacs$logno2_new, seq(0, 1, length = 4), na.rm = TRUE)
cutpoints

## cut the data into deciles and create a new factor variable
maacs$no2dec <- cut(maacs$logno2_new, cutpoints)

## see the levels of the newly created factor variable
levels(maacs$no2dec)

# Now plot the maacs Nocturnal symptoms relation with pm25
# for bmi and no2 categories
g <- ggplot(data = maacs, aes(x = logpm25, y = NocturnalSympt))
g + geom_point()
g + geom_point() + facet_grid(bmicat ~ .)
g + geom_point() + facet_grid(bmicat ~ no2dec)
g + geom_point() + facet_grid(bmicat ~ no2dec) + geom_smooth(method = "lm")

g + geom_point(alpha = 1/3) + facet_grid(bmicat ~ no2dec) + geom_smooth(method = "lm", se = FALSE, col = "steelblue") + theme_bw(base_family = "Avenir", base_size = 10) + labs(title = "MAACS Cohort", x = expression("log " * PM[2.5]), y = "Nocturnal Symptoms")

g + geom_point(alpha = 1/3) + facet_wrap(bmicat ~ no2dec, nrow = 2, ncol = 4) + geom_smooth(method = "lm", se = FALSE, col = "steelblue") + theme_bw(base_family = "Avenir", base_size = 10) + labs(title = "MAACS Cohort", x = expression("log " * PM[2.5]), y = "Nocturnal Symptoms")


