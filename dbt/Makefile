
clean:
	python clean_schema.py

debug: clean
	dbt debug

deps: debug
	dbt deps

seed: deps
	dbt seed

ingest: seed
	python ingest_trips.py

analytics: ingest
	dbt run --select tags:analytics

experiment: analytics
	dbt run --select tags:experiment

matrix: analytics
	dbt run --select tags:matrix

docs: matrix
	dbt docs generate

serve: docs
	dbt docs serve --port 8080