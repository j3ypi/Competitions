#------------------------------------------
#Mainscript
# Null framework einfügen
#
#------------------------------------------
#library
library(here)

#data manipulation ------------------------
source(here("/data_manip.R"))

#Train Models -----------------------------
#Gradient Boosting machine
source(here("/Models/GBM.R"))
#DeepLearning
source(here("/Models/DeepLearning.R"))
#AutoML
source(here("/Models/AutoML.R"))

#Evaluate performence ----------------------
source(here("/Evaluation.R"))

#Prediction/Submission ---------------------
source(here("/Prediction.R"))




