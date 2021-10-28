# Data Controller for SAS® - Options

## Overview
The MPE_CONFIG table provides a number of options, to apply to all users:

## DC_EMAIL_ALERTS
Set to YES or NO to enable email alerts. This requires email options to be preconfigured (mail server etc).

## DC_MAXOBS_WEBEDIT
By default, a maximum of 100 observations can be edited in the browser at one time.  This number can be increased, but note that the following factors will impact performance:

* Number of configured [Validations](/dcc-validations)
* Browser type and version (works best in Chrome)
* Number (and size) of columns
* Speed of client machine (laptop/desktop)

## DC_RESTRICT_VIEWER
Set to YES to restrict the list of libraries and tables in VIEWER to only those explicitly set to VIEW in the MPE_SECURITY table.  The default is NO (users can see all tables they already have permission to see).

## DC_VIEWLIB_CHECK
Set to YES to enable library validity checking in viewLibs service. This means that on first load, SAS will attempt to open each library to see if it is possible to do so.  This reduces the number of libraries in the list, but means that it is slow to load the first time around.

The default is NO.

## DC_LOCALE
Set to a locale (such as `en_gb` or `en_be`) to override the system value (which may be derived from client browser settings).
This feature is useful when importing ambiguous dates from CSV or Excel (eg 1/2/20 vs 2/1/20) as DC uses the `anydtdtm.` informats for import.

Default=SYSTEM.

!!! note
    If you have clients in different geographies loading excel in local formats, you can also address this issue by ensuring the locale of the windows _user_ profile is not set to the default (eg `English (United States)`).  When leaving the DC_LOCALE as SYSTEM, the locale settings in SAS are not added or modified.