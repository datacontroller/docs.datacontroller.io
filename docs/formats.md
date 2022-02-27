---
layout: article
title: API
description: Viewing and Modifying SAS Formats in Data Controller
---

# Formats

SAS Formats are stored in Catalogs, and are used for in-memory lookup operations.  Some formats are available by default, others (custom formats) are maintained seperately.

Using Data Controller to manage formats avoids the need to maintain 'CNTLIN' datasets seperately to the main catalog.

Formats are displayed with a special icon (`bolt`), in the same library as other tables (in both the VIEW and EDIT screens):

![formats](https://i.imgur.com/rnQOLlv.png)

Viewing or editing a format catalog will always mean that the entire catalog is exported, before being filtered (if filters applied) and displayed.  For this reason, it is recommended to split a large format catalog over several catalogs, if performance is a consideration.

The usual export mechanisms can also be applied - you can downlad the DDL, or export the catalog in CSV / Excel / Datalines formats.

When adding a format to MPE_TABLES, the `DSN` should contain the format catalog name plus a `-FC` extension.  The LOADTYPE should be `FORMAT_CAT` and the BUSKEY should be `FMTNAME START`.  HOOK scripts can also be applied (run some DQ after an edit, or re-run a batch job after an approval).

Just like regular table edits, all changes may also be logged in the `MPE_AUDIT` table.