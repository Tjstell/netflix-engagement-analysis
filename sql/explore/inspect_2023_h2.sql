-- Look at the top of the Film sheet with no assumptions, to confirm
-- where the header row sits and what the values actually look like.
INSTALL excel;
LOAD excel;

SELECT *
FROM read_xlsx(
    'data/raw/2023_H2.xlsx',
    sheet = 'TV',
    header = false,
    all_varchar = true,
    range = 'B6:G12'
);