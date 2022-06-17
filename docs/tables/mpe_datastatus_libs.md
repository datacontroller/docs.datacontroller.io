---
layout: article
title: MPE_DATASTATUS_LIBS
description: The MPE_DATASTATUS_LIBS table captures frequently changing SAS library attributes such as size (if filesystem based) and the number of tables.
---

# MPE_DATASTATUS_LIBS

The `MPE_DATASTATUS_LIBS` table captures frequently changing SAS library attributes such as size (if filesystem based) and the number of tables.

To trigger a scan, see the Refresh Data Catalog [instructions](https://docs.datacontroller.io/admin-services/#refresh-data-catalog).

## Columns

 - `TX_FROM num`: SCD2 open datetime 
 - 🔑 `TX_TO num`: SCD2 close datetime
 - 🔑 `LIBREF char(8)`: SAS Libref (8 chars)
 - `LIBSIZE num`: The size of the library (in bytes), displayed with the SIZEKMG. format.  Only applicable to BASE engine libraries.
 - `TABLE_CNT num`: The number of tables in the library.

