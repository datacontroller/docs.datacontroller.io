---
layout: article
title: MPE_AUDIT
description: The MPE_AUDIT table enables full change capture of data in SAS.  It contains all deletes, modifications and additions by all users.
---

# MPE_AUDIT

The MPE_AUDIT table contains all deletions, modifications and additions to data in Data Controller (or using the underlying [macros](/macros)).

The underlying utility is open source and documented [here](https://core.sasjs.io/mp__storediffs_8sas.html).

## Columns

 - LOAD_REF (PK).  This is supplied to the `bitemporal_dataloader()` macro at backend, and corresponds to the unique folder in which the staged data resides.
 - LIBREF (PK). The target libref.
 - DSN (PK). The target table name.
 - KEY_HASH (PK). This is a pipe seperated `md5()` hash of the primary key values - it uniquely identifies a single record.
 - TGTVAR_NM (PK). Target variable name (32 chars)
 - PROCESSED_DTTM.  The timestamp at which the record was processed.
 - MOVE_TYPE. Either (A)ppended, (D)eleted or (M)odified
 - IS_PK. Set to 1 if the variable is part of the primary key.
 - IS_DIFF. For modified records, is 1 for a change and 0 for no change. Set to -1 for appends / deletes. 
 - TGTVAR_TYPE. Either (C)haracter or (N)umeric
 - OLDVAL_NUM. Old (numeric) value
 - NEWVAL_NUM. New (numeric) value
 - OLDVAL_CHAR. Old (character) value
 - NEWVAL_CHAR. New (character) value

