
clean:
	python scripts/clean_schema.py

debug: clean
	dbt debug

deps: debug
	dbt deps

seed: deps
	dbt seed

ingest: seed
	python scripts/ingest_trips.py

analytics: ingest
	dbt run --select tag:analytics

experiment: analytics
	dbt run --select tag:experiment

matrix: analytics
	dbt run --select tag:matrix

docs: matrix
	dbt docs generate

serve: docs
	dbt docs serve --port 8080