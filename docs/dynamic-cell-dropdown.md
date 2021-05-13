---
layout: article
title: Dynamic Cell Dropdown
description: Configure SAS programs to determine exactly which values can appear within which cells in your Data Controller table!
og_image:  img/cell_validation1.png
---

# Dynamic Cell Dropdown

This is a simple, but incredibly powerful feature!  Configure a SAS process to run when clicking a particular cell.  Data Controller will send the *row* to SAS, and your SAS program can use the values in the row determine a *column* of values to send back - which will be used in the frontend selectbox.

So if you'd like the user to only see products for a particular category, or ISIN's for a particular asset group, you can perform that easily.

## Frontend Configuration

Open the MPE_VALIDATIONS table and configure the library, table and column that should contain the selectbox.  In the RULE_TYPE column, enter either:

* HARDSELECT_HOOK - The user entry MUST match the returned values
* SOFTSELECT_HOOK - The user can view the list but type something else if they wish

The RULE_VALUE column should contain the full path to the SAS Program, Viya Job or SAS 9 Stored process that you would like to execute.  If the value ends in ".sas" then it is assumed to be a SAS program on a directory, otherwise a SAS web service (STP or Viya Job).

## Backend Configuration
If creating a Stored Process, be sure to deselect the 'automatic SAS macros' - the presence of %stpbegin or %stpend autocall macros will cause problems with the Data Controller backend.

You can write any SAS code you wish - you will receive a table called `work.source_row`, and you should create a table with one column named `work.dynamic_values`.  These are the values that will be subsequently returned to the dropdown in the cell that the user has seleected.

Example code:

```sas
/**
  @file
  @brief dynamic cell dropdown for product code
  @details The input table is simply one row from the
  target table called "work.source_row".

  Available macro variables:
    @li MPELIB - The DC control library
    @li LIBDS - The library.dataset being filtered
    @li VARIABLE_NM - The column being filtered


  <h4> Service Outputs </h4>
  Output should be a single table called
  "work.dynamic_values" in the format below.

  |DISPLAY_VALUE:$|RAW_VALUE:??|
  |---|---|
  |$44.00|44|

**/

%dc_assignlib(READ,mylibref)
proc sql;
create table work.DYNAMIC_VALUES as
  select distinct some_product as raw_value
  from mylibref.my_other_table
  where area in (select area from work.source_row)
  order by 1;

```

This feature is used extensively in Data Controller to fetch tables specific to a library, or columns specific to a table:

![](img/cell_validation1.png)

