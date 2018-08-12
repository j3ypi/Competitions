#------------------------------------------
#Gradient boositng machine
#
#------------------------------------------

library(here)
library(h2o)

#load data---------------------------------
train <- import(here("Data", "clean_train.csv"), setclass = "tbl")

#configure---------------------------------
localH2O <- h2o.init()       # initial H2O local instance
h2o_train <- as.h2o(train)



Y<-"heart_disease_present"
X<-setdiff(colnames(train),Y)

#Gradeint Boosting Machine -----------------

h2o_train[,Y] <- as.factor(h2o_train[,Y])
GBM<- h2o.gbm(X,Y,h2o_train,nfolds = 4)






