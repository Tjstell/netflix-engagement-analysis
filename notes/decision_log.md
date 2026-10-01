# Decision Log

## Day 1

**Data source.** Netflix "What We Watched" engagement reports, downloaded from
about.netflix.com. Six semiannual files covering H2 2023 through H1 2026.
Renamed to YYYY_HN.xlsx for consistency.

**Excluded H1 2023.** The first report lacked runtime and views columns and did
not separate films from series. Including it would have meant dropping two key
columns or special-casing one file.

**Scope note.** H1 2026 is the final semiannual report; Netflix moves to annual
reporting in Q1 2027.

**Film Sheet** Five-row title block, Headers on row 6, and an empty leading column A.
Data spans columns B through G.

**Arithmetic Check** Views are hours divided by runtime. Convert runtime from
Hours:Minutes to a decimal for hours to calculate.

## Day 2

**Sheet naming convention** Starting in 2025, Netflix changed the sheet names from
Film/TV to Movies/Shows. Changed the sheet name in the loader to reflect that.

**Stacked tables** The stacked raw table holds ~97,700 title rows across six periods
and two content types, with H2 2023 verified against Netflix's published counts.

**Other Movies/Shows** Netflix added "Other Movies" and "Other Shows" summary rows starting H2 2025, bucketing unlisted small titles with masked values. These are excluded in the cleaning layer because the analysis is title-level, while the raw layer keeps them for fidelity.

