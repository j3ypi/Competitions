
library(tidyverse)
library(here)
library(rio)
library(modelr)

files <- dir(here("Data")) # get alle files contained in the Data subdir
data <- import_list(here("Data", files), setclass = "tbl") # import all csvs as list

############
# Train Set
############
train <- data$train_values
train_labels <- data$train_labels

train <- left_join(train, train_labels) %>%   # fusion both train sets
  mutate(id = seq_len(n())) %>%      # add patients num ID
  mutate_if(is_character, as_factor) # convert strings to factor for dummies

# First overview
summary(train)
str(train)  

dummies <- model_matrix(train, ~ thal - 1) %>% # dummies
  mutate(id = seq_len(n())) # ID to join by

train <- left_join(train, dummies) %>% 
  select(-thal, -patient_id) # remove factor variables

# Checking
summary(train)
str(train)

############
# Test Set
############
test <- data$test_values

# Same procedure as for the train set
test %<>% 
  mutate(id = seq_len(n())) %>%      
  mutate_if(is_character, as_factor)

dummies <- model_matrix(test, ~ thal - 1) %>% 
  mutate(id = seq_len(n())) 

test <- left_join(test, dummies) %>% 
  select(-thal, -patient_id) # remove factor variables

# Checking
summary(test)
str(test)

##########################
# Export manipulated data
##########################
export(train, here("Data", "clean_train.csv"))
export(test, here("Data", "clean_test.csv"))





