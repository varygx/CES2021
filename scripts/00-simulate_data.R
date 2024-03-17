#### Preamble ####
# Purpose: Simulates a dataset of predictor variables and the party
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
  party = sample(1:5, size=party, replace=TRUE)
)



