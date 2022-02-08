# packages
import pandas as pd
import os
from sodapy import Socrata
from google.cloud import storage
from google.cloud import bigquery
from google.oauth2 import service_account

# import python functions
import upload_starting_data


def main():
    '''
    Runs all functions in sequence by line

    '''
    
    latest = get_current_data()
    append_latest = append_data_into_bigquery_table(latest)


def get_current_data():
    ''' 
    Grabs data from API and returns most recent data/row

    '''
       
    # Pull data from API    
    api_data = upload_starting_data.get_data_from_api()

    # Clean data from API
    clean_data = upload_starting_data.clean_data_from_api(api_data)

    # find the most recent data
    latest_data = clean_data.iloc[[-1]].reset_index(drop = True)

    return latest_data


def append_data_into_bigquery_table(latest):
    '''
    Load latest data into Google's BigQuery table

    Parameters
    ----------
    latest : obj, required 
        latest data as a Pandas data frame

    '''

    # load credentials
    credentials = service_account.Credentials.from_service_account_file("python-datasf.json")

    # Start bigquery client
    client = bigquery.Client(credentials= credentials)
    
    # specify data set
    data_set = 'sf_covid19_vaccinations'

    # specify new table
    table_name = 'daily-data' 

    # create table reference
    table_ref = client.dataset(data_set).table(table_name)    

    # Configurations for appending a row
    job_config = bigquery.LoadJobConfig()

    # load dataframe into table
    load_job = client.load_table_from_dataframe(latest, table_ref, job_config=job_config)

    # API request
    print("Starting job {}".format(load_job.job_id))

    load_job.result()  # Waits for table load to complete.
    print("Job finished.")

    destination_table = client.get_table(table_ref)
    print("Loaded {} rows.".format(destination_table.num_rows)) 

    





if __name__ == "__main__":
    main()
