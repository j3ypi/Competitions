#------------------------------------------
#AutoML
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

#Auto ML-----------------------------------
h2o_train[,Y] <- as.factor(h2o_train[,Y])
Auto_ML<-h2o.automl(X,Y,h2o_train,nfolds = 4)
automl_leader <- Auto_ML@leader







