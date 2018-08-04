
library(tidyverse)
library(here)
library(rio)
library(broom)
library(lmerTest)

train <- import(here("Data", "clean_train.csv"), setclass = "tbl")
test <- import(here("Data", "clean_test.csv"), setclass = "tbl")

# Naive principal component analysis for first insights
# about the number of factors
pca <- princomp()
screeplot(pca)

# ML factor analysis for reliable factor loadings with 
# nfactors from pca
fac <- factanal()
fac %>% 
  print(digits = 2, cut.off = .3, sort = TRUE)

# Hierarchical logistic regression model to find the best model 
# in combination with the insights from the EFA
model1 <- glm()
model2 <- glm()
model3 <- glm()
model4 <- glm()
model5 <- glm()

rbind(
  glance(model1),
  glance(model2),
  glance(model3),
  glance(model4),
  glance(model5)
) %>% 
  mutate(model = paste0("model", 1:5))
  select(model, r.squared, AIC, BIC)  

# Use a generalized linear model controlling the interindividual
# difference by patients ID
glmer() # + (1|ID)

# Predict heart_disease_present on test set

# Submit in form of submission_format.csv












