/*
{{ config(
    materialized="table")

}}
*/
with base as (
SELECT 
    FORMAT_DATETIME("%Y, %m",date_administered) yearmonth, 
    sum(new_series_completed) tot_new_series_completed,
    round(avg(new_series_completed),2) avg_new_series_completed
FROM `ads-507-final-project-340820.sf_covid19_vaccinations.daily-data` 
group by yearmonth
order by yearmonth desc
) 

select 
    yearmonth,
    tot_new_series_completed,
    avg_new_series_completed,
    round( (tot_new_series_completed - lag(tot_new_series_completed,1,0) over (order by yearmonth))/tot_new_series_completed, 2) tot_prec_change,
    round( (avg_new_series_completed - lag(avg_new_series_completed,1,0) over (order by yearmonth))/avg_new_series_completed, 2) avg_prec_change
from base
order by yearmonth desc