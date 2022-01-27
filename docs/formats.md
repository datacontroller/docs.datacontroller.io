---
layout: article
title: API
description: Viewing and Modifying SAS Formats in Data Controller
---

!!! warning
    Work in Progress!

# Formats

SAS Formats are stored in Catalogs, and are used for in-memory lookup operations.  Some formats are available by default, others (custom formats) are maintained seperately.

Using Data Controller to manage formats means that it will no longer be necessary to maintain 'CNTLIN' datasets seperately to the main catalog.

Formats will be presented with a new icon (`bolt`), in the same library as other tables (in both the VIEW and EDIT screens):

![formats](https://i.imgur.com/rnQOLlv.png)

Viewing a format catalog will always mean that the entire catalog is exported and displayed.

Filters will be applied after the export.  DDL / excel exports will apply to the export.

The MPE_TABLES for formats will need to be configured with a new LOADTYPE (FMTCATALOG) and specific CLOSE_VARS and BUSKEY values.

Edits to formats will follow the regular approval process, with changes logged in MPE_AUDIT.