-- Clean layer (silver): cast every column to its real type, parse runtime and
-- dates, derive analysis columns, and drop Netflix's "Other" summary rows.
-- Reads from raw_engagement; writes the analysis-ready clean_engagement.

CREATE OR REPLACE TABLE clean_engagement AS
WITH typed AS (
    SELECT
        reporting_period,
        content_type,
        title,
        available_globally,
        TRY_CAST(hours_viewed AS BIGINT) AS hours_viewed,
        TRY_CAST(views AS BIGINT)        AS views,
        TRY_CAST(split_part(runtime, ':', 1) AS INTEGER)
          + TRY_CAST(split_part(runtime, ':', 2) AS INTEGER) / 60.0 AS runtime_hours,
        TRY_CAST(release_date AS DATE)   AS premiere_date,
        CASE
            WHEN release_date IS NULL THEN 'licensed'
            ELSE 'netflix_original'
        END AS title_origin,
        CASE
            WHEN reporting_period LIKE '%_H1'
            THEN TRY_CAST(split_part(reporting_period, '_', 1) || '-01-01' AS DATE)
            ELSE TRY_CAST(split_part(reporting_period, '_', 1) || '-07-01' AS DATE)
        END AS period_start
    FROM raw_engagement
    WHERE NOT (title LIKE 'Other %' AND views = '*')   -- drop summary rows, keep real "Other" titles
)
SELECT
    *,
    CASE
        WHEN premiere_date IS NULL THEN 'licensed'
        WHEN premiere_date >= period_start THEN 'new_this_period'
        ELSE 'back_catalog'
    END AS release_bucket
FROM typed;