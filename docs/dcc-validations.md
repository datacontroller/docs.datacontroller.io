---
layout: article
title: Data Validation
description: Quality in, Quality out! Enforce data quality checks at the point of SAS data entry, both directly via the web interface and also via Excel uploads.
og_image: https://i.imgur.com/P64ijBB.png
---


# Data Controller for SAS® - DQ Validations

## Overview
Quality in, Quality out!  Data Controller lets you enforce quality checks at the point of data entry, both directly via the web interface and also via Excel uploads.

## Default Checks
By default, the following frontend rules are always applied:

* Length checking per target table variable lengths
* Type checking per target table datatypes
* Not Null check per target table constraints
* Primary Key checking per business key defined in MPE_TABLES

It is possible to configure a number of other rules by updating the MPE_VALIDATIONS table.  Simply set the `BASE_LIB`, `BASE_DS` and `BASE_COL` values, and ensure `RULE_ACTIVE=1` for it to be applied.

## Configurable Checks

Check back frequently as we plan to keep growing this list of checks.

|Rule Type|Example Value |Description|
|---|---|---|
|CASE|UPCASE|Will enforce the case of cell values.  Valid values: UPCASE, LOWCASE, PROPCASE|
|NOTNULL|(defaultval)|Will prevent submission if null values are present.  Optional - provide a default value.|
|MINVAL|1|Defines a minimum value for a numeric cell|
|MAXVAL|1000000|Defines a maximum value for a numeric cell|
|HARDSELECT|sashelp.class.name|A distinct list of values (max 1000) are taken from this library.member.column reference, and the value **must** be in this list.  This list may be supplemented by entries in the MPE_SELECTBOX table.|
|SOFTSELECT|dcdemo.mpe_tables.libref|A distinct list of values (max 1000) are taken from this library.member.column reference, and the value **may** be in this list.  This list may be supplemented by entries in the MPE_SELECTBOX table.|
|HARDSELECT_HOOK|/logical/folder/stpname|A SAS service (STP or Viya Job) or a path to a SAS program on the filesystem.  User provided values **must** be in this list.|
|SOFTSELECT_HOOK|/physical/path/program.sas|A SAS service (STP or Viya Job) or a path to a SAS program on the filesystem.  User provided values **may** be in this list.|

Further details on the above:

### HARDSELECT_HOOK / SOFTSELECT_HOOK

These validations enable you to present a dynamic dropdown to the user based on other values in the same **row**.  You can also use the response to populate _other_ dropdowns (also in the same row) in the same request - these are called 'extended validations'.

Your hook script can be either a SAS program on the filesystem (in which case it must end with ".sas") or it can also be a Stored Process or Viya Job in the logical folder tree (metadata or SAS Drive) - in which case it must _not_ end with ".sas".  In both cases you should provide the full path and filename in the MPE_VALIDATIONS table.

For examples of hook scripts you can look at the Data Controller internal validation programs.  In summary, you will receive the following as inputs:

* `work.source_row` -> The entire row from the source table being modified
* `&DC_LIBREF` -> The DC control library
* `&LIBDS` - The library.dataset being filtered
* `&VARIABLE_NM` - The column for which to supply the validation

The following tables should be created in the WORK library as outputs:

* `work.dynamic_values`
* `work.dynamic_extended_values` (optional)

#### DYNAMIC_VALUES
This table can contain up to three columns:

* `display_index` (optional, mandatory if using `dynamic_extended_values`).  Is a numeric key used to join the two tables.
* `display_value` - always character
* `raw_value` - unformatted character or numeric according to source data type

Example values:

|DISPLAY_INDEX:best.|DISPLAY_VALUE:$|RAW_VALUE|
|---|---|---|
|1|$77.43|77.43|
|2|$88.43|88.43|

#### DYNAMIC_EXTENDED_VALUES
This table is optional.  If provided, it will map the DISPLAY_INDEX from the DYNAMIC_VALUES table to additional column/value pairs, that will be used to populate dropdowns for _other_ cells in the _same_ row.

The following columns should be provided:

* `display_index` - a numeric key joining each value to the `dynamic_values` table
* `extra_col_name` - the name of the additional variable(s) to contain the extra dropdown(s)
* `display_value` - the value to display in the dropdown.  Always character.
* `display_type` - Either C or N depending on the raw value type
* `raw_value_num` - The unformatted value if numeric
* `raw_value_char` - The unformatted value if character
* `forced_value` - set to 1 to force this value to be automatically selected when the source value is changed. If anything else but 1, the dropdown will still appear, but the user must manually make the selection.

Example Values:

|DISPLAY_INDEX:best.|EXTRA_COL_NAME:$32.DISPLAY_VALUE:$|DISPLAY_TYPE:$1.|RAW_VALUE_NUMRAW_VALUE_CHAR:$5000|FORCED_VALUE|
|---|---|---|---|
|1|DISCOUNT_RT|"50%"|N|0.5||.|
|1|DISCOUNT_RT|"40%"|N|0.4||0|
|1|DISCOUNT_RT|"30%"|N|0.3||1|
|1|CURRENCY_SYMBOL|"GBP"|C||"GBP"|.|
|1|CURRENCY_SYMBOL|"RSD"|C||"RSD"|.|
|2|DISCOUNT_RT|"50%"|N|0.5||.|
|2|DISCOUNT_RT|"40%"|N|0.4||1|
|2|CURRENCY_SYMBOL|"EUR"|C||"EUR"|.|
|2|CURRENCY_SYMBOL|"HKD"|C||"HKD"|1|