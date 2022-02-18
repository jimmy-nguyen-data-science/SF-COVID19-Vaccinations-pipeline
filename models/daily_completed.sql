with daily_completed as (
select
    format_datetime("%Y-%m-%d",date_administered) yearmonthday, 
    sum(new_booster_recipients) new_booster_recipients_day,
from `ads-507-final-project-340820.sf_covid19_vaccinations.daily-data` 
group by yearmonthday
order by yearmonthday desc
) 
 
select 
    yearmonthday,
    new_booster_recipients_day,
from daily_completed
order by yearmonthday desc