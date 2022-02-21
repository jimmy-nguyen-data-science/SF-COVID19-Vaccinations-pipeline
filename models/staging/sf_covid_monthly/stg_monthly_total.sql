with mth_tot as (
    select
        format_datetime("%Y-%m", date_administered) as yearmonth,
        sum(new_1st_doses) as tot_new_1st_doses,
        sum(new_2nd_doses) as tot_new_2nd_doses,
        sum(new_single_doses) as tot_new_single_doses,
        sum(new_series_completed) as tot_new_series_completed,
        sum(new_recipients) as tot_new_recipients
    from
        {{ source('sf_covid19_monthly', 'daily-data') }}
    group by
        yearmonth
    order by
        yearmonth
)

select
    *
from
    mth_tot
