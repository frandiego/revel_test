{{ 
    config(
        materialized="view",
        name='trip_time'
    ) 
}}

select 
    car_id,
    trip_distance,
    start_time, 
    end_time, 
    {{ datediff('start_time', 'end_time', 'minute') }} as trip_time
    
from {{ source('analytics', 'trips') }}

