# CES2021

## Overview

This repo analyzes voter tendencies in the 2021 Canadian Federal Election using data from the 2021 Canadian Election Study. By building a logistic regression model using age, education, and income, we discover a positive correlation between education level and Liberal support and a positive correlation between income level and Conservative support.

## File Structure

The repo is structured as:

-   `data/raw_data` contains the raw data as obtained from the 2021 Canadian Election Study.
-   `data/analysis_data` contains the cleaned dataset that was constructed as a parquet.
-   `model` contains fitted models.
-   `sketches` contains sketches of a dataset and graph prior to obtaining the actual dataset to help plan the paper.
-   `paper` contains the files used to generate the paper, including the Quarto document and reference bibliography file, as well as the PDF of the paper.
-   `scripts` contains the R scripts used to simulate, clean, and test the data.

## Downloading the Data

For reproducibility, the .tab file hosted on the Harvard Database has issues being processed after being downloaded via the `dataverse` library. It is best to use the original .dta file for data processing which can be downloaded manually from the [Harvard Dataverse](https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/XBZHKC) site by clicking Download \> Original Format.

## Statement on LLM usage

No LLMs were used for any aspect of this work.
