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
df<-read.csv(file.choose(), header = T)
df
View(df)

#To check the NA values
sapply(df,function(x){sum(is.na(x))}) # counts the number of NA values inthe dataset

#Converting the categorical variables to numerical variables 
df$Marital= factor(df$Marital, levels = c('single','married','divorced'),labels = c(0,1,2))
df$Education= factor(df$Education, levels = c('primary','secondary','tertiary'),labels = c(0,1,2))
df$Loan_Status= factor(df$Loan_Status, levels = c('no','yes'),labels = c(0,1))
df$dDefault= factor(df$Default, levels = c('no','yes'),labels = c(0,1))
df$Housing= factor(df$Housing, levels = c('no','yes'),labels = c(0,1))


#Removing the unwanted column 
df<-bank[,-c(2,9,10,11,12,13)]
View(df)
df<-class(df)
# we will use  as. numeric() to convert a factor to a numeric vector
df$Age<-as.numeric(df$Age)
df$Marital<-as.numeric(df$Marital)
df$Education<-as.numeric(df$Education)
df$Default<-as.numeric(df$Default)
df$Balance<-as.numeric(df$Balance)
df$Housing<-as.numeric(df$Housing)



#We will implement the logistic regression model
#Splitting the data into train and test test
dt = sort(sample(nrow(df), nrow(df)*.7))
train<-data[dt,]
test<-data[-dt,]
View(train)
train$Loan_Status= factor(train$Loan_Status, levels = c('N','Y'),labels = c(0,1))


sapply(train,function(x){sum(is.na(x))}) # counts the number of NA values inthe dataset
train$Credit_History<-ifelse(is.na(train$Credit_History),ave(train$Credit_History,FUN = function(x) mean(x,na.rm =T)),train$Credit_History)
train$Loan_Amount_Term<-ifelse(is.na(train$Loan_Amount_Term),mode(train$Loan_Amount_Term,FUN = function(x) mean(x,na.rm =T)),train$Loan_Amount_Term)
train$LoanAmount<-ifelse(is.na(train$LoanAmount),ave(train$LoanAmount,FUN = function(x) mean(x,na.rm =T)),train$LoanAmount)
glm(formula = Loan_Status ~ Credit_History + Education + Self_Employed + 
      Property_Area + LoanAmount + ApplicantIncome, family = binomial, 
    data = trainnew)




#Here Decision Tree algorithm is implemented
# grow tree 
dtree <- rpart(age~ Loan_Status+Education+Marital+Default+Balance+
                 Credit_History,method="class", data=train)
dtree$cptable
plotcp(dtree)

# Creating a correlation matrix
corrplot<-corrplot(cor(train[c(1,2,3,6)]), type="upper", order="hclust")
train<-as.numeric(train)



# trainControl for Random Forest
fitControl = trainControl(method = "repeatedcv", repeats = 5,
                          number = 5, verboseIter = T)

# Run a Random Forest classification over the training set
rf.fit <- train(Loan_Status ~ .,  data = train, method = "rf",
                importance = T, trControl = fitControl,
                tuneLength = 5)
