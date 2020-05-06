# Data Controller for SAS: Data Catalog
Data Controller collects information about the size and shape of the tables and columns.  The Catalog does not contain information about the data content (values).  

The catalog is based primarily on the existing SAS dictionary tables, augmented with attributes such as primary key fields, filesize / libsize, and number of observations (eg for database tables).

Frequently changing data (such as nobs, size) are stored on the MPE_DATASTATUS_XXX tables.  The rest is stored on the MPE_DATACATALOG_XXX tables.

## Tables

### Libraries

This table contains library level attributes to provide a high level overview of data coverage.  Note that unless you are an administrator, you are unlikely to have the ability to view / open all of these libraries.  To avoid errors when opening invalid libraries, you can add pipe-separated LIBREFs to the DCXXXX.MPE_CONFIG table (var_scope='DC_CATALOG', var_name='DC_IGNORELIBS').


### Tables

Table attributes are split between those that change infrequently (eg PK_FIELDS) and those that change often (eg size, modified date, and NOBS).

### Variables

Variable attributes come from dictionary tables with an extra PK indicator.  A PK is identified by the fact the variable is within an index that is both UNIQUE and NOTNULL.  Variable names are always uppercase.

## Assumptions

The following assumptions are made:

* Data _Models_ (eg attributes) are not sensitive.  If so the catalog tables should be disabled.
* Users can see all tables in the libraries they can access.  The refresh process will close out any tables that are not found, if the user can see at least one table in a library.
* For a particular site, libraries are unique on LIBREF.  

If you have duplicate librefs, specific table security setups, or sensitive models - contact us.


