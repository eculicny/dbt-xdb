
# XDB Available Macros

These macros carry functionality across **Snowflake** and **Postgresql**, and most also support **BigQuery**. Individual support listed below.


### [hash](../macros/hash.sql)
**xdb.hash** (**fields** _list_)

- fields one of field names to hash together

**Returns**:          A string representing hash of `fields`
##### Supports: _Postgres, Snowflake, BigQuery_
----


### [last_value](../macros/last_value.sql)
**xdb.last_value** (**col** _string_, **data_type** _string_, **partition_by** _string_, **order_by** _string_)

Window function that returns the last value within an ordered group of values.

- col : the column to get the value from
- data_type : the data type to cast col to
- partition_by : the expression to be partitioned by, e.g. "id, type"
- order_by : the expression to order the partitioned data by, e.g. "date DESC"

**Returns**:        The last value within an ordered group of values.
##### Supports: _Postgres, Snowflake_
----


### [linear_interpolate](../macros/linear_interpolate.sql)
**xdb.linear_interpolate** (**x_i** _numeric_, **x_0** _numeric_, **y_0** _numeric_, **x_1** _numeric_, **y_1** _numeric_)

Calculates linearly interpolated value given two data points

- x_i : the x value to calculate the interpolated value for
- x_0 : x value of first data point
- y_0 : y value of first data point
- x_1 : x value of second data point
- y_1 : y value of second data point

**Returns**:        linearly interpolated value (numeric)
##### Supports: _All, no DB specific behavior (purely arithemtic)_
----


### [regexp_replace](../macros/regexp.sql)
**xdb.regexp_replace** (**val** _string/column_, **pattern** _string_, **replace** _string_)



- val the value to search for `pattern`.
- pattern the native regex pattern to search for.
- replace the string to insert in place of `pattern`.

**Returns**:      the updated string. 
##### Supports: _Postgres, Snowflake, BigQuery_
----


### [timestamp_to_date_part](../macros/timestamp_to_date_part.sql)
**xdb.timestamp_to_date_part** (**timestamp_t** _timestamp_, **date_part** _string_)

Ensures that result of EXTRACT in Snowflake is a double to match the default behavior of EXTRACT in postgres

- timestamp_t : timestamp to extract the date_part from
- date_part : tested for 'epoch', 'year', 'month', 'day', 'hour', 'minute', 'second'

**Returns**:        double 
##### Supports: _Postgres, Snowflake_
----


### [aggregate_strings](../macros/aggregate_strings.sql)
**xdb.aggregate_strings** (**val** _None_, **delim** _None_)




**Returns**: 
##### Supports: _Postgres, Snowflake, BigQuery_
----


### [any_value](../macros/any_value.sql)
**xdb.any_value** (**val** _None_)




**Returns**: 
##### Supports: _Postgres, Snowflake, BigQuery, Redshift_
----


### [array_index](../macros/array_index.sql)
**xdb.array_index** (**index** _None_)



- Index the 0 based index to convert

**Returns**:      The right position for the right database
##### Supports: _Postgres, Snowflake, BigQuery_
----


### [cast_timestamp](../macros/cast_timestamp.sql)
**xdb.cast_timestamp** (**val** _identifier/date/timestamp_, **cast_as** _string_)

converts `val` to either a timestamp with timezone or a timestamp without timezone (per `cast_as`).

- val the value to be cast.
- cast_as the destination data type, supported are `timestamp_tz` and `timestamp(_ntz)`

**Returns**:         The value typed as either timestamp or timestamp_ntz **with UTC time zone**
##### Supports: _Postgres, Snowflake, BigQuery_
----


### [dateadd](../macros/dateadd.sql)
**xdb.dateadd** (**part** _string_, **amount_to_add** _int_, **value** _string_)

adds `amount_to_add` `part`s to `value`. so adding one day to Jan 1 2020 would be dateadd('day',1,'2020-01-01').
       NOTE: dateadd only manipulates date values. for time additions see [timeadd](#timeadd)

- part one of 'day','week','month','year'.
- amount_to_add number of `part` units to add to `value`. Negative subtracts.
- value the date string or column to add to.

**Returns**:         a date value with the amount added.
##### Supports: _Postgres, Snowflake, BigQuery_
----


### [datediff](../macros/datediff.sql)
**xdb.datediff** (**part** _string_, **left_val** _date/timestamp_, **right_val** _date/timestamp_, **date_format** _pattern_)

determines the delta (in `part` units) between first_val and second_val.
       *Note* the order of left_val, right_val is reversed from Snowflake.

- part one of 'second', 'minute', 'hour', 'day', 'week', 'month', 'year', 'quarter'
- left_val the value before the minus in the equation "left - right"
- right_val the value after the minus in the equation "left - right"
- date_format a string pattern for the provided arguments (primarily for BigQuery)

**Returns**:         An integer representing the delta in `part` units
##### Supports: _Postgres, Snowflake, BigQuery_
----


### [fold](../macros/fold.sql)
**xdb.fold** (**val** _None_)




**Returns**: 
##### Supports: _Postgres, Snowflake, BigQuery_
----


### [generate_daily_time_series_values](../macros/generate_daily_time_series_values.sql)
**xdb.generate_daily_time_series_values** (**start_date** _date_, **stop_date** _date_)

Used in conjunction with generate_daily_time_series_from, this macro returns a time series
        of values based on the start_date and stop_date using 1 day increments

- start_date the start date of the series
- stop_date the ending date of the series

**Returns**:         A new column containing the generated series.
##### Supports: _Postgres, Snowflake_
----


### [generate_uuid](../macros/generate_uuid.sql)
**xdb.generate_uuid** (**type** _string='v4'_)

Generates a UUID of the specified version. Currently only v4 UUIDs are supported.


**Returns**: A new UUID typed as a string
##### Supports: _Postgres, Snowflake_
----


### [interval_to_timestamp](../macros/interval_to_timestamp.sql)
**xdb.interval_to_timestamp** (**part** _string_, **val** _integer representing a unit of time_)

converts and interval `val` to a timestamp
       *Note* the order of left_val, right_val is reversed from Snowflake.

- part one of 'second', 'minute'
- val the value

**Returns**:         A string representing the time in HH24:MM:SS format
##### Supports: _Postgres, Snowflake, BigQuery_
----


### [json_extract_path_text](../macros/json_extract_path_text.sql)
**xdb.json_extract_path_text** (**column** _json_, **path_vals** _list_)

Given a json column named `column`, extracts the value by traversing the object via the values in the `path_vals` list.

**Returns**: The value as a string at the given path within the json, or `NULL` if the path does not exist

The `path_vals` argument can be a combination of strings and integers. In general, integers will be treated as json array indexing unless they are typed as strings (e.g. "0" instead of 0).

Note that in some DBs, the context is used for extraction.
- Postgres: `'0'` will indicate the key `"0"` or `[0]` (first array item) based on the object it is requested of.


##### Supports: _Postgres, Snowflake_
----


### [not_supported_exception](../macros/not_supported_exception.sql)
**xdb.not_supported_exception** (**_name** _None_)

Macro that is called when another macro is used on an unsupported target database type.

**Raises and exception**
##### Supports: _All_
----


### [quote_insensitive](../macros/quote_insensitive.sql)
**xdb.quote_insensitive** (**identifier** _string_)

Correctly quotes identifers to match the native folding for the target data warehouse.
       Per the SQL spec this _should_ be to uppercase, but this is not always the standard.

- identifier the column / database / relation name to be folded and quoted.

**Returns**:         The `identifier` value correctly folded **and wrapped in double quotes**.
##### Supports: _Postgres, Snowflake, BigQuery_
----


### [regexp](../macros/regexp.sql)
**xdb.regexp** (**val** _None_, **pattern** _None_, **flag** _None_)




**Returns**: 
##### Supports: _Postgres, Snowflake, BigQuery_
----

### [regexp_count](../macros/regexp.sql)
**xdb.regexp_count** (**value** _string_, **pattern** _string_)

counts how many instances of `pattern` in `value`

- value the subject to be searched
- pattern the regex pattern to search for

**Returns**:         An integer count of patterns in value
##### Supports: _Postgres, Snowflake, BigQuery_
----

### [split](../macros/split.sql)
**xdb.split** (**_column** _None_, **delimeter** _string_)

Splits the supplied string into an array based on the delimiter

- split_column the column / database / relation name to be split.
- delimeter the delimeter to use when splitting the split_column

**Returns**:         An array of the split string
##### Supports: _Postgres, Snowflake, BigQuery_
----


### [split_to_table](../macros/split_to_table.sql)
**xdb.split_to_table** (**split_column** _string_, **delimeter** _string_)

Splits the supplied string type column into rows based on the delimeter

- split_column the column / database / relation name to be split.
- delimeter the delimeter to use when splitting the split_column

**Returns**:         A new column containing the split data.
##### Supports: _Postgres, Snowflake, BigQuery_
----


### [split_to_table_values](../macros/split_to_table_values.sql)
**xdb.split_to_table_values** (**table_array** _string_)

Used in conjunction with split_to_table, this macro returns the split_to_table
        values associated with the split_to_table macro
    NOTE: This is a wrapper macro for unnest_values.

- table_array the table array form of the split_column.

**Returns**:         A new column containing the split data.
##### Supports: _Postgres, Snowflake, BigQuery_
----


### [strip_to_single_line](../macros/strip_to_single_line.sql)
**xdb.strip_to_single_line** (**str** _None_)

This removes all side-effect formatting from nested macros, producing a single line sql statement

**Returns**: String
##### Supports: _All (not a SQL macro)_
----


### [test_does_not_contain](../macros/test_does_not_contain.sql)
**xdb.test_does_not_contain** (**model** _None_, **substring** _None_, **column_name** _None_)




**Returns**:
##### Supports: _Most (DB needs CTE support)_
----


### [timeadd](../macros/timeadd.sql)
**xdb.timeadd** (**part** _string_, **amount_to_add** _int_, **value** _string_)

adds `amount_to_add` `part`s to `value`. so adding one hour to Jan 1 2020 01:00:00 would be timeadd('hour',1,'2020-01-01 01:00:00').
       NOTE: timeadd only manipulates time values. for date additions see [dateadd](#dateadd)

- part one of 'second','minute','hour'.
- amount_to_add number of `part` units to add to `value`. Negative subtracts.
- value the date time string or column to add to.

**Returns**:         a date time value with the amount added.
##### Supports: _Postgres, Snowflake, BigQuery_
----


### [unnest](../macros/unnest.sql)
**xdb.unnest** (**array_to_** _None_)

Takes an array and splits it into rows of values

- array_to_unnest the array to unnest.

**Returns**:         A new column containing the split data.
##### Supports: _Postgres, Snowflake, BigQuery_
----


### [unnest_values](../macros/unnest_values.sql)
**xdb.unnest_values** (**table_array** _string_)

Used in conjunction with unnest, this macro returns the unnested
        values associated with the unnest macro

- table_array the table array form of the split_column.

**Returns**:         A new column containing the split data.
##### Supports: _Postgres, Snowflake, BigQuery_
----


### [using](../macros/using.sql)
**xdb.using** (**rel_1** _None_, **rel_2** _None_, **col** _None_)




**Returns**: 
##### Supports: _Postgres, Snowflake, BigQuery, Redshift_
----


----
## Internal Macros

### [_concat_cast_fields](../macros/concat.sql)
**xdb._concat_cast_fields** (**fields** _None_, **convert_null** _None_)

**Returns**: 
##### Supports: _Postgres, Snowflake, BigQuery_
----


### [_concat_separator_text](../macros/concat.sql)
**xdb._concat_separator_text** (**separator** _None_)

**Returns**: 
##### Supports: _All (not a SQL macro)_
----


### [_fold](../macros/fold.sql)
**xdb._fold** (**val** _string_)

- val : the value to be folded.

**Returns**:      `val` either upper or lowercase (or unfolded), per the target adapter spec.
##### Supports: _Postgres, Snowflake, BigQuery_
----


### [_not_supported_exception](../macros/not_supported_exception.sql)
**xdb._not_supported_exception** (**_name** _None_)

- macro_name : the name of the macro throwing the exception.

**Returns**:          None
##### Supports: _All (not a SQL macro)_
----


### [_regex_string_escape](../macros/regexp.sql)
**xdb._regex_string_escape** (**pattern** _string_)

applies the weird escape sequences required for bigquery and snowflake

- pattern the regex pattern to be escaped

**Returns**:         A properly escaped regex string
##### Supports: _Postgres, Snowflake, BigQuery_
----