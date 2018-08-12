#------------------------------------------
#AutoML
#
#------------------------------------------

library(tidyverse)
library(here)
library(rio)
library(h2o)

#load data---------------------------------
train <- import(here("Data", "clean_train.csv"), setclass = "tbl")
test <- import(here("Data", "clean_test.csv"), setclass = "tbl")

#configure---------------------------------
localH2O <- h2o.init()       # initial H2O locl instance

h2o_train <- as.h2o(train)
h2o_test <- as.h2o(test)

Y<-"heart_disease_present"
X<-setdiff(colnames(train),Y)

#Auto ML-----------------------------------
Auto_ML<-h2o.automl(X,Y,h2o_train)
automl_leader <- Auto_ML@leader
automl_leader


#Prediction---------------------------------
#pred_conversion <- h2o.predict(object = automl_leader, newdata = h2o_test)

#predictions<-as.data.frame(pred_conversion)
#submission<-cbind(test$patient_id,predictions)
#names(submission)<-c("patient_id","heart_disease_present")

#write.csv(submission,"submission.csv",row.names = FALSE)







