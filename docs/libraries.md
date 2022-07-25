---
layout: article
title: Libraries
description: Libraries in Data Controller are configurable in different ways according to the SAS flavour in use.
og_image: img/libraries.png
---

# Adding Libraries to Data Controller

The process for adding new libraries to Data Controller depends on whether we are talking about:

* The VIEW or EDIT menu
* Which flavour of SAS is being used

In VIEW mode, all available libraries are shown, unless the [DC_RESTRICT_VIEWER](/dcc-options/#dc_restrict_viewer) option is set.

In EDIT mode, only the libraries corresponding to the configuration in [MPE_TABLES](/dcc-tables) are visible.  This list may be shorter if the user is not in the [admin group](/dcc-groups/#data-controller-admin-group) or does not have the necessary [security](/dcc-security/) settings.

![library list](img/libraries.png)

Flavour specific guidance is below.

## Viya Libraries

Library definitions should be added in the `autoexec.sas` of the configured Compute Context using Environment Manager.

## SAS 9 EBI Libraries

Library definitions can be added in the `[DC Meta Path]/services/public/Data_Controller_Settings` stored process, IF required.  In most cases, libname statements are NOT required because they are taken from metadata.

For the VIEW menu, the libname statement is made using the [mm_assignlib](https://core.sasjs.io/mm__assignlib_8sas.html) macro (META engine).  It is important that each library has a unique (up to 8 char) LIBREF.

For the EDIT menu, direct libname statements are derived using the [mm_assigndirectlib](https://core.sasjs.io/mm__assigndirectlib_8sas.html) macro.

## SASjs Server Libraries

New library definitions can be added in the `[DC Drive Path]/services/public/settings.sas` stored program.
