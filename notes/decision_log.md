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