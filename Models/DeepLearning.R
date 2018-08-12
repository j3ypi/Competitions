#------------------------------------------
#Deep Neural Network
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

#Deep Learning-----------------------------------
h2o_train[,Y] <- as.factor(h2o_train[,Y])
DL<- h2o.deeplearning(X,Y,h2o_train,activation = "RectifierWithDropout",hidden = c(100, 200), epochs = 5,nfolds = 4)



