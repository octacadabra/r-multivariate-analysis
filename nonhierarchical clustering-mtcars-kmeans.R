# install dplyr (mtcars dataset comes with the dplyr package)
install.packages("dplyr")
library(dplyr)

# load mtcars data
data("mtcars")

# exclude the to categorical variables (vs and am)
mydata <- mtcars[c(1:7,10,11)]
head(mydata)

# data preparation
# checking missing value (there's no missing value)
summary(is.na(mydata))

# data standardization (using scale)
mydata <- scale(mydata)

# determine the total of clusters (using elbow and silhouette coefficient)
# elbow method
library(factoextra)
fviz_nbclust(mydata, kmeans, method = "wss")

# elbow method (other way) (we get k = 2 or 4/subjective)
wss <- (nrow(mydata)-1) *sum(apply(mydata,2,var))
for (i in 2:15) wss[i] <- sum(kmeans(mydata, centers=i)$withinss)
plot(1:15, wss, type="b", xlab="Number of Clusters", ylab="Within groups sum of squares")

# silhouette method (we get k = 2)
fviz_nbclust(mydata, kmeans, method="silhouette")

# k-means clustering
clustt <- kmeans(mydata,2)
clustt

# cluster plot
library(cluster)
clusplot(mydata, clustt$cluster, color=TRUE, shade=TRUE, labels=2, lines=0)

# add the new variable (number of cluster) to the dataset
mydatas <- data.frame(mydata, clustt$cluster)
head(mydatas)