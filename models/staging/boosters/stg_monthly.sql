WITH date AS (
    SELECT
        format_datetime("%Y-%m", date_administered) yearmonth,
        new_booster_recipients
    FROM
        { { ref('stg_boost_recip') } }
)
SELECT
    *
FROM
    date