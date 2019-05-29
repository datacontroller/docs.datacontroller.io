# Data Controller for SAS® - Evaluation Version

## Overview
A free version of Data Controller is available for evaluation purposes. Compiled into a single SPK, it is very easy to install and configure.  However it must not be used in production environments for all the reasons mentioned in the [caveats](#caveats) section.

## Installation

### Deployment

Simply import the SPK to the desired location in the metadata tree.  During the import (step 5 of the wizard), be sure to change the location of the library (BASE engine) to a directory folder which the Stored Process system account (sassrv) has write access to.  Also, make sure that your user account has WRITE METADATA (WM) on the imported Data Controller DATA folder, and that anyone who will use the app has READ.

### Configuration

Navigate to the [YOURHOST]/SASStoredProcess web application and 'list available stored processes'.  Find the location where the app was imported, open the Admin subfolder and run the 'configurator' stored process.

![evaltree](img/dci_evaltree.png)

This displays a screen with a choice of SAS Metadata Groups (to which your account belongs) can be chosen. Selecting any of these groups will build / rebuild all the configuration tables (placing logs in a subfolder of the previously configured library location) and provide the chosen group with urestricted access to the tool.

![evaltree](img/dci_evalconfig.png)

!!! note
    "Unrestricted access" is provided by code logic.  Data Controller does not update or modify any metadata, except the `[YOURHOST/PATH]/Admin/Data_Controller_Settings` Stored Process (in which the the aforementioned logic is applied).


## Usage

Simply navigate to the imported location from the Stored Process Web App, right click on the 'clickme' stored process, and open in new window!

![evaltree](img/dci_evallaunch.png)


## Caveats

The demo version has been optimised for a rapid install, and should not be considered for production / commercial use, or for use by more than 2-5 people, for the following reasons:

1) Static content is compiled into SAS web services, which is inefficient (not scalable)

2) Requires BASE engine for config tables, with high risk of table locks

3) Not licenced for commercial (or production) use, and not supported

4) The embedded HandsOnTable library is not licenced for commercial use without a licence key

Contact Macro People support for a full-featured, fully licenced, scalable and supported deployment of Data Controller at your earliest convenience!