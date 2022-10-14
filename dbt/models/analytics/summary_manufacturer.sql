{{ 
    config(
        materialized="table",
        name='manufacturer', 
        schema='summary'
    ) 
}}

select 
        r.id as manufacturer_id, 
        r.manufacturer_name, 
        count(l.car_id) as trip_count, 
        sum(l.trip_distance) as total_distance, 
        avg(l.trip_time) as trip_time_average

from {{ ref('car_trip_time') }} l
left join {{ ref('car_manufacturer') }} r using (car_id)

group by r.id, r.manufacturer_name

