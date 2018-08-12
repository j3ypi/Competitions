#------------------------------------------
#Prediction
#
#------------------------------------------

#Prediction---------------------------------
pred_conversion <- h2o.predict(object = model_selection, newdata = h2o_test)


predictions<-as.data.frame(pred_conversion)
submission<-cbind(test$patient_id,predictions)
names(submission)<-c("patient_id","heart_disease_present")

write.csv(submission,"submission.csv",row.names = FALSE)