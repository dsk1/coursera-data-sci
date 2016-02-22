dataFrame <- data.frame(x, y)
x
y

kmeansObje <- kmeans(dataFrame, centers = 3)
names(kmeansObje)

kmeansObje$cluster

par(mar = rep(0.2, 4))
plot(x, y, col = kmeansObje$cluster, pch = 19, cex = 2)
points(kmeansObje$centers, col = 1:3, pch = 3, cex = 3, lwd = 3)


#### Heatmaps fo rclustering ####
set.seed(1234)
dataMatrix <- as.matrix(dataFrame)[sample(1:12),]
kmeansObje2 <- kmeans(dataMatrix, centers = 3)
par(mfrow = c(1,2), mar = c(2, 4, 0.1, 0.1))
image(t(dataMatrix)[, nrow(dataMatrix):1], yaxt = "n")

image(t(dataMatrix)[, order(dataMatrix):1], yaxt = "n")
