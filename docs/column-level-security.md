---
layout: article
title: Column Level Security
description: Column Level Security prevents end users from viewing or editing specific columns in SAS according to their group membership.
og_image:  https://docs.datacontroller.io/img/rls_table.png
---

!!! warning
    In development - coming soon!

# Column Level Security

Column level security is implemented by mapping _allowed_ columns to a list of SAS groups. In VIEW mode, only allowed columns are visible.  In EDIT mode, allowed columns are _editable_ - the remaining columns are read-only.

## Configuration

The variables in MPE_COLUMN_LEVEL_SECURITY should be configured as follows:

### CLS_SCOPE
Determines whether the rule applies to the VIEW page, the EDIT page, or ALL pages.  The impact of the rule varies as follows:

#### VIEW Scope

When `CLS_SCOPE in ('VIEW','ALL')` then only the listed columns are _visible_ (unless `CLS_HIDE=1`)

#### EDIT Scope

When `CLS_SCOPE in ('EDIT','ALL')` then only the listed columns are _editable_ (the remaining columns are read-only, and visible).  Furthermore:

* The user will be unable to ADD or DELETE records.
* Primary Key values are always read only 
* Primary Key values cannot be hidden (`CLS_HIDE=1` will have no effect)


### CLS_GROUP
The SAS Group to which the rule applies.  The user could also be a member of a [DC group](/dcc-groups). 

 - If a user is in ANY of the groups, the columns will be restricted.  
 - If a user is in NONE of the groups, no restrictions apply (all columns available).
 - If a user is in MULTIPLE groups, they will see all allowed columns across all groups.

### CLS_LIBREF
The library of the target table against which the security rule will be applied

### CLS_TABLE
The target table against which the security rule will be applied

### CLS_VARIABLE_NM
This is the name of the variable against which the security rule will be applied.  Note that 

### CLS_ACTIVE
If you would like this rule to be applied, be sure this value is set to 1.

### CLS_HIDE
This variable can be set to `1` to _hide_ specific variables, which allows greater control over the EDIT screen in particular.  CLS_SCOPE behaviour is impacted as follows:

* `ALL` - the variable will not be visible in either VIEW or EDIT.
* `EDIT` - the variable will not be visible.  **Cannot be applied to a primary key column**.
* `VIEW` - the variable will not be visible.  Can be applied to a primary key column.  Simply omitting the row, or setting CLS_ACTIVE to 0, would result in the same behaviour.

It is possible that a variable can have multiple values for CLS_HIDE, eg if a user is in multiple groups, or if different rules apply for different scopes.  In this case, if the user is any group where this variable is NOT hidden, then it will be displayed.


## Example Config
Example values as follows:

|CLS_SCOPE:$4|CLS_GROUP:$64|CLS_LIBREF:$8| CLS_TABLE:$32|CLS_VARIABLE_NM:$32|CLS_ACTIVE:8.|CLS_HIDE:8.|
|---|---|---|---|---|---|---|
|EDIT|Group 1|MYLIB|MYDS|VAR_1|1||
|ALL|Group 1|MYLIB|MYDS|VAR_2|1||
|ALL|Group 2|MYLIB|MYDS|VAR_3|1||
|VIEW|Group 1|MYLIB|MYDS|VAR_4|1||
|EDIT|Group 1|MYLIB|MYDS|VAR_5|1|1|


If a user is in Group 1, and viewing `MYLIB.MYDS` in EDIT mode, **all** columns will be visible but only the following columns will be editable:

* VAR_1
* VAR_2

The user will be unable to add or delete rows.

If the user is in both Group 1 AND Group 2, viewing `MYLIB.MYDS` in VIEW mode, **only** the following columns will be visible:

* VAR_2
* VAR_3
* VAR_4
