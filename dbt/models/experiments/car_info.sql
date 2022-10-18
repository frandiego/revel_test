{{ 
    config(
        materialized="table",
        name='car_info', 
        schema='experiment', 
		tags=['experiment']
    ) 
}}


WITH aux AS (

	select
		car_id, 
		sum(trip_distance) as trip_distance

	from {{ source('analytics', 'trips') }} 

	group by car_id

)

select 
	l.id, 
	cylinders, 
	origin, 
	country, 
	weight, 
	case 
		when weight < 1000 then '<1000' 
		when weight >= 1000 and weight < 2000 then '1000-2000'
		when weight >= 2000 and weight < 3000 then '2000-3000'
		when weight >= 3000 and weight < 4000 then '3000-4000'
		when weight >= 4000 and weight < 5000 then '4000-5000'
		when weight >= 5000 then '>5000'
		end as weight_category,
	price, 
	manufacturer_name, 
	m.car_name, 
	aux.trip_distance


from {{ source('analytics', 'fleet') }} l

join {{ source('analytics', 'country') }} r using (origin)

join {{ source('analytics', 'price') }} p using (id)

join {{ ref('manufacturer') }} m on l.id = m.car_id 

join aux on aux.car_id = l.id

