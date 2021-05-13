---
layout: article
title: Row Level Security
description: Restrict tables in SAS such that users can only view or edit specific rows according to filter rules you provide.
og_image:  img/rls_table.png
---

# Row Level Security

Row level security is implemented through the configuration of filter queries, that are applied at backend.  This provides a very flexible way to restrict rows - you can restrict rows for any table in SAS, be that a dataset or a database.

![](img/rls_table.png)

## Configuration

The columns in MPE_ROW_LEVEL_SECURITY should be configured as follows:

### RLS_SCOPE
Determines whether the rule applies to the VIEW page, the EDIT page, or ALL pages.

### RLS_GROUP
The SAS Group to which the rule applies.  The user could also be a member of a [DC group](/dcc-groups). If a user is in none of these groups, no rules apply. If the user is in multiple groups, then the rules for each are applied with an OR condition.

### RLS_LIBREF
The library of the target table against which the rule will be applied

### RLS_TABLE
The target table against which the rule will be applied

### RLS_GROUP_LOGIC
When creating multiple subgroups (identified by SUBGROUP_ID) this determines whether those groups are joined using an AND, or an OR condition.  This value should be the same for the entire query (unique per RLS_SCOPE/RLS_GROUP/RLS_LIBREF/RLS_TABLE combination).

### RLS_SUBGROUP_LOGIC
This determines the how individual clauses are joined at subgroup level (identified by SUBGROUP_ID).  The logic and be AND, or OR.

### RLS_SUBGROUP_ID
This variable is an integer, and used to divide a complex filter into numerous subgroups.

### RLS_VARIABLE_NM
This is the name of the variable against which a filter value will be applied

### RLS_OPERATOR
The available operator will depend on whether the column is character or numeric.  Example values:

* `=`
* `<`
* `>`
* `<=`
* `>=`
* `BETWEEN`
* `CONTAINS`
* `NE` (not equal)
* `NOT IN`

### RLS_RAW_VALUE

This is the value used to the right of the operator. It is important to enter the values in the correct format, else validation failures will ensue (the backend will reject incorrect syntax to avoid the risk of SAS code injection).

The format depends on the operator, and the variable type.

* All character values MUST be enclosed in single quotes (eg 'example')
* IN and NOT IN must be wrapped in brackets
* BETWEEN must contain an AND

If there are invalid values, an error message will be shown, identifying which value was invalid.  If you would like to inspect the validation routine, take a look at [mp_filtercheck.sas](https://core.sasjs.io/mp__filtercheck_8sas.html).

### RLS_ACTIVE
If you would like this rule to be applied, be sure this value is set to 1.

## Example Config
Example values as follows:

|RLS_SCOPE:$4|RLS_GROUP:$64|RLS_LIBREF:$8| RLS_TABLE:$32|RLS_GROUP_LOGIC:$3.|RLS_SUBGROUP_LOGIC:$3.|RLS_SUBGROUP_ID:8.|RLS_VARIABLE_NM:$32| RLS_OPERATOR_NM:$16| RLS_RAW_VALUE:$4000|RLS_ACTIVE:8.|
|---|---|---|---|---|---|---|---|---|---|---|
|EDIT|Group 1|MYLIB|MYDS|AND|AND|1|VAR_1|=|Some text value|1|
|ALL|Group 1|MYLIB|MYDS|AND|AND|1|VAR_2|IN|this|1|
|ALL|Group 1|MYLIB|MYDS|AND|AND|1|VAR_2|IN|or|1|
|VIEW|Group 1|MYLIB|MYDS|AND|AND|1|VAR_2|IN|that|1|
|ALL|Group 1|MYLIB|MYDS|AND|AND|1|VAR_3|<|42|1|
|ALL|Group 2|MYLIB|MYDS|AND|AND|1|VAR_4|Contains|;%badmacro()|1|

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
