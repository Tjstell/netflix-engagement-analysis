/*
SELECT
    reporting_period,
    content_type,
    title,
    available_globally,
    TRY_CAST(hours_viewed AS BIGINT) AS hours_viewed,
    TRY_CAST(views AS BIGINT)        AS views
FROM raw_engagement
LIMIT 10;
*/

/*
-- Piece 1 check: how many casts failed?
SELECT
    COUNT(*)                                           AS total_rows,
    COUNT(*) - COUNT(TRY_CAST(hours_viewed AS BIGINT)) AS hours_failed,
    COUNT(*) - COUNT(TRY_CAST(views AS BIGINT))        AS views_failed
FROM raw_engagement;
*/

/*
-- What 4 views failed?
SELECT reporting_period, content_type, title, hours_viewed, runtime, views
FROM raw_engagement
WHERE views IS NOT NULL
  AND TRY_CAST(views AS BIGINT) IS NULL;

  SELECT DISTINCT reporting_period, content_type, title, hours_viewed, views
FROM raw_engagement
WHERE title LIKE 'Other %';

SELECT reporting_period, content_type, title, views
FROM raw_engagement
WHERE title LIKE 'Other %' AND views = '*';
*/

/*
SELECT
    reporting_period,
    title,
    runtime,
    TRY_CAST(split_part(runtime, ':', 1) AS INTEGER)
      + TRY_CAST(split_part(runtime, ':', 2) AS INTEGER) / 60.0  AS runtime_hours,
    release_date,
    TRY_CAST(release_date AS DATE)                               AS premiere_date,
    CASE
        WHEN release_date IS NULL THEN 'licensed'
        ELSE 'netflix_original'
    END                                                          AS title_origin,
    CASE
        WHEN reporting_period LIKE '%_H1'
        THEN TRY_CAST(split_part(reporting_period, '_', 1) || '-01-01' AS DATE)
        ELSE TRY_CAST(split_part(reporting_period, '_', 1) || '-07-01' AS DATE)
    END                                                          AS period_start
FROM raw_engagement
WHERE NOT (title LIKE 'Other %' AND views = '*')
LIMIT 15;
*/

/*
SELECT
    runtime,
    TRY_CAST(split_part(runtime, ':', 1) AS INTEGER)
      + TRY_CAST(split_part(runtime, ':', 2) AS INTEGER) / 60.0  AS runtime_hours
FROM raw_engagement
WHERE runtime IS NOT NULL
LIMIT 10;
*/

/*
SELECT
    release_date,
    TRY_CAST(release_date AS DATE) AS premiere_date,
    CASE
        WHEN release_date IS NULL THEN 'licensed'
        ELSE 'netflix_original'
    END AS title_origin
FROM raw_engagement
LIMIT 20;
*/

SELECT
    reporting_period,
    -- first day of the reporting period, built from the period string
    CASE
        WHEN reporting_period LIKE '%_H1'
        THEN TRY_CAST(split_part(reporting_period, '_', 1) || '-01-01' AS DATE)
        ELSE TRY_CAST(split_part(reporting_period, '_', 1) || '-07-01' AS DATE)
    END AS period_start
FROM raw_engagement
GROUP BY reporting_period
ORDER BY reporting_period;