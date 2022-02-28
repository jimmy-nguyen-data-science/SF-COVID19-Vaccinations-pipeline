# ADS 507: Practical Data Engineering - Team 5 Final Project

## Collaborators
- ![Jimmy Nguyen](https://github.com/jimmy-nguyen-data-science)
- ![Abby Tan](https://github.com/Abby-Tan)
- ![Yi Wang](https://github.com/YiWang001)


## Topic:

Build an automated ELT data pipeline using Python, Google's Cloud Services such as Bigquery or Cloud Functions, and dbt for data transformation.

## Data Set

![San Francisco's daily data on COVID-19 vaccinations](https://data.sfgov.org/COVID-19/COVID-Vaccinations-Given-to-SF-Residents-Over-Time/bqge-2y7k)


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
- Tests are configured to run on a daily schedule with dbt 

![DBT run tests part 1](https://github.com/jimmy-nguyen-data-science/SF-COVID19-Vaccinations-pipeline/blob/development-yi/tests/DBT%20run%20pass(1).png)
![DBT run tests part 2](https://github.com/jimmy-nguyen-data-science/SF-COVID19-Vaccinations-pipeline/blob/development-yi/tests/DBT%20run%20pass(2).png)


## Architecture Diagram 

![](https://github.com/jimmy-nguyen-data-science/SF-COVID19-Vaccinations-pipeline/blob/main/architecture_diagrams/final_draft_01.png)

## Final Output

![](https://github.com/jimmy-nguyen-data-science/SF-COVID19-Vaccinations-pipeline/blob/main/final%20output/Final%20Output%20as%20Dashboard.png)
![View live dashboard here](https://datastudio.google.com/reporting/0688f974-82b0-4835-b60d-e534a070e275)

## Triggering the Pipeline

- The pipeline is trigged on a scheduled nightly run at 11:50 P.M. PST using Google Cloud Scheduler service
- dbt is also configured for a scheduled run of a handful of commands at 11:59 P.M. PST every night to clean and transform incoming new raw data and update existing tables in _BigQuery_

## Database/Data Store/ Data Warehouse

- ![Google data warehouse BigQuery](https://cloud.google.com/bigquery)

## SQL Data Transformation Tools

- ![dbt](https://www.getdbt.com/)

## Linters

- SQLFluff was installed as a extension on Microsoft Visual Studio Code when writing SQL queries

##  How to deploy pipeline (Manually Set-up)

1. Create an account with Google Cloud 
2. Create an account with dbt 
3. Create a virtual environment with Python or Conda and install the dependencies inside the file: Python Scripts > environment.yml or requirements.txt 
4. Run python script: _upload_starting_data.py"
5. Configure Google Cloud Scheduler to run everyday at 11:50 P.M. PST - this will send out a pub/sub message with the trigger topic: _new_data
6. Paste the following environment and code on Google Cloud Functions: Python Scripts > update_daily_data.py and requirements.txt 
7. Set up Secruity and Authentication by adding access and admin privleges to users 
8. The Python script update_daily_data.py will be deploy on Google Cloud Functions daily appending new rows to an existing table called _daily-data_ on Google data warehouse _Big Query_
9. Set up automated connectors between BigQuery API and dbt 
10. Create staging models for light transformations on raw data 
11. Create tests for incoming raw data
12. Finalize documentation and schedule daily runs to materialize clean updated data as dimensional table back to _BigQuery_ as new tables
13. Launch Google Data Studio and import data directly from BigQuery to create dashboards 


## How to Monitor Data Pipeline 
1. Two Google Cloud Services: Error Reporting and Cloud Monitoring
2. Error reporting sends notifications such as emails or texts about failures for services in the pipeline - also gives a quick report/dashboard of the type of errors detected and the level of severity 
3. Cloud Monitoring displays reports or dashboards about the resources used from each service in order to maximize performance or reduce costs for unused services.

