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

There are currently four features requested:

* Dynamic Filtering - 2.75 + 2.75 = 5.5days
* Dynamic Cell Validation 3.75 + 3 = 6.75 days
* Row Level Security = 4.75 days
* Formula Preservation = under review

Total: 17 days

### Dynamic Filtering

The existing filter box provides a list of values when selecting operators such as "IN", "=" etc.  The problem is that this dropdown does not consider existing filter selections.  So if a user filters on, say, "region", and then filters on "store", they will see stores for ALL regions (not just the region/regions already selected in the filter).

![](https://i.imgur.com/KDEVvDi.png)

#### Proposed Solution

We add a checkbox to the top right of the filter dialog (default ON) for "Dynamic Filtering".  Whilst enabled, whenever a list of values is requested, it is filtered using every filter clause EXCEPT the one currently being modified.

#### Technical Implementation

The frontend will pass the query to the `public/getcolvals` service in a new input table (`filtertable`) with one column (`filterline`).  The filter query will be split across multiple rows in this table.  No single row will exceed 1000 characters in length.

The backend will need to extract and safely validate the input query, to prevent the risk of SQL injection.  The query can then be used to filter the returned output.

|Developer|Task|Estimate (hours)|
|---|---|---|
|Backend|Update & document the filter query macro|4|
|Backend|Update the `public/getcolvals` service to accept the new input table, validate the query, and handle any errors|4|
|Backend|SASjs tests for malicious code injection|4|
|Backend|SASjs tests for very large clause (Valid + invalid queries exceeding 50k characters)|4|
|Backend|SASjs tests for accuracy of filtered output|4|
|Backend|Documentation of the `getcolvals` service and functional user documentation (with screenshots)|2|
|Frontend|Ensure that every filter clause is valid - currently, it is possible for two clauses (or groups) to be invalid whilst they are being worked on.|2|
|Frontend|Add filter checkbox (default on) for Dynamic Filtering|1|
|Frontend|Prepare first query, sending to `public/getcolvals`|8|
|Frontend|Tests covering all operators|4|
|Frontend|Test for multiple clauses (2 clauses and 4 clauses)|2|
|Frontend|Test for multiple grouped clauses (2 groups & 4 groups)|2|
|Frontend|Cypress tests for non logical user behaviour|2|
|Frontend|JSDoc documentation is improved / updated|1|

* Total Backend:  2.75 days
* Total Frontend: 2.75 days


### Dynamic Cell Validation

The challenge here is similar to that of [Dynamic Filtering](/roadmap/#dynamic-filtering) - when editing a value in a grid, the values presented to the user should be filtered according to additional rules, based on the values of other cells in the same row.

![](https://i.imgur.com/J1q4lqo.png)

#### Proposed Solution

Given the near infinite possibilities by which this list could be generated, the solution proposed is that provide a new config item in the MPE_VALIDATIONS table - one that links an editable column to a HOOK script via a web service.

The configuration would like like so:

![](https://i.imgur.com/8Hx05GP.png)

In this way, the entire record can be sent to SAS, for processing by the FILTER_HOOK script, before returning the desired list of values.

If RULE_VALUE is left empty, we can default to filtering according to the value of the (remaining) primary key value(s).

The HOOK_SCRIPT can be either a SAS program on a filesystem (identified by a ".sas" extension) or the path to a registered SAS Service (STP or JES).  The latter is identified by the absence of an extension.

This approach provides maximum flexibility for delivering bespoke values in the edit grid dropdown.

#### Technical Implementation

The frontend will make requests to SAS whenever a user tries to select a dropdown in a dynamic cell.  The backend will either:

* %include the .sas program, if provided
* %include the SAS code from a web service, if provided
* perform logic to filter on (remaining) PK values, if no script provided

The frontend will pause whilst this service runs.  If values are pasted (or imported), the validation will NOT take place.  This would depend on a backend validation, if this case needs to be handled.

The frontend will take an md5() hash of every value in the row (with a separator, the target column will be assigned a blank value) and store this in a global arrray.  This is used as a lookup when fetching values, to see if the record has changed or not.  This event will take place when the user selects the cell (and only that cell).  It will not take place for cells that are pasted / copied in, or for excel uploads.

The last 10 dropdown value lists will be saved.

|Developer|Task|Estimate (hours)|
|---|---|---|
|Backend|Two new validation types (SOFTSELECT_HOOK and HARDSELECT_HOOK) to be added for MPE_VALIDATIONS in MPE_SELECTBOX, and in the migration script|1|
|Backend| The `editors/getdata` service needs to mark those columns that require dynamic dropdowns, and whether they are HARD or SOFT, in a new output table|2|
|Backend|A new service (`editors/get_dynamic_col_vals`) needs to be created, with logic for auto-filtering if no hook script provided, and logic to extract Service code if no program is provided|16|
|Backend|Service Documentation added / updated for both services|1|
|Backend|User Documentation updated, including screenshots|2|
|Backend|SASjs unit tests added to test harness to cover all three configurations|8|
|Frontend|Prepare hooks for all target cols as defined in the `editors/getdata` response|2|
|Frontend|When in EDIT mode and the user selects the cell, take a hash of the values, check this in the array, and if not found - call the `editors/get_dynamic_col_vals` service (non blocking) with the currentrow as table input to SAS.  If found the previous lookup will be presented.|8|
|Frontend| If a HARD response, the cell will be red if not found.  If SOFT, new values are permitted. The user may type before the response arrives.  If a HARD select then they should not be able to submit unless the values are valid|2|
|Frontend|Prepare test environment and a series of tests covering all use cases in the Cypress test suite|8|
|Frontend|New functions are documented in JSDoc, and well explained in the developer docs (with screenshots)|4|

* Backend - 3.75 days
* Frontend - 3 days

### Row Level Security

Row level security is provided by various products in both SAS 9 and Viya, based on the logged in user identity.

This is problematic for the EDIT page, which - by necessity - operates under system account credentials.

It is also the case that some customers need row level security but the data access engine does not support that.

Therefore, there is a need to configure such a feature within the Data Controller product.

#### Proposed Solution

A new table (MPE_ROW_LEVEL_SECURITY) will be added to the data controller library with the following attributes:

|Variable|Description|
|---|---|
|RLS_SCOPE| Does the rule apply to the VIEW page, the EDIT page, or ALL pages|
|RLS_GROUP| The SAS Group to which the rule applies.  If a user is in none of these groups, no rules apply. If the user is in multiple groups, then the rules for each are applied with an OR condition.|
|RLS_LIBREF|The library of the target table|
|RLS_TABLE|The table to which to apply the rule|
|RLS_COLUMN|The column to which to apply the rule|
|RLS_OPERATOR|The operator to apply, such as `=`, `<`, `>`,`!=`, `IN` and `CONTAINS`|
|RLS_VALUE|The value to which be used in the comparator|
|RLS_ACTIVE|Set to 1 to include the record in the filter, else 0|
|||

Example values as follows:

RLS_SCOPE $4|RLS_GROUP $64|RLS_LIBREF $8| RLS_TABLE $32| RLS_COLUMN $32| RLS_OPERATOR $16| RLS_VALUE $2048|RLS_ACTIVE|
|---|---|---|---|---|---|---|---|
|EDIT|Group 1|MYLIB|MYDS|VAR_1|=|Some text value|1|
|ALL|Group 1|MYLIB|MYDS|VAR_2|IN|this|1|
|ALL|Group 1|MYLIB|MYDS|VAR_2|IN|or|1|
|VIEW|Group 1|MYLIB|MYDS|VAR_2|IN|that|1|
|ALL|Group 1|MYLIB|MYDS|VAR_3|<|42|1|
|ALL|Group 2|MYLIB|MYDS|VAR_4|Contains|;%badmacro()|1|

If a user is in Group 2, and querying an EDIT table, the query will look like this:

```
select * from mylib.myds
where ( var_4 CONTAINS ';%badmacro()' )
```

If the user is in both Group 1 AND Group 2, querying a VIEW-only table, the filter will be as follows:

```
select * from mylib.myds
where (var_2 IN ('this','or','that') AND var_3 < 42 )
  OR
    ( var_4 CONTAINS ';%badmacro()' )
```

#### Technical Implementation

The following Services will require modification to use the new macro:

* `public/getcolvals`
* `public/getrawdata`
* `public/viewdata`
* `editors/getdata`
* `editors/loadfile`
* `editors/stagedata`

The macro should also be available to developers using hook scripts in `editors/get_dynamic_col_vals`.
The implementation will be entirely backend (no impact to frontend).
Tasks include:

|Developer|Task|Estimate (hours)|
|---|---|---|
|Backend|Creation of new table using SCD2 for history retention, and inclusion in the build process|1|
|Backend|Update the migration scripts for customer upgrades|1|
|Backend|Creation & documentation of a macro to formulate the filter clause|8|
|Backend|Creation of a series (10-20) of automated SASjs tests to validate the macro logic|12|
|Backend|Including the macro in all relevant services, and updating the documentation of each|4|
|Backend|Additional tests to ensure that the updated services are working for user accounts with RLS enabled|8|
|Backend|User Documentation, including screenshots|4|


Estimates:

* Backend: 4.75 days


### Formula Preservation

Data Controller uses an OEM licence with the excellent [sheetJS](https://sheetjs.com/) library.  This enables us to read pretty much any version of Excel at breakneck speeds.

By default, Data Controller will use the data model of the target table when extracting data, eg to determine whether a column should be character, numeric, date, datetime or time.

Formats are ignored and the cell _values_ are extracted when formulas are being used.

We now have a use case that the customer would like to extract and retain the actual formula itself, so it can e re-used when downloading the data again later.

#### Proposed Solution

A new table (MPE_EXCEL_CONFIG) will be added to the data controller library with the following attributes:

|Variable|Description|
|---|---|
|XL_LIBREF|The library of the target table|
|XL_TABLE|The table to which to apply the rule|
|XL_COLUMN|The column to which to apply the rule|
|XL_RULE|The rule to apply, such as FORMULA|
|XL_ACTIVE|Set to 1 to make the rule active, else 0|
|||

#### Technical Implementation

The additional configuration table must be provided to the frontend so that any imported Excel files may have the corresponding rules applied.  Formulae will be imported as simple text strings - the target column must therefore be of character type and be fairly wide (at least $64 but preferably wider to avoid formula truncation)

|Developer|Task|Estimate (hours)|
|---|---|---|
|Backend|Creation of new table using SCD2 for history retention & include in the build process|1|
|Backend|Update the migration scripts for customer upgrades|1|
|Backend|Update the `edit/getdata` Service to include a new output table for excel config|2|
|Backend|Create a post edit hook service to ensure that any new FORMULA fields added do in fact exist, and have character type, with a minimum width of $64 4|
|Backend|SASjs tests to validate the new service output, and validation logic|8|
|Backend|Service & User Documentation, including screenshots|4|
|Frontend|Where configured, columns are extracted by formula rather than value|?|
|Frontend|Cypress tests (with corresponding excel files) are created to cover cases such as:  one formula column, 3 formula columns, formula columns where values are not formulas, complex formulas, formatted formulas.|?|
|Frontend|JSDoc documentation is updated|?|


* Total Backend: 2 days
* Total Frontend:


## Delivered Features

Below are some examples of Features that have been requested (and delivered) into Data Controller.

### Configurable Locale

When importing spreadsheets with ambiguous dates (eg 01/02 or 02/01) the ANYDTDTM. informat was using the locale of the browser (en_us) instead of that of the client's actual country, resulting in incorrect dates being loaded.  This is due to the [default behaviour](https://rawsas.com/look-out-locale-gotcha/) of the SAS Stored Process server.

#### Solution

We added a [new config item](/dcc-options/#dc_locale) so that the locale can be explicitly set for all Data Controller users.

### Restricted Viewer

Data Controller relies on metadata permissions (in SAS 9) or authorization rules (in Viya) to determine who can see which table.

We had a customer who was using Data Controller to provide data access to a company wide audience, most of whom did not have access to SAS client tools (such as Enterprise Guide) and so had not been set up in metadata before.

It was necessary to find a way to restrict the tables which certain groups could see, without having to tweak permissions in SAS Management Console.

#### Solution

We added a [new access level](/dcc-security/#view) in the MPE_SECURITY table so that access could be restricted at both TABLE and LIBRARY level.