/*
SELECT release_bucket, COUNT(*) AS n
FROM clean_engagement
GROUP BY release_bucket
ORDER BY n DESC;
*/

SELECT reporting_period, title, premiere_date, period_start
FROM clean_engagement
WHERE premiere_date >= period_start + INTERVAL 6 MONTH;