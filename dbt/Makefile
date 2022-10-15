
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

compile: ingest
	dbt compile

run: compile
	dbt run 

docs: run
	dbt docs generate

serve: docs
	dbt docs serve --port 8080