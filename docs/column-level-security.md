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
Determines whether the rule applies to the VIEW page, the EDIT page, or ALL pages.  

- When applied to VIEW, then only allowed columns are _visible_
- When applied to EDIT, then only allowed columns are _editable_ (the remaining columns are read-only, and visible).  Also, when CLS is applied in EDIT mode, the user will not be able to ADD or DELETE records.

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
This is the name of the variable against which the security rule will be applied

### CLS_ACTIVE
If you would like this rule to be applied, be sure this value is set to 1.


## Example Config
Example values as follows:

|CLS_SCOPE:$4|CLS_GROUP:$64|CLS_LIBREF:$8| CLS_TABLE:$32|CLS_VARIABLE_NM:$32|CLS_ACTIVE:8.|
|---|---|---|---|---|---|
|EDIT|Group 1|MYLIB|MYDS|VAR_1|1|
|ALL|Group 1|MYLIB|MYDS|VAR_2|1|
|ALL|Group 2|MYLIB|MYDS|VAR_3|1|
|VIEW|Group 1|MYLIB|MYDS|VAR_4|1|


If a user is in Group 1, and viewing `MYLIB.MYDS` in EDIT mode, **all** columns will be visible but only the following columns will be editable:

* VAR_1
* VAR_2

The user will be unable to add or delete rows.

If the user is in both Group 1 AND Group 2, viewing `MYLIB.MYDS` in VIEW mode, **only** the following columns will be visible:

* VAR_2
* VAR_3
* VAR_4
