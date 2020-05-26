# Data Controller for SAS® - Stored Process Server

## Overview
Data Controller requires that the operating system account (eg sassrv) has the ability to WRITE to each of the libraries set up for editing.  For SAS installations where business users have the unrestricted ability to create Stored Processes in production, this can represent a security risk.

Under these circumstances, it is recommended to create a dedicated STP server instance for Data Controller, with a dedicated system account.

!!! note
    Data Controller only updates data (add, delete, modify records).  It does not need the ability to create new (permanent) tables, or modify the structure of existing tables.

## Set up DC account

It is recommended to have a user for each environment in which DC is deployed, eg:

* dcsrv_dev
* dcsrv_test
* dcsrv_prod

After these OS users are created, log into SMC in relevant environment and open User Manager.  Adjust as follows:

* Open SAS General Servers group
* Select Accounts tab
* Add the dcsrv_[ENV] user in DefaultAuth domain

## STP Server Configuration - 9.4

Open the SAS Deployment Wizard and deploy a new Application Context Server from the panel windows. 
Be sure to use the relevant dcsrv_[env] user as configured above.

Now head to the [security](#security) section.


## STP Server Configuration - 9.3

As the wizard does not exist in 9.3 it is necessary to copy the folder structure.

### Clone existing directory

Navigate to the SASApp directory on relevant machine (eg `!SASCONFIG/Lev1/SASApp`) and make a copy of the StoredProcessServer folder, and rename it (eg DataControllerSTPsvr).

Modify the contents of the new folder as follows:

* Autoexec (and usermods) – adjust content to ensure it is relevant to a DC context
* sasv9_usermods.cfg – suggested items:

```
 - memsize 0
 - UTILLOC “/change/only/if/needed” 
 - logconfigloc "location of DataControllerSTPsvr logconfig.xml file (in new folder)"
```

The following files should have all instances of “\StoredProcessServer\” replaced
with “\DataControllerSTPsvr\”:

* Logconfig.xml
* Logconfig.trace.xml
* StoredProcessServer.bat
* Logconfig.apm.xml
* Sasv9.cfg
* Dtest folder – we don’t believe this is used but make the changes anyway (same as
above, change all files within it to swap “storedprocessserver” for
DataControllerSTPsvr
* Sasuser folder – EMPTY CONTENTS (remove all files). They aren’t relevant in the
data controller context.


### Add Server

Open ServerManager and adjust as follows:

* Log into SMC in relevant environment
* Open ServerManager
* Right click / new server
* Select Application Server
* Name as “SAS_App_DataController”
* Click Next / select “Stored Process Server” / Next
* Select “Custom” / Next
* Command = `“C:\SAS92\Config\Lev1\SASApp\SASDataEditorStoredProcessServer\StoredProcessServe
r.bat”` (adjust as appropriate)
* Object server parameters = empty
* Multiuser - select dcsrv_[Env]
* Choose SASApp server machine (put in RH box)
* Next / Bridge Connection(default) / Next
* Bridge Port: 8602
* Add / Single Port / 8612
* Add / Single Port / 8622
* Add / Single Port / 8632
* Add at least NINE connections, up to a maximum of (5 per CPU core).
* Next / finish

Next, refresh Server Manager to see the new SAS_App_DataController server. Expand and adjust as follows:

* Right click SAS_App_DataController-Logical server (first nest), properties, Load Balancing tab, select “Response Time”

 - Availability timeout – 10 seconds
 -  Ok / exit

* Right click SAS_App_DataController – Stored Process (second nest), properties, options
tab, Advanced options, Load Balancing

- Max clients 1
- Launch timeout – 10 seconds
- Recycle activation limit – 1

* Right click Object Spawner (inside Server Manager) / Properties / Servers, and add the new
Data Controller STP from “Available Servers” to “Selected Servers”
* Bounce the object spawner

#### VALIDATION (windows)

* Open command prompt as an administrator, and run : `netstat –aon | find /I “8602”` (this will check if the new server is listening on the relevant port)
* Execute the .bat file to ensure a base sas session can be created in the relevant context (`“!SASConfig\Lev1\SASApp\SASDataEditorStoredProcessServer\StoredProcessServer.bat”`)
* In SMC (server manager), right click / validate the new server & test the connection



## Security

### STP Server Context
To protect the new STP server context, the following initialisation code must be added.

This code contains:

```
data _null_;
  if !('/APPROVED/DC/FOLDER/LOCATION'=:symget('_program')) then do;
    file _webout;
    put 'Access to this location has not been approved';
    put 'This incident may be reported';
    abort cancel;
  end;
run;
```

Save this program in the `DataControllerSTPsvr` folder.  Then open Server Manager in SMC and expand SAS_App_DataController server. Right click SAS_App_DataController-Logical server (first nest), properties, Options tab,Set Server Properties, Request.

The `init program` value should be set to the location of the program above.
