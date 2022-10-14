{{ 
    config(
        materialized="table",
        name='european_prices', 
        schema='experiment'
    ) 
}}

select 
    country, 
    cylinders, 
    manufacturer_name, 
    min(price) as min_price, 
    avg(price) as avg_price, 
    max(price) as max_price
	  
from {{ ref('car_info' ) }}
group by country, cylinders, manufacturer_name
having country = 'Europe'