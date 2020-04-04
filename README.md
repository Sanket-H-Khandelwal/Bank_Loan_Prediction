# Bank Loan Prediction

Introduction
Banks make money by lending it at some rates which are higher than the cost of that money. More specifically, banks collect interest on the loans given to customers. Loans can be any amount depending on their needs. However, need is not the only issue that the bank is concerned about. Do the banks give any amount to anyone applied? Definitely, no. Banks check eligibility of the customers, first. The question is, how do they check it? What are the factors are needed to be considered before giving a loan?
In our analysis, we are going to figure out those factors which increase or decrease the chances of loan.

In our dataset (above), there are 12 variables such as ID, state, gender, Age, Marital status, Occupation, Credit score, Income, Debt, Loan type, and Loan_Status. 
We started our analysis with data preparation. At this stage, we tried to define missing values. colSums(is.na(df)) function helped us to define those values

Logistic Regression:
We are using logistic regression model because the dependent variable is binary. We use logistic regression whenever we want to examine a result if it will happen or it will not. In our case, the dependent variable is loan decision we want to identify whether the customers will get the loan or not. Therefore, our dependent variable that is loan decision is dichotomous in nature. 

Decision Tree:
In logistic regression, we observed the factors which were affecting the loan eligibility of a customer. Logistic regression showed the factors which were dominant and majorly affecting the loan decision. Now we will predict the loan eligibility of the customer using the Decision tree model. For a decision tree model, we need to install two packages namely rpart and rpart.plot.


Random Forest:
The random forest algorithm is a supervised learning model; it uses labeled data to “learn” how to classify unlabeled data. This is the opposite of the K-means Cluster algorithm
For the random forest model, we need to install some packages such as randomForest and caret. For creating a random forest model, we will be using the randomforest () function in R


Naive Bayes:
This algorithm is based on Bayes Theorem.
The Loan_Status is our response variable.
For creating the Naïve Bayes model, we will be using the train data.
Naive Bayes uses a similar method to predict the probability of different class based on various attributes


By using the above models, we have predicted the loan eligibility of the customer by taking the different factors into consideration and by using these algorithms the loan eligibility can be predicted. In the future, we are planning to collect the data of the bankruptcies, the different modes of income of a customer and the property rate of the customer assets which will help us to make more accurate predictions.
