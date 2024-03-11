#### Preamble ####
# Purpose: Tests cleaned data to ensure robustness
# Author: Allen Uy
# Date: 12 March 2024
# Contact: allen.uy@mail.utoronto.ca
# License: MIT
# Pre-requisites: 01-data_cleaning was run


#### Workspace setup ####
library(tidyverse)
library(testthat)
library(arrow)

ces21_data <- read_parquet("data/analysis_data/clean_ces2021.parquet")

#### Test data ####
# The response data is all integers but stored as double
test_that("variables are integers", {
  expect_type(ces21_data$age, "integer") 
  expect_type(ces21_data$education, "integer")
  expect_type(ces21_data$employment, "integer")
  expect_type(ces21_data$religion, "integer")
  expect_type(ces21_data$born_in_canada, "integer")
  expect_type(ces21_data$income_cat, "integer")
})

# Questions that weren't responded to have a vlaue of -99
test_that("variables are greater than 0", {
  expect(all(ces21_data$age > 0), "all ages should be greater than 0")
  expect(all(ces21_data$education > 0), "all education values should be greater than 0")
  expect(all(ces21_data$employment > 0), "all employment values should be greater than 0")
  expect(all(ces21_data$religion > 0), "all religion values should be greater than 0")
  expect(all(ces21_data$born_in_canada > 0), "all immigration_status values should be greater than 0")
  expect(all(ces21_data$income_cat > 0), "all income_category values should be greater than 0")
})

test_that("variables do not have null values", {
  expect_false(any(is.null(ces21_data$age)), "age should not have null values")
  expect_false(any(is.null(ces21_data$education)), "education should not have null values")
  expect_false(any(is.null(ces21_data$employment)), "employment should not have null values")
  expect_false(any(is.null(ces21_data$religion)), "religion should not have null values")
  expect_false(any(is.null(ces21_data$born_in_canada)), "immigration_status should not have null values")
  expect_false(any(is.null(ces21_data$income_cat)), "income_category should not have null values")
})
