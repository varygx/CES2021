#### Preamble ####
# Purpose: Tests cleaned data to ensure robustness
# Author: Allen Uy
# Date: 16 March 2024
# Contact: allen.uy@mail.utoronto.ca
# License: MIT
# Pre-requisites: 01-data_cleaning was run


#### Workspace setup ####
library(tidyverse)
library(testthat)
library(arrow)
library(here)

ces21_data <- read_parquet(here::here("data/analysis_data/clean_ces2021.parquet"))

#### Test data ####
test_that("variables are expected type from dta", {
  expect_type(ces21_data$age, "double") 
  expect_type(ces21_data$education, "integer")
  expect_type(ces21_data$income_cat, "character")
})

test_that("variables are greater than 0", {
  expect(all(ces21_data$age > 0), "all ages should be greater than 0")
})

test_that("variables do not have null values", {
  expect_false(any(is.null(ces21_data$age)), "age should not have null values")
  expect_false(any(is.null(ces21_data$education)), "education should not have null values")
  expect_false(any(is.null(ces21_data$employment)), "employment should not have null values")
  expect_false(any(is.null(ces21_data$religion)), "religion should not have null values")
  expect_false(any(is.null(ces21_data$born_in_canada)), "immigration_status should not have null values")
  expect_false(any(is.null(ces21_data$income_cat)), "income_category should not have null values")
})

test_that("party variable is binary", {
  expect_type(ces21_data$voted_for, "integer")
  expect(all(ces21_data$voted_for %in% c("Liberal", "Conservative")))
})
