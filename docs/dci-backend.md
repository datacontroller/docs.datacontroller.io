#Data Controller for SAS® - Backend Deployment

## Overview
The backend for data controller consists of a set of Stored Processes, a macro library, and a database.  The database can be SAS Base library if desired, however this can cause contention (eg table locks) if end users are able to connect to the datasets directly, eg via Enterprise Guide or Base SAS. 

## Details

1 - Unzip dcbackend.zip and copy the files to a preferred location on the application server (eg SASApp).  This contains the SAS source code and ddl files.

2 - Import datacontroller.spk using SAS Management Console.  The location in which this is deployed should be added to the `metadataRoot` value in the `h54s.config` file as per [frontend](dci-frontend.md#details) deployment.

3 - Create a staging directory.  This will contain the data submitted by editors and awaiting approval.  The Stored Process system account (eg `sassrv`) will need write access to this location. 

4 - Register a library in metadata for your preferred database.  The libref should be `DATACTRL`.  If this is not possible, then an alternative libref can be used, simply specify it in the configuration in step 6.

5 - Make the `mpeinit.sas` macro available.  This "initialisation" macro needs to be available to a fresh Stored Process session.  There are several ways to do this, such as to `%include` from the `/Lev1/StoredProcessServer/StoredProcessServer_usermods.sas` file or to create a symlink from the `sasautos` directory.  

6 - Configure the `mpeinit.sas` file.  This is where all your site specific locations are stored.  The following macro variables should be modified:

* `mperepo` - location of the files uploaded in step 1
* `mpmetaroot` - location where the STPs were deployed in step 2
* `mpelocapprovals` - location of staging directory as per step 3
* `mpelib` - if you were unable to use the `DATACTRL` libref in step 4, then use the updated libref here
* `mpeadmins` - enter the name of a metadata group (eg SASAdministrators) that should be given unrestricted access to the tool

7 - Deploy the data model.  For this, simply run the following code:
```
%mpeinit()
options insert=(sasautos="&mperepo/build");
%mpe_build()
```

The next step is to deploy the [frontend](dci-frontend.md).
