{{ config(
    materialized="table"
)}}

select 
    date_administered,
    CUMULATIVE_1ST_DOSES,
    CUMULATIVE_2ND_DOSES,
    round(CUMULATIVE_1ST_DOSES - CUMULATIVE_2ND_DOSES) diff_1st_2nd,
from `ads-507-final-project-340820.sf_covid19_vaccinations.daily-data` 
order by date_administered desc

 
