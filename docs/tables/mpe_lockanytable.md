---
layout: article
title: MPE_LOCKANYTABLE
description: The MPE_LOCKANYTABLE table provides a mechanism for a process to secure a logical 'lock' on an object to avoid conflicts when running the application with multiple users in parallel
og_image:  https://docs.datacontroller.io/img/mpe_lockanytable.png
---

# MPE_LOCKANYTABLE

The `MPE_LOCKANYTABLE` table provides a mechanism for a process to secure a logical 'lock' on an object to avoid conflicts when running the application with multiple users in parallel. 

The underlying utility is open source and documented [here](https://core.sasjs.io/mp__lockanytable_8sas.html).

For more information, see the [locking mechanism guide](https://docs.datacontroller.io/locking-mechanism).

![locking](/img/mpe_lockanytable.png)

## Columns

 - 🔑 `LOCK_LIB char(8)`: SAS Libref (8 chars)
 - 🔑 `LOCK_DS char(32)`: The dataset name
 - `LOCK_STATUS_CD char(10)`: Either LOCKED or UNLOCKED
 - `LOCK_USER_NM char(100)`: The logged-in user who performed the lock or unlock
 - `LOCK_REF char(200)`: Description of the lock purpose
 - `LOCK_PID char(10)`: The value of the automatic `sysjobid` macro variable 
 - `LOCK_START_DTTM num`: The timestamp when the record was LOCKED
 - `LOCK_END_DTTM num`: The timestamp when the record was UNLOCKED. This is set to missing whilst the record is locked.

