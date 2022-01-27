---
layout: article
title: Roadmap
description: The Data Controller roadmap is aligned with the needs of our customers - we continue to build and prioritise on Features requested by, and funded by, new and existing customers.
og_image:  https://i.imgur.com/xFGhgg0.png
---

# Roadmap

## Overview

On this page you can find details of the Features that have currently been requested, that we agree would add value to the product, and are therefore in our development roadmap.

Where customers are paying for the new Features (eg with our discounted Developer Days offer), then those Features will always take priority.  Where funding is not available, new Features will be addressed during the Bench Time of our developers, and will always be performed after Bug Fixes.

If you would like to see a new Feature added to Data Controller, then let's have a chat!


## Requested Features

Where features are requested, whether there is budget or not, we will describe the work below and provide estimates.

There are currently three new features in development:

* Include change tracking information in a transaction table
* Ability to [view & edit formats](/formats.md)
* Ability to restore previous versions

A further two are requested:

* Ability to import complex excel data using Excel Maps (10.5 days)
* Ability to make automated submissions using an API


### Complex Excel Uploads

When Excel data arrives in multiple ranges, or individual cells, and the cells vary in terms of their column or row identifier, made more "interesting" with the use of merged cells - a rules engine becomes necessary!

This feature enables the use of "EXCEL MAPS".  It will enable multiple tables to be loaded in a single import, and that data can be scattered across multiple sheets / cells / ranges, accessed via the rules described further below.

The backend SAS tables must still exist, but the column names do not need to appear in the excel file.

To drive the behaviour, a new configuration table must be added to the control library - MPE_EXCEL_MAP.  The columns are defined as follows:

* **XLMAP_ID** - a unique reference for the excel map
* **XLMAP_LIB** - the library of the target table for the data item or range
* **XLMAP_DS** - the target table for the data item or range
* **XLMAP_COL** - the target column for the data item or range
* **XLMAP_SHEET** - the sheet name in which to capture the data.  Rules start with a forward slash (/).  Example values:
    * `Sheet2` - an absolute reference
    * `/FIRST` - the first tab in the workbook
* **XLMAP_START** - the rule used to find the top left of the range. Use "R1C1" notation to move the target.  Example values:
    * `ABSOLUTE F4` - an absolute reference
    * `MATCH P R[0]C[2] |My Test` - search column P for the string "My Test" then move 2 columns right
    * `MATCH 7 R[-2]C[-1] |Top Banana` - search row 7 for the string "Top Banana" then move 2 rows up and 1 column left
* **XLMAP_FINISH** - The rule used to find the end of the range.  Leave blank for individual cells. Example values:
    * `BLANKROW` - search down until a blank row is found, then choose the row above it
    * `LASTDOWN` - The last non blank cell below the start cell
    * `RIGHT 3` - select 3 more cells to the right (4 selected in total)


To illustrate with an example - consider the following excel.  The yellow cells need to be imported.

![Complex Excel for SAS Import](/img/excel_map.png)

The data will be imported into two SAS tables - the cells on the left will go into a table with multiple rows, and the cells on the right will be entered as a single row.  The XLMAP_ID will also be added to both tables, and the tables will need to have had their keys and quality rules defined in Data Controller in the usual way.

The MPE_EXCEL_MAP configuration entries would be as follows:

|XLMAP_ID|XLMAP_LIB|XLMAP_DS|XLMAP_COL|XLMAP_SHEET|XLMAP_START|XLMAP_FINISH|
|---|---|---|---|---|----|---|
|MAP01|MYLIB|DS1|MI_ITEM|Current Month|`MATCH B R[1]C[0] |ITEM`|`LASTDOWN`|
|MAP01|MYLIB|DS1|MI_AMT|Current Month|`MATCH C R[1]C[0] |AMOUNT`|`LASTDOWN`|
|MAP01|MYLIB|DS2|TMI|Current Month|`ABSOLUTE F6`||
|MAP01|MYLIB|DS2|CB|Current Month|`MATCH F R[2]C[0] |CASH BALANCE`||
|MAP01|MYLIB|DS2|RENT|Current Month|`MATCH E R[0]C[2] |Rent/mortgage`||
|MAP01|MYLIB|DS2|CELL|Current Month|`MATCH E R[0]C[2] |Cell phone`||

To import the excel, the end user simply needs to navigate to the UPLOAD tab, select the appropriate map (eg MAP01), and upload.  This will stage two tables (MYLIB.DS1 and MYLIB.DS2) which will go through the usual approval process and quality checks.  A copy of the source excel file will be attached to each upload.

#### Estimates

|Component|Estimate (days)|Description|
|---|---|---|
|Frontend|1|Build ExcelMap page with dropdown (and fetching rules), plus drag & drop modal for excel capture|
|Frontend|1|Create staged (unsubmitted) page with support for multiple tables|
|Frontend|2|Create standalone framework utility for rules engine (utils folder), /FIRST sheet rule and Absolute rule|
|Frontend|2|Implement MATCH rule (with BLANKROW, LASTDOWN and {DIRECTION + INTEGER} finish rules)|
|Frontend|0.5|Developer documentation|
|Frontend|2|Cypress tests|
|Backend|0.5|Prep MPE_EXCEL_MAP table, including validations, integrate with DCLIB and add to CI build|
|Backend|1|Create services to fetch Excel Maps and rules (only those the user has permissions for), corresponding SASjs tests, and update developer docs|
|Backend|0.5|Publish online documentation for the overall Excel Maps feature|

Total: **10.5 days**

### API Submissions

Described [here](https://docs.datacontroller.io/api/).

### Change Tracking
Currently, transactional changes made to tables in Data Controller are tracked by means of individual CSV files.  A user can navigate to the HISTORY tab, find their change, and download a zip file containing all relevant information such as the original excel that was uploaded, SAS logs, the change records (CSV) and the staging dataset.

Whilst helpful for investigating individual changes, the mechanism does not curently exist for (easily) tracking changes to particular variables / records across time, nor for (easily) re-instating versions.

A transaction table would fix this.  However, given that the number of changes could be quite large, this should be an optional (configurable) feature.

The proposal is as follows:

* Create a switch (new variable) in MPE_TABLES to enable tracking on a table-by-table basis
* Create an MPE_AUDIT_HISTORY table to contain records of all changes to tracked tables

Model Changes:

```sas
/* MPE_TABLES updates */
proc sql;
alter table dc.mpe_tables
  add track_changes char(1);

/* no PK defined as it is a transaction table */
create table dc.mpe_audit_history(
  load_id char(32),
  processed_dttm num format=E8601DT26.6,
  libref char(8),
  dsn char(32),
  key_hash char(32),
  move_type char(1),
  is_pk char(1),
  is_diff char(1),
  tgtvar_type char(1),
  tgtvar_nm char(32),
  oldval_num num,
  newval_num num,
  oldval_char char(32767),
  newval_char char(32767)
);
```


- [x] tidy up & define bitemporal outputs to include "base" records
- [x] update postdata service to include new outputs
- [ ] create macro to populate new audit tables if flag is set


## Delivered Features

Below are some examples of Features that have been requested (and delivered) into Data Controller.

### Dynamic Filtering

Previously, if a user filtered on, say, "region", and then filtered on "store", they would see stores for ALL regions (not just the region/regions already selected in the filter).

![](https://i.imgur.com/KDEVvDi.png)

**Solution**

We added a checkbox to the top left of the filter dialog (default ON) for "Dynamic Where Clause".  Whilst enabled, whenever a list of values is requested, it is filtered using every filter clause EXCEPT the one currently being modified.

See [documentation](/filter/).  Available from [v.3.12.](https://datacontroller.io/3-12-four-new-data-management-features/)


### Dynamic Cell Validation

When editing a value in a grid, the values presented to the user should be filtered according to additional rules, based on the values of other cells in the same row.

![](https://i.imgur.com/J1q4lqo.png)

**Solution**

We provided two new config item in the MPE_VALIDATIONS table - to links an editable column to a HOOK script via a web service.

The configuration would like like so:

![](https://i.imgur.com/8Hx05GP.png)

In this way, the entire record can be sent to SAS, for processing by the hook script, before returning the desired list of values.

The HOOK_SCRIPT can be either a SAS program on a filesystem (identified by a ".sas" extension) or the path to a registered SAS Service (STP or JES).  The latter is identified by the absence of an extension.

This approach provides maximum flexibility for delivering bespoke values in the edit grid dropdown.

See [documentation](/dynamic-cell-dropdown/).  Available from [v.3.12.](https://datacontroller.io/3-12-four-new-data-management-features/)

---

### Row Level Security

Row level security is provided by various products in both SAS 9 and Viya, based on the logged in user identity.

This is problematic for the EDIT page, which - by necessity - operates under system account credentials.

It is also the case that some customers need row level security but the data access engine does not support that.

Therefore, there was a need to configure such a feature within the Data Controller product.

**Solution**

A new table (MPE_ROW_LEVEL_SECURITY) was added to the data controller library to allow complex rules to be applied based on the SAS group and the target table. Documentation is [here](/row-level-security/)

Available from [v.3.12.](https://datacontroller.io/3-12-four-new-data-management-features/)

### Formula Preservation

Data Controller uses an OEM licence with the excellent [sheetJS](https://sheetjs.com/) library.  This enables us to read pretty much any version of Excel at breakneck speeds.

By default, Data Controller will use the data model of the target table when extracting data, eg to determine whether a column should be character, numeric, date, datetime or time.

Formats used to be ignored and only the cell _values_ would be extracted when formulas are being used.

Now, it is possible to extract and retain the actual formula itself, so it can be re-used when downloading the data again later.

**Solution**

A new table (MPE_EXCEL_CONFIG) was be added to the data controller library to allow the column with the formula to be specified.  See [documentation](/excel/)

Available from [v.3.12.](https://datacontroller.io/3-12-four-new-data-management-features/)

### Configurable Locale

When importing spreadsheets with ambiguous dates (eg 01/02 or 02/01) the ANYDTDTM. informat was using the locale of the browser (en_us) instead of that of the client's actual country, resulting in incorrect dates being loaded.  This is due to the [default behaviour](https://rawsas.com/look-out-locale-gotcha/) of the SAS Stored Process server.

**Solution**

We added a [new config item](/dcc-options/#dc_locale) so that the locale can be explicitly set for all Data Controller users.

### Restricted Viewer

Data Controller relies on metadata permissions (in SAS 9) or authorization rules (in Viya) to determine who can see which table.

We had a customer who was using Data Controller to provide data access to a company wide audience, most of whom did not have access to SAS client tools (such as Enterprise Guide) and so had not been set up in metadata before.

It was necessary to find a way to restrict the tables which certain groups could see, without having to tweak permissions in SAS Management Console.

**Solution**

We added a [new access level](/dcc-security/#view) in the MPE_SECURITY table so that access could be restricted at both TABLE and LIBRARY level.
