{%- macro json_flatten_lateral_join(json_col, relation_alias='xdb_key_vals') -%}
    {# 
       ARGS:
         - json_col:
         - relation_alias:
       RETURNS: 
       SUPPORTS:
            - Postgres
            - Snowflake
    #}

    {{ return(adapter.dispatch('json_flatten_lateral_join', 'xdb')(json_col, relation_alias)) }}
{%- endmacro -%}

{%- macro default__json_flatten_lateral_join(json_col, relation_alias='xdb_key_vals') -%}
    {{ xdb.not_supported_exception('json_flatten_lateral_join') }}
{%- endmacro -%}

{%- macro snowflake__json_flatten_lateral_join(json_col, relation_alias='xdb_key_vals') -%}
    , lateral flatten({{ json_col }}) as {{ relation_alias }}
{%- endmacro -%}

{%- macro postgres__json_flatten_lateral_join(json_col, relation_alias='xdb_key_vals') -%}
    {# cast as jsonb incase of using json col type #}
    cross join lateral jsonb_each({{ json_col }}::jsonb) as {{ relation_alias }}(xdb_key, xdb_value)
{%- endmacro -%}
