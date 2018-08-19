#------------------------------------------
#Evaluate Performence
#
#Evaluation of models and decision for one model
#ToDo
#------------------------------------------

#Models------------------------------------

Eval<-rbind(
  h2o.auc(DL,valid = T),
  h2o.auc(GBM, xval = TRUE),
  h2o.auc(automl_leader, xval = TRUE)
  )
names(Eval)<-"AUC"
rownames(Eval)<-c("DL","GBM","automl_leader")


model_selection<-Eval[which.max(Eval),]

print(model_selection)