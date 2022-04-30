---
layout: article
title: MPE_DATACATALOG_VARS
description: The MPE_DATACATALOG_VARS table catalogs variable attributes such as primary key status, not null constraints and index usage.
---

# MPE_DATACATALOG_TABS

The `MPE_DATACATALOG_VARS` table catalogs variable attributes such as primary key status, not null constraints and index usage.

To trigger a scan, see the instructions [here](https://docs.datacontroller.io/admin-services/#refresh-data-catalog)

## Columns

 - `TX_FROM num`: SCD2 open datetime 
 - 🔑 `TX_TO num`: SCD2 close datetime
 - 🔑 `LIBREF char(8)`: SAS Libref (8 chars)
 - 🔑 `DSN char(64)`: The library member name
 - 🔑 `NAME char(64)`: The variable name
 - `MEMTYPE char(8)`: The member type
 - `TYPE char(16)`: The column type
 - `LENGTH num`: The column length
 - `VARNUM num`: The column position in the table
 - `LABEL char(256)`: The column label
 - `FORMAT char(49)`: The SAS format associated with the column
 - `IDXUSAGE char(9)`: The column index type
 - `NOTNULL char(3)`: The NOT NULL status
 - `PK_IND num`: A flag to say whether the column is part of the primary key (1=PK, 0=Not PK).  A Primary key column is identified by being in a constraint (or index) that is both UNIQUE and NOT NULL.



