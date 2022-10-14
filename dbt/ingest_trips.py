import dask.dataframe as dd
import logging


logging.basicConfig(level=logging.INFO)

URI = "postgresql+psycopg2://dbt:dbtpassword@postgres/revel"
TRIPS = "trips/trips.csv"
TABLE_NAME = 'trips'
SCHEMA_NAME = 'analytics'

if __name__ == "__main__":


    logging.info("ingesting trips into revel datatase")

    dd.read_csv(TRIPS).to_sql(
        name=TABLE_NAME,
        uri=URI,
        index=False,
        if_exists="replace",
        schema=SCHEMA_NAME,
        parallel=True,
    )

    logging.info("successfully imported data")
