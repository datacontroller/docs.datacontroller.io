# Data Controller for SAS® - Options

## Overview
The MPE_CONFIG table provides a number of options, to apply to all users:

## DC_EMAIL_ALERTS
Set to YES or NO to enable email alerts. This requires email options to be preconfigured (mail server etc).

## DC_MAXOBS_WEBEDIT
By default, a maximum of 500 observations can be edited in the browser at one time.  If you are using a modern browser (Chrome, Firefox) and decent client machines, and your tables have a reasonable number of columns (<50) this number can be safely increased.

## DC_RESTRICT_VIEWER
Set to YES to restrict the list of libraries and tables in VIEWER to only those explicitly set to VIEW in the MPE_SECURITY table.  The default is NO (users can see all tables they already have permission to see).

## DC_VIEWLIB_CHECK
Set to YES to enable library validity checking in viewLibs service. This means that on first load, SAS will attempt to open each library to see if it is possible to do so.  This reduces the number of libraries in the list, but means that it is slow to load the first time around.

The default is NO.