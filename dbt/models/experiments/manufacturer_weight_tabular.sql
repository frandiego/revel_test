{{ 
    config(
        materialized="table",
        name='manufacturer_weight_tabular', 
        schema='experiment'
    ) 
}}



select 
	manufacturer_name, 
	weight_category, 
	sum(trip_distance) as trip_distance

	from {{ ref('car_info') }} l

	left join {{ source('analytics', 'trips') }} r on l.id = r.car_id 

	group by weight_category, manufacturer_name

	order by  weight_category, manufacturer_name


