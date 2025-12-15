# DATA INGESTION
import dlt
from dlt.sources.sql_database import sql_database
from pathlib import Path

# Defining the file path for the
# - data , sql lite database and duckdb database
data_path = Path(__file__).parent / "data"

sql_lite_path = data_path / "sqlite-sakila.db"

duckdb_path = data_path / "sakila.duckdb"

# Creating a source (extraction part of pipeline) that defines where the data is read from
source = sql_database(credentials=f"sqlite:///{sql_lite_path}", schema="main")

# Pipeline
pipeline = dlt.pipeline(
    # pipeline name,
    pipeline_name="sakila_sqlite_duckdb",
    # destination connector
    destination=dlt.destinations.duckdb(str(duckdb_path)),
    # dataset name
    dataset_name="staging",
)


# creating a dataset/scheam for storage of the data
load_info = pipeline.run(source, write_disposition="replace")

print(load_info)
