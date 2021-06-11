---
layout: article
title: DC SAS 9 Deployment
description: How to deploy Data Controller in a production SAS 9 environment
og_image: https://docs.datacontroller.io/img/dci_deploymentdiagram.png
---

# SAS 9 Deployment

## Artefacts

Data Controller for SAS 9 consists of:

* Frontend on the web server
* Stored Processes in metadata
* Staging Area on the filesystem
* Database / SAS library

### Frontend
A full deployment involves copying a directory with static web content onto the web server.  The demo deployment allows that content to be served from Stored Processes, in which case no web server access is needed.  This approach is not recommended for enterprise use however, as it places unnecessary load on the STP server (the web server is much faster for serving static content).

### Stored Processes
In SAS 9, all backend logic is performed with SAS code in Stored Processes.  The code is embedded within the Stored Processes (no need to deploy programs to the file system).  There is no use of X commands, and no requirement for internet access.

### Staging Area
This is a backend directory, on the Application Server, in which the staged data, logs, and copies of any uploaded Excel files, are securely stored.

### Database
The library can be a SAS Base engine if desired (using datasets), however this can cause contention (eg table locks) if end users are able to connect to the datasets directly, eg via Enterprise Guide or Base SAS.
A database that supports concurrent access is recommended.

## Deployment Process
### 1 - Import SPK

Import `/sas/import.spk` using SAS Management Console or DI Studio.  Make a note of the root metadata folder location in which this was imported - as this will be added to the `appLoc` value in the `index.html` file in the [frontend](#3-deploy-the-frontend) deployment later.

When importing the library, provide the physical path in which the Staging Area should be created.  The next step will use this path to create the directory.  Make sure that the SAS Spawned Server account (eg `sassrv`) has WRITE access to this location

### 2 - Run the Configurator

Open the browser and navigate to YOURSASSERVER/SASStoredProcess.  From here, find the Data Controller folder, and open services/admin/configurator.

You will be provided with a list of groups.  Choose the group that you would like to be the admin group.

!!! note
    Anyone in this admin group will have unrestricted access to Data Controller!

After you click submit, the Stored Process will run, configure the staging area and create the library tables (as datasets).

At this point you can already open the app (demo version).

### 3 - Deploy the Frontend
The Data Controller frontend comes pre-built, and ready to deploy to the root of the SAS Web Server (mid-tier), typically `!SASCONFIG/LevX/Web/WebServer/htdocs` in SAS 9.

Deploy as follows:

1 - Unzip `dcfrontend.zip` and upload the entire `datacontroller` directory to the static content server (htdocs folder).

2 - Open the `index.html` file and update the `appLoc` value to the location where the Stored Processes were deployed earlier.

It should now be possible to use the application - simply navigate to `YOURSASWEBLOC:port/yourRoot/datacontroller` and sign in!

### 4 - Configure the Database
If you have a database available, then we recommend you use it for storing the data controller configuration tables.  This part involves migrating the data from the BASE library to your database schema, and updating the library definition in metadata.

Contact us for support with DDL and migration steps for your chosen vendor.

## Deployment Diagram

The below areas of the SAS platform are modified when deploying Data Controller:

<img src="/img/dci_deploymentdiagram.svg" height="350" style="border:3px solid black" >

### Client Device

Nothing needs to be deployed or modified on the client device.  We support a wide range of browsers (the same as SAS).  Browsers make requests to the SAS Web Server, and will cache assets such as JS, CSS and images.  Some items (such as dropdowns) are kept in local storage to improve responsiveness.

### SAS Mid Tier

The front end is deployed to the SAS Web Server as described [above](/dci-deploysas9/#3-deploy-the-frontend).  This requires making a dedicated public folder in the htdocs directory.

### SAS Application Server

Given the enhanced permissions needed of the system account, a dedicated / secured STP instance is recommended as described [here](/dci-stpinstance).

All deployments of Data Controller also make use of a staging directory.  This is used to store CSV and Excel files as uploaded by end users.  This directory should NOT be accessible by end users - only the SAS system account (eg `sassrv`) requires access to this directory.

A typical small deployment will grow by a 10-20 mb each month.  A very large enterprise customer, with 100 or more editors, might generate up to 1 GB or so per month, depending on the size and frequency of the Excel EUCs and CSVs being uploaded.  Web modifications are restricted only to modified rows, so are typically just a few kb in size.

### SAS Metadata Server

The items deployed to metadata include:

 * Folder tree
 * Stored Processes
 * Library Object & tables

 After the installation process (which updates `public/settings` and removes the `admin/makedata` STP), there are no write actions performed against metadata.

### Databases

We strongly recommend that the Data Controller configuration tables are stored in a database for concurrency reasons, however it is also possible to use a BASE engine library.

We provide the DDL for creating the tables, we have customers in production using Oracle, Postgres, Netezza, SQL Server to name a few.

!!! note
    Data Controller does NOT modify schemas! It will not create or drop tables, or add/modify columns or attributes.  Only rows can be modified using the tool.

