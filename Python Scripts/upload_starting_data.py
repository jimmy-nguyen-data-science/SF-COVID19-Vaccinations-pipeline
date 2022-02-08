# packages
import pandas as pd
import os
from sodapy import Socrata
from google.cloud import storage
from google.cloud import bigquery
from google.oauth2 import service_account


def main():
    '''
    Runs all functions in sequence by line

    '''

    # Pull data from API
    api_data = get_data_from_api()

    # Clean data from API 
    clean_data = clean_data_from_api(api_data)
    
    # Load clean data into Google's BigQuery table
    load_bq_data = load_data_into_bigquery(clean_data)



def get_data_from_api():
    '''
    Calls API from DataSF and turns JSON data into Pandas data frame
    Selects only the first 15 columns
    Returns data frame 

    '''

    # This works with DataSF API using our access token
    client = Socrata("data.sfgov.org", '5S1JS75DiB3sVo5LoR6FLI5kE')

    # This retrieves data from the link that hosts SF COVID-19 vaccinations
    results = client.get("bqge-2y7k")

    # Convert to pandas DataFrame
    results_df = pd.DataFrame.from_records(results)

    # only the first 15 columns
    results_df = results_df.iloc[:,0:15]

    # return results
    return results_df


def clean_data_from_api(data):
    '''
    Convert columns into datetime and int64 data types
    Returns clean data as a new data frame
    

    Parameters
    ----------
    data : obj, required 
        API Data as a Pandas data frame
    '''
    
    # make a copy of the data
    new_df = data.copy()
    # convert all columns except the first into numeric types
    new_df = new_df.iloc[:,1:15].apply(pd.to_numeric)
    
    # convert date_administered column into datetime object
    data['date_administered'] = pd.to_datetime(data['date_administered'])

    # rearrange data to have date_administered column as first column
    new_df.insert(0, "date_administered", data['date_administered'])

    #return clean data
    return new_df



def load_data_into_bigquery(clean_data):
    '''
    Load clean data into Google's BigQuery table

    Parameters
    ----------
    clean_data : obj, required 
        Clean API data as a Pandas data frame

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

    # Configure Schema
    job_config = bigquery.LoadJobConfig(
    schema=[
        bigquery.SchemaField(name="date_administered", field_type="TIMESTAMP", mode = "REQUIRED"),
        bigquery.SchemaField(name="new_1st_doses", field_type="INTEGER"),
        bigquery.SchemaField(name="new_2nd_doses", field_type="INTEGER"),
        bigquery.SchemaField(name="new_single_doses", field_type="INTEGER"),
        bigquery.SchemaField(name="new_series_completed", field_type="INTEGER"),
        bigquery.SchemaField(name="new_recipients", field_type="INTEGER"),
        bigquery.SchemaField(name="cumulative_1st_doses", field_type="INTEGER"),
        bigquery.SchemaField(name="cumulative_2nd_doses", field_type="INTEGER"),
        bigquery.SchemaField(name="cumulative_single_doses", field_type="INTEGER"),
        bigquery.SchemaField(name="cumulative_series_completed", field_type="INTEGER"),
        bigquery.SchemaField(name="cumulative_recipients", field_type="INTEGER"),
        bigquery.SchemaField(name="new_booster_doses", field_type="INTEGER"),
        bigquery.SchemaField(name="new_booster_recipients", field_type="INTEGER"),
        bigquery.SchemaField(name="cumulative_booster_doses", field_type="INTEGER"),
        bigquery.SchemaField(name="cumulative_booster_recipients", field_type="INTEGER"),
    ]
)

    # load dataframe into table
    load_job = client.load_table_from_dataframe(clean_data, table_ref, job_config=job_config)

    # API request
    print("Starting job {}".format(load_job.job_id))

    load_job.result()  # Waits for table load to complete.
    print("Job finished.")

    destination_table = client.get_table(table_ref)
    print("Loaded {} rows.".format(destination_table.num_rows)) 


   

if __name__ == "__main__":
    main()
