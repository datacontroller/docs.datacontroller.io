---
layout: article
title: MPE_DATASTATUS_TABS
description: The MPE_DATASTATUS_TABS table captures frequently changing SAS table attributes such as size (if filesystem based), modification date, and the number of observations.
---

# MPE_DATASTATUS_TABS

The `MPE_DATASTATUS_TABS` table captures frequently changing SAS table attributes such as size (if filesystem based), modification date, and the number of observations.

To trigger a scan, see the instructions [here](https://docs.datacontroller.io/admin-services/#refresh-data-catalog)

## Columns

 - `TX_FROM num`: SCD2 open datetime 
 - 🔑 `TX_TO num`: SCD2 close datetime
 - 🔑 `LIBREF char(8)`: SAS Libref (8 chars)
 - 🔑 `DSN char(64)`: The library member name
 - `FILESIZE num`: The size of the table (in bytes), displayed with the SIZEKMG. format.  Only applicable to BASE engine libraries.
 - `CRDATE num`: Creation date of the table
 - `MODATE num`: Modification date of the table
 - `NOBS num`: Number of Observations.  Note - if the table is a SAS dataset then this _includes_ deleted rows.  To remove deleted rows from a SAS dataset, it must be re-created.


