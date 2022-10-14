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
* Type checking per target table datatypes (Character, Numeric, Date, Time, Datetime)
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
|SOFTSELECT|dcdemo.mpe_tables.libref|A distinct list of values (max 1000) are taken from this library.member.column reference, and the user-provided value may (or may not) be in this list.  This list may be supplemented by entries in the MPE_SELECTBOX table.|
|[HARDSELECT_HOOK](/dynamic-cell-dropdown)|/logical/folder/stpname|A SAS service (STP or Viya Job) or a path to a SAS program on the filesystem.  User provided values **must** be in this list.  Cannot be used alongside a SOFTSELECT_HOOK.|
|[SOFTSELECT_HOOK](/dynamic-cell-dropdown)|/physical/path/program.sas|A SAS service (STP or Viya Job) or a path to a SAS program on the filesystem.  User-provided values may (or may not) be in this list.  Cannot be used alongside a HARDSELECT_HOOK.|


## Dropdowns

There are now actually FIVE places where you can configure dropdowns!

1.  The [MPE_SELECTBOX](/dcc-selectbox/) table
2.  The HARDSELECT validation (library.member.column reference)
3.  The SOFTSELECT validation (library.member.column reference)
4.  The HARDSELECT_HOOK validation (SAS Program)
5.  The SOFTSELECT_HOOK validation (SAS Program)

How do these inter-operate?

Well - if you have values in MPE_SELECTBOX and/or HARDSELECT / SOFTSELECT tables, they will be merged together, and served in ADDITION to the values provided by any HOOK program.

Dropdowns are SOFT by default, unless a HARD rule is present.

Data Controller will not let you submit both a HARDSELECT_HOOK and a SOFTSELECT_HOOK on the same variable.
