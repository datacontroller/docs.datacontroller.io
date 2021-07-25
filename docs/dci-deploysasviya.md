---
layout: article
title: DC SAS Viya Deployment
description: How to deploy Data Controller in a production SAS Viya environment
og_image: https://docs.datacontroller.io/img/dci_deploymentdiagramviya.png
---

# SAS Viya Deployment

## Overview
Data Controller for SAS Viya consists of a frontend, a set of Job Execution Services, a staging area, a Compute Context, and a database library.  The library can be a SAS Base engine if desired, however this can cause contention (eg table locks) if end users are able to connect to the datasets directly, eg via Enterprise Guide or Base SAS.
A database that supports concurrent access is highly recommended.

## Prerequisites

### System Account

Data Controller makes use of a system account for performing backend data updates and writing to the staging area.  This needs to be provisioned in advance using the Viya admin-cli.  The process is well described here:  [https://communities.sas.com/t5/SAS-Communities-Library/SAS-Viya-3-5-Compute-Server-Service-Accounts/ta-p/620992](https://communities.sas.com/t5/SAS-Communities-Library/SAS-Viya-3-5-Compute-Server-Service-Accounts/ta-p/620992)

### Database
Whilst we do recommend that Data Controller configuration tables are stored in a database for concurrency reasons, it is also possible to use a BASE engine library, which is adequate if you only have a few users.

Let us know which database you are using and we will provide the DDL. We have customers in production using Oracle, Postgres, Netezza, SQL Server to name a few.

Simply run the provided DDL script to create the tables and initial configuration data in your chosen database.  Make sure the system account (see prerequisites) has full read / write access.

!!! note
    "Modify schema" privileges are not required.

### Staging Directory
All deployments of Data Controller make use of a physical staging directory.  This is used to store logs, as well as CSV and Excel files uploaded by end users.  This directory should NOT be accessible by end users - only the SAS system account requires access to this directory.
A typical small deployment will grow by a 5-10 mb each month.  A very large enterprise customer, with 100 or more editors, might generate up to 0.5 GB or so per month, depending on the size and frequency of the Excel EUCs and CSVs being uploaded.  Web modifications are restricted only to modified rows, so are typically just a few kb in size.

## Deployment Diagram

The below areas of the SAS Viya platform are modified when deploying Data Controller:

<img src="img/dci_deploymentdiagramviya.svg" height="350" style="border:3px solid black" >


## Deployment
Data Controller deployment is split between 3 deployment types:

* Demo version
* Full Version (manual deploy)
* Full Version (automated deploy)

<!--
## Full Version - Manual Deploy
-->

There are three main parts to this proces:

1.  Create the Compute Context
2.  Deploy Frontend
2.  Deploy Backend
3.  Update the Compute Context autoexec

### Create Compute Context

The Viya Compute context is used to spawn the Job Execution Services - such that those services may run under the specified system account, with a particular autoexec.

We strongly recommend a dedicated compute context for running Data Controller.  The setup requires an Administrator account.

* Log onto SASEnvironment Manager, select Contexts, View Compute Contexts, and click the Create icon.
* In the New Compute Context dialog, enter the following attributes:
    * Context Name
    * Launcher Context
    * Attribute pairs:
        * reuseServerProcesses: true
        * runServerAs: {{the account set up [earlier](#system-account)}}
* Save and exit

!!! note
    XCMD is NOT required to use Data Controller.
### Deploy frontend

Unzip the frontend into your chosen directory (eg `/var/www/html/DataController`) on the SAS Web Server.  Open `index.html` and update the following inside `dcAdapterSettings`:

- `appLoc` - this should point to the root folder on SAS Drive where you would like the Job Execution services to be created.  This folder should initially, NOT exist (if it is found, the backend will not be deployed)
- `contextName` - here you should put the name of the compute context you created in the previous step.
- `dcPath` - the physical location on the filesystem to be used for staged data.  This is only used at deployment time, it can be configured later in `$(appLoc)/services/settings.sas` or in the autoexec if used.
- `adminGroup` - the name of an existing group, which should have unrestricted access to Data Controller.  This is only used at deployment time, it can be configured later in `$(appLoc)/services/settings.sas` or in the autoexec if used.
- `servertype` - should be SASVIYA
- `debug` - can stay as `false` for performance, but could be switched to `true` for debugging startup issues
- `useComputeApi` - use `true` for best performance.

![Updating index.html](img/viyadeployindexhtml.png)

Now, open https://YOURSERVER/DataController (using whichever subfolder you deployed to above) using an account that has the SAS privileges to write to the `appLoc` location.

You will be presented with a deployment screen like the one below.  Be sure to check the "Recreate Database" option and then click the "Deploy" button.

![viya deploy](img/viyadeployauto.png)

Your services are deployed!  And the app is operational, albeit still a little sluggish, as every single request is using the APIs to fetch the content of the `$(appLoc)/services/settings.sas` file.

To improve responsiveness by another 700ms we recommend you take the subsequent step below.
### Update Compute Context Autoexec

First, open the `$(appLoc)/services/settings.sas` file in SAS Studio, and copy the code.

Then, open SASEnvironment Manager, select Contexts, View Compute Contexts, and open the context we created earlier.

Switch to the Advanced tab and paste in the SAS code copied from SAS Studio above.

It will look similar to:

```
%let DC_LIBREF=DCDBVIYA;
%let DC_ADMIN_GROUP={{YOUR DC ADMIN GROUP}};
%let DC_STAGING_AREA={{YOUR DEDICATED FILE SYSTEM DRIVE}};
libname &dc_libref {{YOUR DC DATABASE}};
```

To explain each of these lines:

* `DC_LIBREF` can be any valid 8 character libref.
* `DC_ADMIN_GROUP` is the name of the group which will have unrestricted access to Data Controller
* `DC_STAGING_AREA` should point to the location on the filesystem where the staging files and logs are be stored
* The final libname statement can also be configured to point at a database instead of a BASE engine directory (contact us for DDL)

If you have additional libraries that you would like to use in Data Controller, they should also be defined here.
<!--
## Full Version - Automated Deploy

The automated deploy makes use of the SASjs CLI to create the dependent context and job execution services.  In addition to the standard prerequisites (a registered viya system account and a prepared database) you will also need:

* a local copy of the [SASjs CLI](https://sasjs.io/sasjs-cli/#installation)
* a Client / Secret - with an administrator group in SCOPE, and an authorization_code GRANT_TYPE.  The SASjs [Viya Token Generator](https://github.com/sasjs/viyatoken) may help with this.

### Prepare the Target and Token

To configure this part (one time, manual step), we need to run a single command:
```
sasjs add
```
A sequence of command line prompts will follow for defining the target.  These prompts are described [here](https://sasjs.io/sasjs-cli-add/).  Note that `appLoc` is the SAS Drive location in which the Data Controller jobs will be deployed.

### Prepare the Context JSON
This file describes the context that the CI/CD process will generate.  Save this file, eg as `myContext.json`.

```
{
  "name": "DataControllerContext",
  "attributes": {
    "reuseServerProcesses": true,
    "runServerAs": "mycasaccount"
  },
  "environment": {
    "autoExecLines": [
      "%let DC_LIBREF=DCDBVIYA;",
      "%let DC_ADMIN_GROUP={{YOUR DC ADMIN GROUP}};",
      "%let DC_STAGING_AREA={{YOUR DEDICATED FILE SYSTEM DRIVE}};",
      "libname &dc_libref {{YOUR DC DATABASE}};",
    ],
    "options": []
  },
  "launchContext": {
    "contextName": "SAS Job Execution launcher context"
  },
  "launchType": "service",
}
```

### Prepare Deployment Script

The deployment script will run on a build server (or local desktop) and execute as follows:

```
# Create the SAS Viya Target
sasjs context create --source myContext.json --target myTarget
```
-->