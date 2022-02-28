# ADS 507 - Final Project

## Topic:

Build an automated ELT data pipeline using Python, Google's Cloud Services such as Bigquery or Cloud Functions, and dbt for data transformation.

## Data Set

San Francisco's daily data on COVID-19 vaccinations

## Code Review

-	Split the column of “yearmonth” into “year” and “month” from stg_monthly_total.sql and stg_monthly_avg.sql
-	Create a “marts” folder to match the YAML file path of models > marts > core > dim tables
-	Standardize the code format


## Overview of Final Project Directory

### Python Scripts

- yml file contains a list of dependencies
- txt and txt.bak are the same environments files to support the yml file
- update_daily_data update the new data 
- upload_starting_data upload the new data

### Analysis

- Created by dbt

### Architecture_diagrams

- Create architecture diagram for data pipeline
- Convert sample diagram to png
- Finalize first architecture diagram draft

### Macros

- Created by dbt

### Models

- SQL transformation in these models

#### Marts/Core

- Create monthly average and extract data from dataSF
- Create monthly cumulative and extract data from dataSF
- Create monthly boosters and extract data from dataSF

#### Staging

- Create boosters model
- Create cumulative model
- Create San Francisco Covid monthly model

### Seeds

- Created by dbt

### Snapshots

- Created by dbt

### Tests

- All data should be greater than zero in this project, any data less than zero must have error

## Upload Images

- ![DBT run pass (1)](https://github.com/jimmy-nguyen-data-science/SF-COVID19-Vaccinations-pipeline/blob/development-yi/tests/DBT%20run%20pass(1).png)
- ![DBT run pass (2)](https://github.com/jimmy-nguyen-data-science/SF-COVID19-Vaccinations-pipeline/blob/development-yi/tests/DBT%20run%20pass(2).png)
