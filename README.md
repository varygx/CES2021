# Starter folder

## Overview

This repo analyzes and models the 2021 Canadian Federal Election using data from the 2021 Canadian Election Study.

## File Structure

The repo is structured as:

-   `data/raw_data` contains the raw data as obtained from the 2021 Canadian Election STudy.
-   `data/analysis_data` contains the cleaned dataset that was constructed.
-   `model` contains fitted models.
-   `other` contains relevant literature, details about LLM chat interactions, and sketches.
-   `paper` contains the files used to generate the paper, including the Quarto document and reference bibliography file, as well as the PDF of the paper.
-   `scripts` contains the R scripts used to simulate, download and clean data.

## Downloading the Data

The .tab file hosted on the Harvard Database has issues being processed after being downloaded via the `dataverse` library. It is best to use the original .dta file which can be downloaded manually from the [Harvard Dataverse](https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/XBZHKC) site by clicking Download \> Original Format.

## Statement on LLM usage

No LLMs were used for any aspect of this work.
