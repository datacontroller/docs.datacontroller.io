---
layout: article
title: MPE_DATACATALOG_TABS
description: The MPE_DATACATALOG_TABS table catalogs attributes such as number of variables, compression status, and primary key fields.
---

# MPE_DATACATALOG_TABS

The `MPE_DATACATALOG_TABS` table catalogs attributes such as number of variables, compression status, and primary key fields.

More frequently changing attributes (such as size modification date and number of observations) are stored in [MPE_DATASTATUS_TABS](/mpe_datastatus_tabs).

To trigger a scan, see the Refresh Data Catalog [instructions](https://docs.datacontroller.io/admin-services/#refresh-data-catalog).

## Columns

 - `TX_FROM num`: SCD2 open datetime 
 - 🔑 `TX_TO num`: SCD2 close datetime
 - 🔑 `LIBREF char(8)`: SAS Libref (8 chars)
 - 🔑 `DSN char(64)`: The library member name
 - `MEMTYPE char(8)`: The member type
 - `DBMS_MEMTYPE char(32)`: The DBMS Member Type
 - `MEMLABEL char(512)`: The Data Set Label
 - `TYPEMEM char(8)`: The Data Set Type
 - `NVAR num`: The number of variables
 - `COMPRESS char(8)`: The compression routine
 - `PK_FIELDS char(512)`: The list of primary key fields.  These are deduced from the table constraints.  A Primary key column is identified by being in a constraint (or index) that is both UNIQUE and NOT NULL.

