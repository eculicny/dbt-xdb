{%- macro json_flatten_select_value(relation_alias='xdb_key_vals', key_alias='xdb_json_key', value_alias='xdb_value_key', value_to_text=True) -%}
    {# 
       ARGS:
         - relation_alias:
         - key_alias:
         - value_alias:
         - value_to_text:
       RETURNS: 
       SUPPORTS:
            - Postgres
            - Snowflake
    #}

    {{ return(adapter.dispatch('json_flatten_select_value', 'xdb')(relation_alias, key_alias, value_alias, value_to_text)) }}
{%- endmacro -%}

{%- macro default__json_flatten_select_value(relation_alias='xdb_key_vals', key_alias='xdb_json_key', value_alias='xdb_value_key', value_to_text=True) -%}
    {{ xdb.not_supported_exception('json_flatten_select_value') }}
{%- endmacro -%}

{%- macro snowflake__json_flatten_select_value(relation_alias='xdb_key_vals', key_alias='xdb_json_key', value_alias='xdb_value_key', value_to_text=True) -%}
    {{ relation_alias }}.xdb_key as {{ key_alias }},
    {{ relation_alias }}.xdb_value{%- if value_to_text -%}::varchar{%- endif %} as {{ value_alias }}
{%- endmacro -%}

{%- macro postgres__json_flatten_select_value(relation_alias='xdb_key_vals', key_alias='xdb_json_key', value_alias='xdb_value_key', value_to_text=True) -%}
    {{ relation_alias }}.xdb_key as {{ key_alias }},
    {{ relation_alias }}.xdb_value{%- if value_to_text -%}->>0{%- endif %} as {{ value_alias }}
{%- endmacro -%}
