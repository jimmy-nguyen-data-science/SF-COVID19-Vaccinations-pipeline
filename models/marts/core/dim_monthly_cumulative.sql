with cumulative_monthly as (
    select
        *
    from
        {{ ref('stg_monthly_cumulative') }}
),

cumulative_series_monthly as (
    select
        *
    from
        {{ ref('stg_monthly_compare') }}
),

final as (
    select
        *
    from
        cumulative_series_monthly
    inner join cumulative_monthly using (yearmonth)
)

select
    *
from
    final
