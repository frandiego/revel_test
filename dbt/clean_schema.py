from sqlalchemy import create_engine
import logging

logging.basicConfig(level=logging.INFO)

URI = "postgresql+psycopg2://dbt:dbtpassword@postgres/revel"
SCHEMA_NAME = 'analytics'

if __name__ == "__main__":

    logging.info("cleaning schema")
    engine = create_engine(URI)
    with engine.connect() as con:
        con.execute(f'DROP SCHEMA IF EXISTS {SCHEMA_NAME} CASCADE;')
        con.execute(f'CREATE SCHEMA IF NOT EXISTS {SCHEMA_NAME};')

