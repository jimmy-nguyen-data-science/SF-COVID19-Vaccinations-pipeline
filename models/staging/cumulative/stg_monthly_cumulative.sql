with cumulative_monthly as (
    select
        format_datetime("%Y-%m", date_administered) as yearmonth,
        sum(cumulative_series_completed) as cumulative_series_completed_monthly,
        sum(cumulative_single_doses) as cumulative_single_doses_monthly,
        sum(cumulative_recipients) as cumulative_recipients_monthly,
        sum(
            cumulative_series_completed / nullif(cumulative_recipients, 0)
        ) as tot_prec_series,
        sum(
            cumulative_single_doses / nullif(cumulative_recipients, 0)
        ) as tot_prec_single
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
    cumulative_monthly