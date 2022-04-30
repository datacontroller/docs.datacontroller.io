---
layout: article
title: MPE_DATACATALOG_LIBS
description: The MPE_DATACATALOG_LIBS table catalogs library attributes such as engine, paths, permissions, owners & schemas
---

# MPE_DATACATALOG_LIBS

The `MPE_DATACATALOG_LIBS` table catalogs library attributes such as engine, paths, permissions, owners & schemas.

More frequently changing attributes (such as size and number of tables) are stored in [MPE_DATASTATUS_LIBS](/mpe_datastatus_libs).

To ignore additional librefs, or to trigger a scan, see the Refresh Data Catalog [instructions](https://docs.datacontroller.io/admin-services/#refresh-data-catalog).

## Columns

 - `TX_FROM num`: SCD2 open datetime 
 - 🔑 `TX_TO num`: SCD2 close datetime
 - 🔑 `LIBREF char(8)`: SAS Libref (8 chars)
 - `ENGINE char(32)`: The engine used to connect to the library
 - `LIBNAME char(256)`: The Library Name (from metadata if SAS 9)
 - `PATHS char(8192)`: The directories used (BASE engine only)
 - `PERMS char(500)`: The directory permissions (BASE engine only)
 - `OWNERS char(500)`: The directory owners (BASE engine only)
 - `SCHEMAS char(500)`: The library schema (DB engines)
 - `LIBID char(17)`: The Library Id (from metadata if SAS 9)



