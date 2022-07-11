---
layout: article
title: MPE_COLUMN_LEVEL_SECURITY
description: The MPE_COLUMN_LEVEL_SECURITY table is used to configure which groups can VIEW or EDIT particular columns within a table
---

# MPE_COLUMN_LEVEL_SECURITY

The MPE_COLUMN_LEVEL_SECURITY table is used to configure which groups can VIEW or EDIT particular columns within a table.  More details are available in the [user guide](/column-level-security.md)

## Columns

 - `TX_FROM num`: SCD2 open datetime
 - 🔑 `TX_TO num`: SCD2 close datetime
 - 🔑 `CLS_SCOPE char(4)`: Either VIEW, EDIT or ALL
 - 🔑 `CLS_GROUP char(64)`: The group to which the rule applies
 - 🔑 `CLS_LIBREF char(8)`: The libref to which the rule applies
 - 🔑 `CLS_TABLE char(32)`: The table to which the rule applies
 - 🔑 `CLS_VARIABLE_NM char(32)`: The variable to VIEW or EDIT
 - `CLS_ACTIVE num`: Whether the rule is active or not
 - `CLS_HIDE num`: Whether the column should be hidden in EDIT mode
