with mth_tot as (
SELECT 
    FORMAT_DATETIME("%Y, %m",date_administered) yearmonth, 
    sum(new_1st_doses) tot_new_1st_doses,
    sum(new_2nd_doses) tot_new_2nd_doses,
    sum(new_single_doses) tot_new_single_doses,
    sum(new_series_completed) tot_new_series_completed,
    sum(new_recipients) tot_new_recipients
from {{ source('sf_vocid_monthly', 'daily-data')}}

group by yearmonth
order by yearmonth desc
)

select * from mth_tot 