
{{ config(
    materialized="table")
}}

select 

    date_administered,
    new_series_completed,
    round(avg(new_series_completed) over (order by date_administered rows between 6 preceding and current row), 2) tot_rolling_avg_7_days,
    round(avg(new_booster_doses) over (order by date_administered rows between 6 preceding and current row), 2) cooster_rolling_avg_7_days

from `ads-507-final-project-340820.sf_covid19_vaccinations.daily-data`  
order by date_administered desc