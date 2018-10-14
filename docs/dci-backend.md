#Data Controller for SAS® - Backend Deployment

## Overview
The backend for Data Controller consists of a set of Stored Processes, a macro library, and a database.  The database can be SAS Base library if desired, however this can cause contention (eg table locks) if end users are able to connect to the datasets directly, eg via Enterprise Guide or Base SAS.

## Details

1 - Import datacontroller.spk using SAS Management Console.  The location in which this is deployed should be added to the `metadataRoot` value in the `h54s.config` file as per [frontend](dci-frontend.md#details) deployment.

2 - Create a physical staging directory.  This will contain the data submitted by editors and awaiting approval.  The Stored Process system account (eg `sassrv`) will need write access to this location.

3 - Register a library in metadata for the control database.  The libref should be `DATACTRL`.  If this is not possible, then an alternative libref can be used, simply specify it in the configuration component.

4 - Update the configuration component (imported in the SPK) with the following attributes:

* `dc_staging_area` - location of staging directory as per step 2
* `dc_libref` - if you were unable to use the `DATACTRL` libref in step 3, then use the updated libref here
* `dc_admin_group` - enter the name of a metadata group (eg SASAdministrators) that should be given unrestricted access to the tool

7 - Deploy the data model.  For this, simply compile and run the `mpe_build()` macro.


The next step is to deploy the [frontend](dci-frontend.md).
