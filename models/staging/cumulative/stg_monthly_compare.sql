with cumulative_series_monthly as (
select 
    format_datetime("%Y-%m",date_administered) yearmonth, 
    sum(CUMULATIVE_1ST_DOSES) CUMULATIVE_1ST_DOSES_monthly,
    sum(CUMULATIVE_2ND_DOSES) CUMULATIVE_2ND_DOSES_monthly,
    sum(CUMULATIVE_1ST_DOSES - CUMULATIVE_2ND_DOSES) diff_1st_2nd
from
  {{ source(
    'sf_covid19_vaccinations', 'daily-data'
) }} 
group by yearmonth
order by yearmonth desc
) 
select
  *
from
  cumulative_series_monthly