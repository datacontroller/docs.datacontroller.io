---
layout: article
title: Admin Services
description: Data Controller contains a number of admin-only web services, such as DB Export, Lineage Generation, and Data Catalog refresh.
---

# Admin Services

Several web services have been defined to provide additional functionality outside of the user interface.  These somewhat-hidden services must be called directly, using a web browser.  The URL is made up of several components:

* `SERVERURL` -> the domain (and port) on which your SAS server resides
* `EXECUTOR` -> Either `SASStoredProcess` for SAS 9, else `SASJobExecution` for Viya
* `APPLOC` -> The root folder location in which the Data Controller backend services were deployed
* `SERVICE` -> The actual Data Controller service being described.  May include additional parameters.

To illustrate the above, consider the following URL:

[https://sas.analytium.co.uk/SASJobExecution/?_program=/Public/app/viya/services/admin/exportdb&flavour=PGSQL](https://sas.analytium.co.uk/SASJobExecution/?_program=/Public/app/viya/services/admin/exportdb&flavour=PGSQL
)

This is broken down into:

* `$SERVERURL` = `https://sas.analytium.co.uk`
* `$EXECUTOR` = `SASJobExecution`
* `$APPLOC` = `/Public/app/dc`
* `$SERVICE` = `services/admin/exportdb&flavour=PGSQL`

The below sections will only describe the `$SERVICE` component - you may construct this into a URL as follows:

* `$SERVERURL/$EXECUTOR?_program=$APPLOC/$SERVICE`

## Export Config

This service will provide a zip file containing the current database configuration. This is useful for migrating to a different data controller database instance.

EXAMPLE:

* `services/admin/exportconfig`

## Export Database
Exports the data controller control library in DB specific DDL.  The following URL parameters may be added:

* `&flavour=` (only PGSQL supported at this time)
* `&schema=` (optional, if target schema is needed)

EXAMPLES:

* `services/admin/exportdb&flavour=PGSQL&schema=DC`
* `services/admin/exportdb&flavour=PGSQL`

## Refresh Catalog
Refreshes the Data Controller data catalog.  The model is stored in SCD2 so it's a great way to track changes over time!  The process can take a long time if you have a lot of tables - if a library crashes, you can exclude it from the refresh process by adding pipe-separated LIBREFs to the DCXXXX.MPE_CONFIG table (var_scope='DC_CATALOG', var_name='DC_IGNORELIBS').

The following params can be added:

* `&libref` (optional) to run the process for just one library.

EXAMPLES:

* `services/admin/refreshcatalog`
* `services/admin/refreshcatalog&libref=MYLIB`