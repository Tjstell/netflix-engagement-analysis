-- Raw layer: load the H2 2023 Film sheet exactly as it sits in the file.
-- No type casting and no cleaning happen here. Those belong in 02_clean_stack.sql.
-- Storing the untouched source first means every later transformation is
-- traceable back to something we can see.
INSTALL excel;
LOAD excel;

CREATE OR REPLACE TABLE raw_2023_h2_film AS
SELECT
    '2023_H2' AS reporting_period,   -- not in the file; the period is implied by which file it is
    'film'    AS content_type,       -- not in the file; implied by which sheet it is
    "B" AS title,
    "C" AS available_globally,
    "D" AS release_date,
    "E" AS hours_viewed,
    "F" AS runtime,
    "G" AS views
FROM read_xlsx(
    'data/raw/2023_H2.xlsx',
    sheet = 'Film',
    header = false,        -- row 6 is not a usable header row for our purposes
    all_varchar = true,    -- keep everything as text; we cast deliberately in the next file
    range = 'B7:G20000',   -- B7 skips the title block AND the header row, so data only
    stop_at_empty = true   -- stop at the first blank row, so footnotes below the table are excluded
);