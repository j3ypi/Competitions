#------------------------------------------
#Gradient boositng machine
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

#Gradeint Boosting Machine -----------------
GBM<- h2o.gbm(X,Y,h2o_train)


#Prediction---------------------------------
#pred_conversion <- h2o.predict(object = GBM, newdata = h2o_test)
#
#print(model_path_DL)
#saved_model <- h2o.loadModel(model_path_DL)



#predictions<-as.data.frame(pred_conversion)
#submission<-cbind(test$patient_id,predictions)
#names(submission)<-c("patient_id","heart_disease_present")

#write.csv(submission,"submission.csv",row.names = FALSE)

