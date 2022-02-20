WITH new_boost_recip AS (
    SELECT
        date_administered,
        new_booster_recipients
    FROM
        {{ source('sf_covid19_boosters', 'daily-data') }}
)
SELECT
    *
FROM
    new_boost_recip