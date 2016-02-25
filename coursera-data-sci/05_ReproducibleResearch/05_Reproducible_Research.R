install.packages("kernlab")
library(kernlab)

#### Exploratory data analysis ####
#### 
data(spam)
str(spam) # there are 4601 obs and 58 variables

# Names
names(spam)
# Head
head(spam)

# Subsampling our data set
set.seed(3435)
trainIndicator = rbinom(4601, size = 1, prob = 0.5)
table(trainIndicator)


trainSpam <- spam[trainIndicator ==1,] # create training data sub-sample
str(trainSpam) # 2287 obs.

testSpam <- spam[trainIndicator == 0, ] # create test data sub-sample
str(testSpam) # 2314 obs.

# Head
head(trainSpam)

# summaries
# look at the # of emails in each "type"
table(trainSpam$type) # 1381 spam and 906 non-spam

# Plot 1
# verify the number of avg capitol letters in spam vs non-spam emails
plot(trainSpam$capitalAve ~ trainSpam$type) # the data is skewed in the plot so try log()

# New Plot 2
plot(log10(trainSpam$capitalAve + 1) ~ trainSpam$type) # since there is 0 avg and log(0) is infinite add 1 to the avg

# Relationships between predictors
# plot pairwise relationship between four given words (predictors)
names(trainSpam[, 1:4]) 
plot(log(trainSpam[, 1:4]+1))


# Clustering
# what words tend to cluster together?
# For this plot a dendrogram

# Clustering example with small dataset
# understand how to plot dendrogram with a smaller dataset
trainSpam[1:3, 1:4]
t(trainSpam[1:3, 1:4])
dist(t(trainSpam[1:3, 1:4]))
hcluster <- hclust(dist(t(trainSpam[1:3, 1:4])))
hcluster <- hclust(dist(t(trainSpam[1:3, 1:4])))
plot(hcluster)
 
# Clustering 1
# take all 57 variables
names(trainSpam[, 1:57])
t(trainSpam[, 1:57]) # transpose the data for this
dist(t(trainSpam[, 1:57])) # calculate the distance between each
hcluster <- hclust(dist(t(trainSpam[, 1:57])))
plot(hcluster) # because the words are very close to each other take log. add 1 before log to avoid log(0)

# Clustering 2
log10(trainSpam[, 1:57]+1)
t(log10(trainSpam[, 1:57]+1))
dist(t(log10(trainSpam[, 1:57]+1)))
hcluster <- hclust(dist(t(log10(trainSpam[, 1:57]+1))))

plot(hcluster)

#### Statistical prediction/modeling ####
#### 

library(boot)
?cv.glm()

costFunction = function(x,y){
        sum(x != (y>0.5))
}
x<-1
y<-4
costFunction(0,0)
costFunction(0,1)
costFunction(0,0.6)
0.5>0.5
sum(0.4 != (0.5>0.5))
2 != TRUE
1 != TRUE
0.5 != TRUE
