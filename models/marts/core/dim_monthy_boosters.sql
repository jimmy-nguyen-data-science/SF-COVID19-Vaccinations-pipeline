WITH month_year AS (
    SELECT
        *
    FROM
        {{ ref('stg_monthly') }}
),
final as (
    SELECT
        yearmonth,
        sum(new_booster_recipients) AS total_booster_recipients
    FROM
        month_year    
    GROUP BY
        yearmonth
)
SELECT
    *
FROM
    final
ORDER BY
        yearmonth