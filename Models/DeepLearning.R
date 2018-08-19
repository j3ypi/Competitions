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

# Split data into train & validation
ss <- h2o.splitFrame(h2o_train, seed = 1)
train <- ss[[1]]
valid <- ss[[2]]

#Parameter Search--------------------------------
hyper_params <- list(
  hidden=list(c(32,32,32),c(64,64),c(300,300,300),c(1000,300,200)),
  input_dropout_ratio=c(0,0.05),
  rate=c(0.01,0.02),
  rate_annealing=c(1e-8,1e-7,1e-6)
)


hyper_params
grid <- h2o.grid(
  algorithm="deeplearning",
  grid_id="dl_grid", 
  training_frame=train,
  validation_frame=valid, 
  x=X, 
  y=Y,
  epochs=10,
  stopping_metric="misclassification",
  stopping_tolerance=1e-2,        # stop when misclassification does not improve by >=1% for 2 scoring events
  stopping_rounds=2,
  score_validation_samples=10000, # downsample validation set for faster scoring
  score_duty_cycle=0.025,         # don't score more than 2.5% of the wall time
  adaptive_rate=F,                # manually tuned learning rate
  momentum_start=0.5,             # manually tuned momentum
  momentum_stable=0.9, 
  momentum_ramp=1e7, 
  l1=1e-5,
  l2=1e-5,
  activation=c("Rectifier"),
  max_w2=10,                      # can help improve stability for Rectifier
  hyper_params=hyper_params
)
grid <- h2o.getGrid("dl_grid",sort_by="AUC",decreasing=FALSE)

# Find the best model and its full set of parameters
grid@summary_table[1,]
DL <- h2o.getModel(grid@model_ids[[1]])


#print(DL@allparameters)
#print(h2o.performance(DL, valid=T))