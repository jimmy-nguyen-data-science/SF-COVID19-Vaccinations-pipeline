WITH dates AS (
    SELECT
        date_administered,
        EXTRACT(
            MONTH
            FROM
                date_administered
        ) AS month,
        EXTRACT(
            YEAR
            FROM
                date_administered
        ) AS year
    FROM
        `ads-507-final-project-340820.sf_covid19_vaccinations.daily-data`
),
boost_recip AS (
    SELECT
        date_administered,
        new_booster_recipients
    FROM
        `ads-507-final-project-340820.sf_covid19_vaccinations.daily-data`
),
final as (
    SELECT
        year, 
        month,
        sum(boost_recip.new_booster_recipients) AS total_booster_recipients
    FROM
        dates
        INNER JOIN boost_recip using(date_administered)
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
