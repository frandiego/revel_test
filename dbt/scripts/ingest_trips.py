import dask.dataframe as dd
import pandas as pd
import logging


logging.basicConfig(level=logging.INFO)

URI = "postgresql+psycopg2://dbt:dbtpassword@postgres/revel"
TRIPS_FEATHER = "trips.fth"
TRIPS_CSV = 'trips.csv'
TABLE_NAME = 'trips'
SCHEMA_NAME = 'analytics'

if __name__ == "__main__":
    logging.info("from feather to csv")
    pd.read_feather(TRIPS_FEATHER).to_csv(TRIPS_CSV, index=False)

    logging.info("ingesting trips into revel datatase")

    dd.read_csv(TRIPS_CSV).to_sql(
        name=TABLE_NAME,
        uri=URI,
        index=False,
        if_exists="replace",
        schema=SCHEMA_NAME,
        parallel=True,
    )

    logging.info("successfully imported data")
