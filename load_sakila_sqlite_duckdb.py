import dlt
from dlt.sources.sql_database import sql_database
from pathlib import Path

data_path = Path(__file__).parent / "data"

sql_lite_path = data_path / "sqlite-sakila.db"

duckdb_path = data_path / "sakila.duckdb"

source = sql_database(credentials=f"sqlite:///{sql_lite_path}", schema="main")

pipeline = dlt.pipeline(
    pipeline_name="sakila_sqlite_duckdb",
    destination=dlt.destinations.duckdb(str(duckdb_path)),
    dataset_name="staging",
)

load_info = pipeline.run(source, write_disposition="replace")

print(load_info)
