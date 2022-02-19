with mth_avg as (
  SELECT 
    FORMAT_DATETIME("%Y", date_administered) adm_year, 
    FORMAT_DATETIME("%m", date_administered) adm_month, 
    round(
      avg(new_1st_doses), 
      0
    ) avg_new_1st_doses, 
    round(
      avg(new_2nd_doses), 
      0
    ) avg_new_2nd_doses, 
    round(
      avg(new_single_doses), 
      0
    ) avg_new_single_doses, 
    round(
      avg(new_series_completed), 
      0
    ) avg_new_series_completed, 
    round(
      avg(new_recipients), 
      0
    ) avg_new_recipients 
  from 
    {{ source(
      'sf_covid19_monthly', 'daily-data'
    ) }} 
  group by 
    adm_year, 
    adm_month 
  order by 
    adm_year, 
    adm_month desc
) 
select 
  * 
from 
  mth_avg
