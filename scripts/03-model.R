#### Preamble ####
# Purpose: Models party support for Canada 2021 Election
# Author: Allen Uy
# Date: 16 March 2024
# Contact: allen.uy@mail.utoronto.ca
# License: MIT
# Pre-requisites: 01-data_cleaning was run


#### Workspace setup ####
library(tidyverse)
library(rstanarm)
library(arrow)

#### Read data ####
ces21_data <- read_parquet("data/analysis_data/clean_ces2021.parquet")

### Model data ####
# Model based on personal variables
personal_model <-
  stan_glm(
    formula = voted_for ~ age + education + income_cat,
    data = analysis_data,
    family = binomial(),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
    seed = 42
  )

# Only some people were asked some of these questions

# Model based on topic variables
# Too out of scope
# topic_model <-
#   stan_glm(
#     formula = voted_for ~ econ_party + healthcare_party + 
#       imm_party + pos_carbon + covid_party + env_party + pos_envreg + pos_jobs + 
#       quebec_sov + educ_party,
#     data = analysis_data,
#     family = binomial(),
#     prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
#     prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
#     seed = 42
#   )

# Error: Constant variable(s) found: province
# sum(is.na(analysis_data$province))
# unique(analysis_data$province)


# Model based on personal + topic variables
# Excludes province due to error
# all_var_model <-
#   stan_glm(
#     formula = voted_for ~ age + education + employment + religion +
#       born_in_canada + income_cat + econ_party + healthcare_party + 
#       imm_party + pos_carbon + covid_party + env_party + pos_envreg + pos_jobs + 
#       quebec_sov + educ_party,
#     data = analysis_data,
#     family = binomial(),
#     prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
#     prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
#     seed = 42
#   )

#### Save model ####
saveRDS(
  personal_model,
  file = "models/personal_model.rds"
)

# saveRDS(
#   topic_model,
#   file = "models/topic_model.rds"
# )
# 
# saveRDS(
#   all_var_model,
#   file = "models/all_var_model.rds"
# )




