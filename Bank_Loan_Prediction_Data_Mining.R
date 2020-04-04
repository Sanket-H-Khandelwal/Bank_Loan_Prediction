#Installing the required libraries 
install.packages('tidyverse')
install.packages('factoextra')
install.packages("rpart")
install.packages("caret")
install.packages("ggplot2")
install.packages("dplyr")
install.packages("randomForest")
install.packages("caTools")
library(caTools)
library(randomForest)
library('cluster')
library('tidyverse')
library('factoextra')
library(rpart)
library(caret)
library(ggplot2)
library(dplyr)

#Loading the data 
getwd()
bank<-read.csv(file.choose(), header = T)
bank
View(bank)

#To check the NA values
sapply(bank,function(x){sum(is.na(x))}) # counts the number of NA values inthe dataset


#Removing the unwanted column 
bank1<-bank1[,-c(8)]
View(bank1)
#Converting the categorical variables to numerical variables 
bank1$marital= factor(bank1$marital, levels = c('single','married','divorced'),labels = c(0,1,2))
bank1$education= factor(bank1$education, levels = c('primary','secondary','tertiary'),labels = c(0,1,2))
bank1$loan= factor(bank1$loan, levels = c('no','yes'),labels = c(0,1))
bank1$default= factor(bank1$default, levels = c('no','yes'),labels = c(0,1))
bank1$housing= factor(bank1$housing, levels = c('no','yes'),labels = c(0,1))


#Removing the unwanted column 
bank1<-bank[,-c(2,9,10,11,12,13)]
View(bank1)
bannk<-class(bank1)
# we will use  as. numeric() to convert a factor to a numeric vector
bank1$age<-as.numeric(bank1$age)
bank1$marital<-as.numeric(bank1$marital)
bank1$education<-as.numeric(bank1$education)
bank1$default<-as.numeric(bank1$default)
bank1$balance<-as.numeric(bank1$balance)
bank1$housing<-as.numeric(bank1$housing)



#We will be performing min-max scaling inorder to to avoid the problem we bringthe dataset to a common scale (between 0 and 1) while keeping the distributions of variables the same
normalize<-function(x){
  return((x-min(x))/(max(x)-min(x)))
}

bank2<-as.data.frame(lapply(bank1[1:6],normalize))
summary(bank2)


#We will implement the logistic regression model
logsts<-glm(loan~.,bank1,family = "binomial")
summary(logsts)
myrslts<-predict(logsts,bank1,type="response")
myrslts
plot(bank1$education,bank1$loan,pch=1,xlab="Education",ylab="Loan")



# We will now implement the kmeans clustering algorithm
fit <- kmeans(bank1, 5) #5 cluster solution
aggregate(bank1,by=list(fit$cluster),FUN=mean) #get cluster means 
mydata1 <- data.frame(bank1, fit$cluster) #append cluster assignment
fviz_cluster(fit, data = bank1)+ ggtitle("cluster plot with k = 5") #plot clusters


#Here Decision Tree algorithm is implemented
# grow tree 
dtree <- rpart(age~ loan+education+marital+default+balance+
                 housing,method="class", data=bank1)
dtree$cptable
plotcp(dtree)

# Creating a correlation matrix
corrplot<-corrplot(cor(bank1[c(1,2,3,6)]), type="upper", order="hclust")
bank1<-as.numeric(bank1)



# trainControl for Random Forest
fitControl = trainControl(method = "repeatedcv", repeats = 5,
                          number = 5, verboseIter = T)

# Run a Random Forest classification over the training set
rf.fit <- train(loan ~ .,  data = bank1, method = "rf",
                importance = T, trControl = fitControl,
                tuneLength = 5)

