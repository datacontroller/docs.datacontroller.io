---
layout: article
title:
og_title: Data Controller Macro Library
description: Data Controller comes with a battle tested macro library supporting multiple load types and target databases.
og_image: https://i.imgur.com/8iuEDQ9.png
---

Data Controller Macros
====================

"Under the hood" of Data Controller, SAS Macros are used for dynamic loading of all kinds of data thanks to the SAS ACCESS engines, including (but not limited to):

* Base (v9)
* SPDE
* CAS
* TERADATA
* POSTGRES
* NETEZZA
* ORACLE

Native pass through is also available for optimised data loads in the following engines:

* Microsoft SQL SERVER
* Amazon REDSHIFT

The macros work dynamically, taking data types / lengths etc from the table metadata at runtime.  Data Controller macros are available for unlimited (internal) use by licenced customers.  They are currently in use, in production, in dozens of SAS environments globally and have been battle tested on large data volumes as well as some more esoteric gotchas such as:

* Short numerics
* WLATIN1 vs UTF-8
* High numerical precision
* Long strings
* High column volume
* New data types in CAS (Type 6 as well as 1 & 2)

Multiple load types are supported (full REPLACE, regular UPDATE, SCD2 loads, even BITEMPORAL).  Composite keys are of course possible, so are retained keys (and the max key value can be table or data driven).  Keys are taken from the staging table, so they could be based on an md5 hash, a UUID, or whatever you choose.  It just needs to fit within the constraints of a SAS data step (so, max 32767 width for a character variable, 8 bytes numerical precision).

A column (eg PROCESSED_DTTM) may be nominated to retain the current timestamp when doing any type of upload.

There is also a locking mechanism to avoid conflict where multiple users (or jobs) are trying to load the same table at the same time.  If the loader cannot get a lock, it will keep trying for a configurable amount of time, until it does.

In the process of data discovery and comparing the hashes of the data values there are checks at every step of the way - the macro will abort if there are any WARNINGs or ERRORs or anything else awry.  Some of these checks may be turned off for performance (eg the check for uniqueness of the business key in the staging table).

All dataloads are tracked in an output table, which shows the the number of observations added / modified / deleted, as well as the user identity performing the load, the timestamp, the library / table being loaded, and a descriptive (user provided) message for the load.

![DC Loader results](https://i.imgur.com/2GFPxPF.png)

The macros are fully documented with Doxygen, similar to the SASjs [Macro Core Library](https://core.sasjs.io).

The minimum amount of information needed to load a table is:

* Staging Library (default WORK)
* Staging Table
* Base Library
* Base Table
* Business Key fields
* Load Type

An invocation of the loader macro might look something like this:

![SAS Loader](https://i.imgur.com/Hzca1WG.png)

A single (one year) subscription to data controller provides perpetual usage of the macros.  Contact [Allan Bowe](https://www.linkedin.com/in/allanbowe) for pricing details.








