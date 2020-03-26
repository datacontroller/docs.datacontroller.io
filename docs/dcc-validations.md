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

|RULE_TYPE|RULE_VALUE|DESCRIPTION|
|---|---|---|
|CASE|UPCASE|Will enforce uppercase of cell values.  Valid values: UPCASE, LOWCASE|
|NOTNULL||Will prevent submission if null values are present|
|MINVAL|1|Defines a minimum value for a numeric cell|
|HARDSELECT|sashelp.class.name|A distinct list of values (max 1000) are taken from this library.member.column reference, and the value **must** be in this list|
|SOFTSELECT|LIB.DS.COL|A distinct list of values (max 1000) are taken from this library.member.column reference, and the value **may** be in this list|
