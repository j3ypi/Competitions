#------------------------------------------
#Prediction
#
#------------------------------------------

#Prediction---------------------------------
test <- import(here("Data", "clean_test.csv"), setclass = "tbl")
h2o_test<-as.h2o(test)
#hier kann ich leider nicht model selection einfügen kp wieso werde ich noch ändern
pred_conversion <- h2o.predict(object = automl_leader, newdata = h2o_test)


predictions<-as.data.frame(pred_conversion)
submission<-cbind(test$patient_id,predictions)
names(submission)<-c("patient_id","heart_disease_present")

write.csv(submission,"submission.csv",row.names = FALSE)