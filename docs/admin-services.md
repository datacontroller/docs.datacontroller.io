---
layout: article
title: Admin Services
description: Data Controller contains a number of admin-only web services, such as DB Export, Lineage Generation, and Data Catalog refresh.
---

# Admin Services

Several web services have been defined to provide additional functionality outside of the user interface.  These somewhat-hidden services must be called directly, using a web browser.  

In a future version, these features will be made available from an Admin screen (so, no need to manually modify URLs).

The URL is made up of several components:

* `SERVERURL` -> the domain (and port) on which your SAS server resides
* `EXECUTOR` -> Either `SASStoredProcess` for SAS 9, else `SASJobExecution` for Viya
* `APPLOC` -> The root folder location in which the Data Controller backend services were deployed
* `SERVICE` -> The actual Data Controller service being described.  May include additional parameters.

To illustrate the above, consider the following URL:

[https://viya.4gl.io/SASJobExecution/?_program=/Public/app/viya/services/admin/exportdb&flavour=PGSQL](https://viya.4gl.io/SASJobExecution/?_program=/Public/app/viya/services/admin/exportdb&flavour=PGSQL
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

## Refresh Data Catalog

In any SAS estate, it's unlikely the size & shape of data will remain static.  By running a regular Catalog Scan, you can track changes such as:

 - Library Properties (size, schema, path, number of tables)
 - Table Properties (size, number of columns, primary keys)
 - Variable Properties (presence in a primary key, constraints, position in the dataset)

The data is stored with SCD2 so you can actually **track changes to your model over time**! Curious when that new column appeared?  Just check the history in [MPE_DATACATALOG_TABS](/tables/mpe_datacatalog_tabs).

To run the refresh process, just trigger the stored process, eg below:

* `services/admin/refreshcatalog`
* `services/admin/refreshcatalog&libref=MYLIB`

The optional `&libref=` parameter allows you to run the process for a single library.  Just provide the libref.

When doing a full scan, the following LIBREFS are ignored:

* 'CASUSER'
* 'MAPSGFK'
* 'SASUSER'
* 'SASWORK
* 'STPSAMP'
* 'TEMP'
* `WORK'

Additional LIBREFs can be excluded by adding them to the `DCXXXX.MPE_CONFIG` table (where `var_scope='DC_CATALOG' and var_name='DC_IGNORELIBS'`). Use a pipe (`|`) symbol to seperate them.  This can be useful where there are connection issues for a particular library.

Be aware that the scan process can take a long time if you have a lot of tables!  

Output tables (all SCD2):

* [MPE_DATACATALOG_LIBS](/tables/mpe_datacatalog_libs) - Library attributes
* [MPE_DATACATALOG_TABS](/tables/mpe_datacatalog_tabs) - Table attributes
* [MPE_DATACATALOG_VARS](/tables/mpe_datacatalog_vars) - Column attributes
* [MPE_DATASTATUS_LIBS](/tables/mpe_datastatus_libs) - Frequently changing library attributes (such as size & number of tables)
* [MPE_DATASTATUS_TABS](/tables/mpe_datastatus_tabs) - Frequently changing table attributes (such as size & number of rows)

## Update Licence Key

Whenever navigating Data Controller, there is always a hash (`#`) in the URL.  To access the licence key screen, remove all content to the RIGHT of the hash and add the following string: `/licensing/update`.

If you are using https protocol, you will have 2 keys (licence key / activation key).  In http mode, there is just one key (licence key) for both boxes.
