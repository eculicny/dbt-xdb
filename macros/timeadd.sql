{%- macro timeadd(part, amount_to_add, value, timestamp_cast_flag=true) -%}
    {#/* adds `amount_to_add` `part`s to `value`. so adding one hour to Jan 1 2020 01:00:00 would be timeadd('hour',1,'2020-01-01 01:00:00').
       NOTE: timeadd can handle either string or date/time types passed in `value`.
       ARGS:
         - part (string) one of 'second','minute','hour'.
         - amount_to_add (int) number of `part` units to add to `value`. Negative subtracts.
         - value (string) the date time string or column to add to.
         - timestamp_cast_flag (boolean) indicates if `value` should be internally casted to timestamp type
       RETURNS: a date time value with the amount added.
       SUPPORTS:
            - Postgres
            - Snowflake
            - BigQuery
    */#}
{%- set part = part |lower -%}
{%if part not in ('second','minute','hour') %}
    {% if part in ('day','week','month','year') %}
        {{exceptions.raise_compiler_error("date component passed to macro `timeadd()`. Did you want `dateadd()`?")}}
    {% endif %}
    {{exceptions.raise_compiler_error("macro timeadd for target does not support part value " ~ part)}}
{%- endif -%}

{%if timestamp_cast_flag is true %}

{%- if target.type ==  'postgres' -%}
    (( {{value}}::TIMESTAMP + {{amount_to_add}} * INTERVAL '1 {{part}}'))

{%- elif target.type == 'bigquery' -%}
    ((TIMESTAMP_ADD(CAST({{value}} AS TIMESTAMP), INTERVAL {{amount_to_add}} {{part|upper}})))

{%- elif target.type == 'snowflake' -%}
    ((DATEADD({{part}}, {{amount_to_add}}, {{value}}::TIMESTAMP)))

{%- else -%}
    {{exceptions.raise_compiler_error("macro does not support dateadd for target " ~ target.type ~ ".")}}
{%- endif -%}

{%- elif timestamp_cast_flag is not true %}

{%- if target.type ==  'postgres' -%}
    (( {{value}} + {{amount_to_add}} * INTERVAL '1 {{part}}'))

{%- elif target.type == 'bigquery' -%}
    ((TIMESTAMP_ADD({{value}}, INTERVAL {{amount_to_add}} {{part|upper}})))

{%- elif target.type == 'snowflake' -%}
    ((DATEADD({{part}}, {{amount_to_add}}, {{value}})))

{%- else -%}
    {{exceptions.raise_compiler_error("macro does not support dateadd for target " ~ target.type ~ ".")}}
{%- endif -%}

{%- endif -%}

{%- endmacro -%}
