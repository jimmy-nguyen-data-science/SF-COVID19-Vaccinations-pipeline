WITH day_month_year AS (
    SELECT
        date_administered,
        EXTRACT(
            DAY
            FROM
                date_administered
        ) AS day,
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
         {{ source('sf_covid19_vaccinations', 'daily-data')}}
)
SELECT
    *
FROM
    day_month_year