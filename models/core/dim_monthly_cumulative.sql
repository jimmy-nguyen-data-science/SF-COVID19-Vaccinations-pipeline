with cumulative_monthly as(
    select
      *
    from
      {{ ref('stg_monthly')}}
),
cumulative_series_monthly as (
    select
      *
    from
      {{ ref('stg_monthly_compare')}}
),
final as(
    select
      *
    from
     cumulative_series_monthly
     join cumulative_monthly using(yearmonth)
)
select
  *
from
  final