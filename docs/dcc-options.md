---
layout: article
title: DC Options
description: Options in Data Controller are set in the MPE_CONFIG table and apply to all users.
og_title: Data Controller for SAS® Options
og_image: /img/mpe_config.png
---
# Data Controller for SAS® - Options

The [MPE_CONFIG](/tables/mpe_config/) table provides a number of system options, which apply to all users.  The table may be re-purposed for other applications, so long as scopes beginning with "DC_" are avoided.

Currently used scopes include:

* DC
* DC_CATALOG

## DC Scope

### DC_EMAIL_ALERTS
Set to YES or NO to enable email alerts. This requires email options to be preconfigured (mail server etc).

### DC_MAXOBS_WEBEDIT
By default, a maximum of 100 observations can be edited in the browser at one time.  This number can be increased, but note that the following factors will impact performance:

* Number of configured [Validations](/dcc-validations)
* Browser type and version (works best in Chrome)
* Number (and size) of columns
* Speed of client machine (laptop/desktop)

### DC_RESTRICT_EDITRECORD
Setting YES will prevent the EDIT RECORD dialog appearing in the EDIT screen by removing the "Edit Row" option in the right click menu, and the "ADD RECORD" button in the bottom left.  

Anything other than YES will mean that the modal _is_ available.

Default=NO 

### DC_RESTRICT_VIEWER
Set to YES to restrict the list of libraries and tables in VIEWER to only those explicitly set to VIEW in the MPE_SECURITY table.  The default is NO (users can see all tables they already have permission to see).

### DC_VIEWLIB_CHECK
Set to YES to enable library validity checking in viewLibs service. This means that on first load, SAS will attempt to open each library to see if it is possible to do so.  This reduces the number of libraries in the list, but means that it is slow to load the first time around.

The default is NO.

### DC_LOCALE
Set to a locale (such as `en_gb` or `en_be`) to override the system value (which may be derived from client browser settings).
This feature is useful when importing ambiguous dates from CSV or Excel (eg 1/2/20 vs 2/1/20) as DC uses the `anydtdtm.` informats for import.

Default=SYSTEM.

!!! note
    If you have clients in different geographies loading excel in local formats, you can also address this issue by ensuring the locale of the windows _user_ profile is not set to the default (eg `English (United States)`).  When leaving the DC_LOCALE as SYSTEM, the locale settings in SAS are not added or modified.
    
## DC_CATALOG Scope

### DC_IGNORELIBS

When running the [Refresh Data Catalog](/admin-services/#refresh-data-catalog) service, it is often that case the the process will fail due to being unable to assign a library.  To avoid the need to resolve the connection issue elsewhere in SAS, you can simply exclude it from the Data Catalog, by including the LIBREF in this field (pipe-separated)

## DC_REVIEW Scope

### HISTORY_ROWS

Number of rows to return for each HISTORY page.  Default - 100.  Increasing this will increase for all users.  Using very large numbers here can result in a sluggish page load time.  If you need large amounts of HISTORY data, it is generally better to extract it directly from the [MPE_REVIEW](/tables/mpe_review/) table.


