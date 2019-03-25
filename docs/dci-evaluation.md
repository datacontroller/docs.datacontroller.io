# Data Controller for SAS® - Evaluation Version

## Overview
A free version of Data Controller is available for evaluation purposes. Compiled into a single SPK, it is very easy to install and configure.  However it should not be used in production environments for all the reasons mentioned in the [caveats](#caveats) section.

## Deployment

Step 1 is to import the SPK to the desired location in the metadata tree.  During the import, be sure to change the location of the library (BASE engine) to a directory folder which the Stored Process system account (sassrv) has write access to.

Step 2 is to navigate to the [YOURHOST]/SASStoredProcess web application and 'list available stored processes'.  Make sure you use the same user as before, or at least a user that has WRITE METADATA permissions on the imported Data Controller folder.  Find the location where the app was imported, open the Admin subfolder, right click the 'makedata' service and open in a new window.  This service will ensure logs are directed to a subfolder of the library location, and will create the necessary configuration tables in that library.

## Configuration

If your user is not in the 'Administrators' group then you may need to update the settings to give your user the ability to view all tables.  Within the root of the application there is a 'dc_admin_group' property, add an appropriate metadata group here to give full access to the tool.

## Usage

Simply navigate to the imported location, right click on the 'clickme' stored process, and open in new window!


## Caveats

The demo version is optimised for rapid install, however it should not be considered for production / commercial use, or for use by more than 2-5 people, for the following reasons:

1) Static content is compiled into SAS services, placing undue strain on the Load Balancer (not scalable)

2) Direct URLs are not functional

3) Requires BASE engine for config tables, with risk of file locks

4) Not licenced for commercial use, and not supported

5) The embedded HandsOnTable library is not licenced for commerical use without a licence key

Contact Macro People support for a full-featured, fully licenced, scalable and supported deployment of Data Controller at your earliest convenience!