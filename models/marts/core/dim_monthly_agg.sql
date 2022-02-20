with mth_tot as (
  select
    *
  from
    { { ref('stg_monthly_total') } }
),
mth_avg as (
  select
    *
  from
    { { ref('stg_monthly_avg') } }
),
final as (
  select
    *
  from
    mth_avg
    join mth_tot using (yearmonth)
)
select
  *
from
  final
ORDER BY
  yearmonth