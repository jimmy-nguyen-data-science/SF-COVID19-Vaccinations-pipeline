# ADS 507: Practical Data Engineering - Team 5 Final Project

## Collaborators
- ![Jimmy Nguyen](https://github.com/jimmy-nguyen-data-science)
- ![Abby Tan](https://github.com/Abby-Tan)
- ![Yi Wang](https://github.com/YiWang001)


## Topic:

Build an automated ELT data pipeline using Python, Google's Cloud Services such as Bigquery or Cloud Functions, and dbt for data transformation.

## Data Set

San Francisco's daily data on COVID-19 vaccinations

## Design Document

![The design document illustrates the data pipeline in detail](https://github.com/jimmy-nguyen-data-science/SF-COVID19-Vaccinations-pipeline/blob/main/Team%205%20Design%20Document%20-%20Data%20Pipeline%20for%20San%20Francisco%20COVID-19%20Vaccinations.pdf)

## Code Review

-	Split the column of “yearmonth” into “year” and “month” from stg_monthly_total.sql and stg_monthly_avg.sql
-	Create a “marts” folder to match the YAML file path of models > marts > core > dim tables
-	Standardize the code format using SQLFluff as Linter
-	Perform quality checks for continuous integration testing on data 
-	Validate final materialized dimensional tables pushed into production data warehouse before populating Google's Data Studio dashboards


## Overview of Final Project Directory

### - Python Scripts

- yml file contains a list of dependencies
- txt and txt.bak are the same environments files to support the yml file
- update_daily_data update the new data 
- upload_starting_data upload the new data

### - Analysis

- Created by dbt

### - Architecture_diagrams

- Create architecture diagram for data pipeline
- Finalize architecture diagram draft as png


### - Final output 
- Final output is a PDF file of a dashboard created by Google's Data Studio Service 

### - Macros

- Created by dbt

### - Models

- SQL transformation in these models

#### - Marts/Core

- Create monthly average and extract data from dataSF
- Create monthly cumulative and extract data from dataSF
- Create monthly boosters and extract data from dataSF

#### - Staging

- Create boosters model
- Create cumulative model
- Create San Francisco Covid monthly model

### - Seeds

- Created by dbt

### - Snapshots

- Created by dbt

### Tests

- Test for staging files where all data should be non-negatives and any data less than zero will throw an error during the command _dbt test_ 

![DBT run tests part 1](https://github.com/jimmy-nguyen-data-science/SF-COVID19-Vaccinations-pipeline/blob/development-yi/tests/DBT%20run%20pass(1).png)
![DBT run tests part 2](https://github.com/jimmy-nguyen-data-science/SF-COVID19-Vaccinations-pipeline/blob/development-yi/tests/DBT%20run%20pass(2).png)


## Architecture Diagram 

![](https://github.com/jimmy-nguyen-data-science/SF-COVID19-Vaccinations-pipeline/blob/main/architecture_diagrams/final_draft_01.png)

## Final Output

![](https://github.com/jimmy-nguyen-data-science/SF-COVID19-Vaccinations-pipeline/blob/main/final%20output/Final%20Output%20as%20Dashboard.png)



