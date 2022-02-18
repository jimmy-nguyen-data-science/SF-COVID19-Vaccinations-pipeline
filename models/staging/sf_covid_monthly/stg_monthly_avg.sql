with mth_avg as (
SELECT 
    FORMAT_DATETIME("%Y, %m",date_administered) yearmonth, 
    round(avg(new_1st_doses),2) avg_new_1st_doses,
    round(avg(new_2nd_doses),2) avg_new_2nd_doses,
    round(avg(new_single_doses),2) avg_new_single_doses,
    round(avg(new_series_completed),2) avg_new_series_completed,
    round(avg(new_recipients),2) avg_new_recipients
from {{ source('sf_vocid_monthly', 'daily-data')}}
group by yearmonth
order by yearmonth desc
)

select * from mth_avg