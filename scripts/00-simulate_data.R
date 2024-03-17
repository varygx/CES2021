#### Preamble ####
# Purpose: Simulates a dataset of predictor variables and the party. Based on sketches
# prior to obtaining the actual data
# that the person votes for
# Author: Allen Uy 
# Date: 16 March 2024
# Contact: allen.uy@mail.utoronto.ca
# License: MIT
# Pre-requisites: None

#### Workspace setup ####
library(tidyverse)

#### Simulate data ####
set.seed(42)

num_obs <- 1000

canada_political_preference <- tibble(
  age = sample(18:90, size=num_obs, replace=TRUE),
  education = sample(1:11, size=num_obs, replace=TRUE),
  economy = sample(1:5, size=num_obs, replace=TRUE),
  covid = sample(1:5, size=num_obs, replace=TRUE),
  environment = sample(1:5, size=num_obs, replace=TRUE),
  support_prob = ((age/10 + education + economy + covid/2 + environment/3)/28)
)

canada_political_preference <- canada_political_preference %>% mutate(
  voted_for = if_else(runif(n = num_obs) < support_prob, "Liberal", "Conservative")
) %>% select(-support_prob)

