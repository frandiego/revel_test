
{{ 
    config(
        materialized="table",
        name='manufacturer_weight', 
        schema='experiment'
    ) 
}}

{{
	pivot_table(
	'manufacturer_name', 
	'weight_category', 
	'trip_distance', 
	'analytics_experiment.manufacturer_weight_tabular'
)
}}