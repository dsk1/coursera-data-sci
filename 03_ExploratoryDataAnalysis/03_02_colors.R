pal <- colorRamp(c("red", "blue"))
pal
pal(0) ## red
pal(1) ## blue
pal(0.5) ## half red and half blue

pal(seq(0, 1, len = 10))
seq(0,1, len = 11)


#### color Ramp palette ####
pal <- colorRampPalette(c("red", "yellow"))
pal
pal(2) ## two ends in the spectrum
pal(10) ## 10 color shades including both ends

### RColorBrewer ####
## provides palettes for ..
## sequential palettes = for ordered and numerical data
## divergent palettes = for plotting means etc. left -ve, right is +ve
## qualitative palettes = unordered and different values

library(RColorBrewer)
cols <- brewer.pal(3, "BuGn") # number of colors and name of palette
cols
pal <- colorRampPalette(cols)
image(volcano, col = pal(20))
str(volcano)

## for high order scatter plot
x <-rnorm(10000)
y <-rnorm(10000)

plot(x,y) # base plotting sys
qplot(x, y) ##ggplot sys
xyplot(x~y) ## lattice sys

smoothScatter(x,y)


## other functions ####
# rgb can be used to produce any color via red, green, blue and alpha
# 
# 
?plot
plot(x,y, pch =19)
plot(x,y, pch =19, col = rgb(0.75, 0.75, 0, 0.2))

