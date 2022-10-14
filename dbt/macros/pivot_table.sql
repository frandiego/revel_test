{% macro pivot_table (columns_to_show, pivot_column, aggregate_column, table_name) %}


{%- set my_query -%}
SELECT distinct {{pivot_column}}  FROM {{table_name}} ORDER BY {{pivot_column}} ASC;
{%- endset -%}

{%- set results = run_query(my_query) -%} 

{%- if execute -%}
{#- Return the first column -#}
{%- set items = results.columns[0].values() -%}
{%- else -%}
{%- set items = [] -%}
{%- endif %}



SELECT {{columns_to_show}} ,
{%- for i in items %}
sum("{{i}}") AS "{{i}}"
{%- if not loop.last %} , {% endif -%}
{%- endfor %}
FROM (
        SELECT  {{columns_to_show}},  
        {%- for i in items %}
        CASE WHEN {{pivot_column}} = '{{i}}'  THEN {{aggregate_column}} ELSE 0 END AS "{{i}}"
        {%- if not loop.last %} , {% endif -%}
        {%- endfor %}
        FROM {{table_name}}   ) t
GROUP BY  {{columns_to_show}} 
{% endmacro %}