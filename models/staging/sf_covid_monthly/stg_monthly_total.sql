WITH mth_tot AS
(
         SELECT   format_datetime("%Y, %m",date_administered) yearmonth,
                  sum(new_1st_doses)                          tot_new_1st_doses,
                  sum(new_2nd_doses)                          tot_new_2nd_doses,
                  sum(new_single_doses)                       tot_new_single_doses,
                  sum(new_series_completed)                   tot_new_series_completed,
                  sum(new_recipients)                         tot_new_recipients
         FROM
{{ source('sf_vocid_monthly', 'daily-data')}}         
GROUP BY yearmonth          
ORDER BY yearmonth DESC ) SELECT * FROM   mth_tot 