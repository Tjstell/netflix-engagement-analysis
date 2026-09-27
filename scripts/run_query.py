"""Run a .sql file against the project database and print the result.

Usage, from the repo root:
    python scripts/run_query.py sql/explore/inspect_2023_h2.sql
"""
import sys
from pathlib import Path

import duckdb

DB_PATH = "engagement.duckdb"


def main():
    sql_path = Path(sys.argv[1])
    sql_text = sql_path.read_text()

    con = duckdb.connect(DB_PATH)
    result = con.sql(sql_text)      # runs every statement, returns the last one
    if result is not None:          # CREATE TABLE returns nothing to display
        result.show()
    con.close()


if __name__ == "__main__":
    main()

    