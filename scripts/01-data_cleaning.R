#### Preamble ####
# Purpose: Cleans the raw dataset provided by CES and saves to parquet
# Author: Allen Uy
# Date: 12 March 2024
# Contact: allen.uy@mail.utoronto.ca
# License: MIT
# Pre-requisites: The dataset dta file is downloaded and placed in the
# appropriate location. Libraries below are installed.

#### Workspace setup ####
library(tidyverse)
library(haven)
library(arrow)

#### Clean data ####
raw_data <- read_dta("data/raw_data/2021 Canadian Election Study v2.0.dta")

# Variables of interest
personal_var = c("cps21_age", "cps21_education", "cps21_employment",
                 "cps21_religion", "cps21_bornin_canada", "cps21_income_number",
                 "cps21_income_cat", "cps21_province")

# economy, healthcare, immigration, covid, environment, quebec,
# gov spending, education, housing, carbon tax, childcare
topic_var = c("cps21_issue_handle_9", "cps21_econ_retro", "cps21_econ_fed_bette",
              "cps21_issue_handle_1", "cps21_issue_handle_7", "cps21_pos_carbon",
              "cps21_issue_handle_8", "cps21_covid_liberty", "cps21_issue_handle_3",
              "cps21_pos_envreg", "cps21_pos_jobs", "cps21_quebec_sov",
              "cps21_spend_env", "cps21_spend_educ", "cps21_spend_just_law",
              "cps21_spend_defence", "cps21_spend_imm_min", "cps21_spend_rec_indi",
              "cps21_spend_afford_h", "cps21_spend_nation_c", "cps21_issue_handle_2")


# Party choice
party = c("cps21_votechoice", "cps21_votechoice_pr", "cps21_vote_unlikely",
          "cps21_vote_unlike_pr", "cps21_v_advance", "cps21_vote_lean",
          "cps21_vote_lean_pr")

selected_data <- raw_data %>%
  select(
    all_of(personal_var),
    all_of(topic_var),
    all_of(party)
  ) %>%
  rename(
    age = cps21_age,
    education = cps21_education,
    employment = cps21_employment,
    religion = cps21_religion,
    born_in_canada = cps21_bornin_canada,
    income_num = cps21_income_number,
    income_cat = cps21_income_cat,
    province = cps21_province,
    econ_party = cps21_issue_handle_9,
    econ_retro = cps21_econ_retro,
    econ_fed_better = cps21_econ_fed_bette,
    healthcare_party = cps21_issue_handle_1,
    imm_party = cps21_issue_handle_7,
    pos_carbon = cps21_pos_carbon,
    covid_party = cps21_issue_handle_8,
    covid_liberty = cps21_covid_liberty,
    env_party = cps21_issue_handle_3,
    pos_envreg = cps21_pos_envreg,
    pos_jobs = cps21_pos_jobs,
    quebec_sov = cps21_quebec_sov,
    spend_env = cps21_spend_env,
    spend_educ = cps21_spend_educ,
    spend_just_law = cps21_spend_just_law,
    spend_defence = cps21_spend_defence,
    spend_imm_min = cps21_spend_imm_min,
    spend_rec_indi = cps21_spend_rec_indi,
    spend_afford_h = cps21_spend_afford_h,
    spend_nation_c = cps21_spend_nation_c,
    educ_party = cps21_issue_handle_2,
    votechoice = cps21_votechoice,
    votechoice_pr = cps21_votechoice_pr,
    vote_unlikely = cps21_vote_unlikely,
    vote_unlike_pr = cps21_vote_unlike_pr,
    v_advance = cps21_v_advance,
    vote_lean = cps21_vote_lean,
    vote_lean_pr = cps21_vote_lean_pr
  )

selected_data <- selected_data %>%
  mutate(
    aggregated_vote = coalesce(
      votechoice,
      votechoice_pr,
      vote_unlikely,
      vote_unlike_pr,
      v_advance,
      vote_lean,
      vote_lean_pr
    )
  ) %>%
  select(-votechoice, -votechoice_pr, -vote_unlikely, -vote_unlike_pr, -v_advance, -vote_lean, -vote_lean_pr)

# Convert income number to income category
selected_data <- selected_data %>%
  mutate(
    income_cat = ifelse(
      income_num != -99 & is.na(income_cat),
      case_when(
        income_num == 0 ~ 1,
        income_num <= 30000 ~ 2,
        income_num <= 60000 ~ 3,
        income_num <= 90000 ~ 4,
        income_num <= 110000 ~ 5,
        income_num <= 150000 ~ 6,
        income_num <= 200000 ~ 7,
        TRUE ~ 8
      ),
      income_cat
    )
  )


# Filter to only Liberal (1) and Conservative (2)
selected_data <- selected_data %>% 
  filter(aggregated_vote %in% c(1,2))

selected_data <- selected_data %>% 
  mutate(voted_for = if_else(aggregated_vote == 1, "Liberal", "Conservative"),
         voted_for = as_factor(voted_for)) %>% 
  select(-aggregated_vote)

#### Save data ####
write_parquet(x = selected_data, sink = "data/analysis_data/clean_ces2021.parquet")
