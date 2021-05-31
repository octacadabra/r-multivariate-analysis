# Hierarchichal Clustering (Agglomerative, Complete Linkage)

# install dplyr (mtcars dataset comes with the dplyr package)
install.packages("dplyr")
library(dplyr)

# install NbClust (to get the total of cluster)
install.packages("NbClust")
library(NbClust)

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

# distance matrix (using dist, euclidean method)
dist <- dist(mydata, method = "euclidean")

# cluster matrix (using hclust)
clust <- hclust(dist)
clust

# cluster matrix plot
plot(clust)

# getting the total of cluster
NbClust(mtcars, method = 'complete', index = 'hartigan')$Best.nc

# adding red box to clarify each cluster
rect.hclust(clust, k = 3, border = 'red')

# compare the mean of each cluster
round(aggregate(mtcars, FUN = mean, by = list(cut)), 1)

# add the new variable (number of cluster) to the dataset
cut <- cutree(clust, k = 3)
mydatas <- cbind(mydata, cut)
head(mydatas)
