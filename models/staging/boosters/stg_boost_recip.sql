WITH new_boost_recip AS (
    SELECT
        date_administered,
        new_booster_recipients
    FROM
        `ads-507-final-project-340820.sf_covid19_vaccinations.daily-data`
)
SELECT
    *
FROM
    new_boost_recip