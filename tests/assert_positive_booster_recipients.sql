with
monthly_boosters as (
    select *
    from {{ ref('stg_monthly')}}
)

select yearmonth, sum(new_booster_recipients) as total_booster_recipients
from monthly_boosters
group by yearmonth
having total_booster_recipients < 0
ORDER BY yearmonth