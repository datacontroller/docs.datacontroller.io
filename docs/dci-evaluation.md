# Data Controller for SAS® - Evaluation Version

## Overview
A free version of Data Controller is available for evaluation purposes. Compiled into a single SPK, it is very easy to install and configure.  However it should not be used in production environments for all the reasons mentioned in the [caveats](#caveats) section.

## Installation

### Deployment

Simply import the SPK to the desired location in the metadata tree.  During the import (step 5 of the wizard), be sure to change the location of the library (BASE engine) to a directory folder which the Stored Process system account (sassrv) has write access to.  Also, make sure that your user account has WRITE METADATA (WM) on the imported Data Controller DATA folder, and that anyone who will use the app has READ.

### Configuration

Firstly, if your SAS user acocunt is **not** in the 'SASAdministrators' group then you may need to update the settings to give your user the ability to view all tables.  Using SAS Management Console, open the `makeData` stored process in the Admin folder, and change the DC_ADMIN_GROUP macro variable to a group of your choosing.

!!! warning
    Every member of the group you provide above will have UNRESTRICTED access to the tool!


Navigate to the [YOURHOST]/SASStoredProcess web application and 'list available stored processes'.  Find the location where the app was imported, open the Admin subfolder and run the 'makedata' stored process. This service will ensure logs are directed to a subfolder of the library location, and will create the necessary configuration tables in that library.

!!! note
    A quick way to update the admin group is to simply add `&admin=YOURGROUPNAME` to the url when running the `makeData` stored process.


## Usage

Simply navigate to the imported location from the Stored Process Web App, right click on the 'clickme' stored process, and open in new window!


## Caveats

The demo version is optimised for rapid install, however it should not be considered for production / commercial use, or for use by more than 2-5 people, for the following reasons:

1) Static content is compiled into SAS services, placing undue strain on the Load Balancer (not scalable)

2) Direct URLs are not functional

3) Requires BASE engine for config tables, with high risk of table locks

4) Not licenced for commercial use, and not supported

5) The embedded HandsOnTable library is not licenced for commerical use without a licence key

Contact Macro People support for a full-featured, fully licenced, scalable and supported deployment of Data Controller at your earliest convenience!