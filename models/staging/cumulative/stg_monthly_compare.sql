with cumulative_series_monthly as (
    select
        format_datetime("%Y-%m", date_administered) as yearmonth,
        sum(cumulative_1st_doses) as cumulative_1st_doses_monthly,
        sum(cumulative_2nd_doses) as cumulative_2nd_doses_monthly,
        sum(cumulative_1st_doses - cumulative_2nd_doses) as diff_1st_2nd
    from
        {{ source('sf_covid19_cumulative', 'daily-data') }}
    group by
        yearmonth
    order by
        yearmonth desc
)

select
    *
from
    cumulative_series_monthly
