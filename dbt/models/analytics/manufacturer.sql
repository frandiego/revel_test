{{ 
    config(
        materialized="table",
        name='manufacturer', 
        tags=['analytics']
    ) 
}}

with AUX AS (

SELECT 
	id AS car_id, 
	car_name, 
    {{  split_part(string_text='car_name', delimiter_text="' '", part_number=1) }} AS manufacturer_name
	
FROM {{ source('analytics', 'fleet') }}

)

SELECT 
    {{ dbt_utils.surrogate_key(['manufacturer_name']) }} as id, 
    manufacturer_name, 
    car_id, 
    car_name

FROM AUX



