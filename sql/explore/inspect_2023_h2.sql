-- Look at the top of the Film sheet with no assumptions, to confirm
-- where the header row sits and what the values actually look like.
INSTALL excel;
LOAD excel;

SELECT *
FROM read_xlsx(
    'data/raw/2023_H2.xlsx',
    sheet = 'Film',
    header = false,      -- do not treat any row as column names yet
    all_varchar = true,  -- read every cell as text, no type guessing
    range = 'B6:G12'       -- just the first 12 rows
);