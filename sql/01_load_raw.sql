-- Raw layer: read every sheet from every report and stack into one table.
-- Each SELECT tags its rows with the period and content type, since neither
-- lives in the file. Everything stays text; casting happens in 02_clean_stack.sql.
INSTALL excel;
LOAD excel;

CREATE OR REPLACE TABLE raw_engagement AS

SELECT '2023_H2' AS reporting_period, 'film' AS content_type,
       "B" AS title, "C" AS available_globally, "D" AS release_date,
       "E" AS hours_viewed, "F" AS runtime, "G" AS views
FROM read_xlsx('data/raw/2023_H2.xlsx', sheet = 'Film',
               header = false, all_varchar = true,
               range = 'B7:G20000', stop_at_empty = true)

UNION ALL

SELECT '2023_H2', 'show',
       "B", "C", "D", "E", "F", "G"
FROM read_xlsx('data/raw/2023_H2.xlsx', sheet = 'TV',
               header = false, all_varchar = true,
               range = 'B7:G20000', stop_at_empty = true)

UNION ALL

SELECT '2024_H1', 'film',
       "B", "C", "D", "E", "F", "G"
FROM read_xlsx('data/raw/2024_H1.xlsx', sheet = 'Film',
               header = false, all_varchar = true,
               range = 'B7:G20000', stop_at_empty = true)


UNION ALL

SELECT '2024_H1', 'show',
       "B", "C", "D", "E", "F", "G"
FROM read_xlsx('data/raw/2024_H1.xlsx', sheet = 'TV',
               header = false, all_varchar = true,
               range = 'B7:G20000', stop_at_empty = true)

UNION ALL

SELECT '2024_H2', 'film',
       "B", "C", "D", "E", "F", "G"
FROM read_xlsx('data/raw/2024_H2.xlsx', sheet = 'Film',
               header = false, all_varchar = true,
               range = 'B7:G20000', stop_at_empty = true)


UNION ALL

SELECT '2024_H2', 'show',
       "B", "C", "D", "E", "F", "G"
FROM read_xlsx('data/raw/2024_H2.xlsx', sheet = 'TV',
               header = false, all_varchar = true,
               range = 'B7:G20000', stop_at_empty = true)


UNION ALL

SELECT '2025_H1', 'film',
       "B", "C", "D", "E", "F", "G"
FROM read_xlsx('data/raw/2025_H1.xlsx', sheet = 'Movies',
               header = false, all_varchar = true,
               range = 'B7:G20000', stop_at_empty = true)


UNION ALL

SELECT '2025_H1', 'show',
       "B", "C", "D", "E", "F", "G"
FROM read_xlsx('data/raw/2025_H1.xlsx', sheet = 'Shows',
               header = false, all_varchar = true,
               range = 'B7:G20000', stop_at_empty = true)

UNION ALL

SELECT '2025_H2', 'film',
       "B", "C", "D", "E", "F", "G"
FROM read_xlsx('data/raw/2025_H2.xlsx', sheet = 'Movies',
               header = false, all_varchar = true,
               range = 'B7:G20000', stop_at_empty = true)

UNION ALL

SELECT '2025_H2', 'show',
       "B", "C", "D", "E", "F", "G"
FROM read_xlsx('data/raw/2025_H2.xlsx', sheet = 'Shows',
               header = false, all_varchar = true,
               range = 'B7:G20000', stop_at_empty = true)


UNION ALL

SELECT '2026_H1', 'film',
       "B", "C", "D", "E", "F", "G"
FROM read_xlsx('data/raw/2026_H1.xlsx', sheet = 'Movies',
               header = false, all_varchar = true,
               range = 'B7:G20000', stop_at_empty = true)


UNION ALL

SELECT '2026_H1', 'show',
       "B", "C", "D", "E", "F", "G"
FROM read_xlsx('data/raw/2026_H1.xlsx', sheet = 'Shows',
               header = false, all_varchar = true,
               range = 'B7:G20000', stop_at_empty = true);               