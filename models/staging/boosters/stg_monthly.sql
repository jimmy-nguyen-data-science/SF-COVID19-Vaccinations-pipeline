WITH date AS (
    SELECT
        new_booster_recipients,
        format_datetime("%Y-%m", date_administered) AS yearmonth
    FROM
        {{ ref('stg_boost_recip') }}
)

SELECT
    *
FROM
    date
