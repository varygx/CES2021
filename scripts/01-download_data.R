#### Preamble ####
# Purpose: Downloads and saves the data from CES 21
# that the person votes for
# Author: Allen Uy 
# Date: 12 March 2023 
# Contact: allen.uy@mail.utoronto.ca
# License: MIT
# Pre-requisites: None


#### Workspace setup ####
library(dataverse)
library(tidyverse)

#### Download data ####
ces2021 <- get_dataframe_by_name(
  filename = "2021 Canadian Election Study v2.0.tab",
  dataset = "10.7910/DVN/XBZHKC",
  server = "dataverse.harvard.edu",
  .f = read_table
)


#### Save data ####
write_csv(ces2021, "data/raw_data/raw_ces2021.csv") 

         
