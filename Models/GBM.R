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

# Split data into train & validation--------
ss <- h2o.splitFrame(h2o_train, seed = 1)
train <- ss[[1]]
valid <- ss[[2]]

# GBM hyperparamters------------------------
gbm_params1 <- list(learn_rate = c(0.01, 0.1),
                    max_depth = c(3, 5, 9),
                    sample_rate = c(0.8, 1.0),
                    col_sample_rate = c(0.2, 0.5, 1.0))

# Train and validate a cartesian grid of GBMs
gbm_grid1 <- h2o.grid("gbm", x = X, y = Y,
                      grid_id = "gbm_grid1",
                      training_frame = train,
                      validation_frame = valid,
                      ntrees = 100,
                      seed = 1,
                      hyper_params = gbm_params1)


gbm_gridperf1 <- h2o.getGrid(grid_id = "gbm_grid1",
                             sort_by = "auc",
                             decreasing = TRUE)
print(gbm_gridperf1)

#get best model------------------------------
GBM<- h2o.getModel(gbm_gridperf1@model_ids[[1]])

#get honest estimetion-----------------------
best_gbm_perf1 <- h2o.performance(model = GBM,
                                  newdata = valid)
h2o.auc(best_gbm_perf1) 

# hyperparamters for the best model ---------
print(GBM@model[["model_summary"]])





