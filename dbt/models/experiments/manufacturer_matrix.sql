{{ 
    config(
        materialized="table",
        name='manufacturer_matrix', 
        schema='experiment', 
		tags=['matrix']
    ) 
}}


{{
	pivot_table(
		index_columns = 'manufacturer_name', 
		pivot_column = 'weight_category', 
		aggregate_column = 'trip_distance', 
		table_name = 'analytics_experiment.car_info'
	)
}}