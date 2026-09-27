SELECT reporting_period, content_type, COUNT(*) AS n
FROM raw_engagement
GROUP BY reporting_period, content_type
ORDER BY reporting_period, content_type;