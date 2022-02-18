with cumulative as (
select 
    format_datetime("%Y-%m",date_administered) yearmonth, 
    sum(cumulative_series_completed) cumulative_series_completed_monthly,
    sum(cumulative_single_doses) cumulative_single_doses_monthly,
    sum(cumulative_recipients) cumulative_recipients_monthly,
from `ads-507-final-project-340820.sf_covid19_vaccinations.daily-data` 
group by yearmonth
order by yearmonth desc
) 

select 
    yearmonth,
    cumulative_series_completed_monthly,
    cumulative_single_doses_monthly,
    round(cumulative_series_completed_monthly)/(cumulative_recipients_monthly) tot_prec_series,
    round(cumulative_single_doses_monthly)/(cumulative_recipients_monthly) tot_prec_single,
from cumulative
order by yearmonth desc