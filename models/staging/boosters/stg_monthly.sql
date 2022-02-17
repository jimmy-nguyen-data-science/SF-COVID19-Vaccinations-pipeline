WITH month_year AS (
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
)
SELECT
    *
FROM
    month_year