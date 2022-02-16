WITH month_date AS (
    SELECT
        *
    FROM
        { { ref('stg_month_year') } }
),
new_boost_recip AS (
    SELECT
        *
    FROM
        { { ref('stg_boost_recip') } }
),
final as (
    SELECT
        year,
        month,
        sum(new_boost_recip.new_booster_recipients) AS total_booster_recipients
    FROM
        month_date
        INNER JOIN new_boost_recip using(date_administered)
    GROUP BY
        year,
        month
    ORDER BY
        year,
        month
)
SELECT
    *
FROM
    final