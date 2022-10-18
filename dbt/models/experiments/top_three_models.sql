{{ 
    config(
        materialized="table",
        name='top_three_models', 
        schema='experiment', 
        tags=['experiment']
    ) 
}}


with cars as (

select 
	
	car_id, 
	sum(trip_distance) as total_distance, 
	sum(trip_time) as total_time

from {{ ref ('view_car_trip_time') }}
group by car_id
having sum(trip_distance) > 12000


), 

car_rank as (
select car_id, car_name, manufacturer_name, total_distance, total_time , 
rank() over (partition by manufacturer_name order by total_time desc) as time_rank
from cars join {{ ref ('manufacturer') }} using (car_id)
)
select * from car_rank where time_rank<=3