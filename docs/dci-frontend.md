# Data Controller for SAS® - Frontend Deployment

## Overview
The Data Controller front end was built on the Angular seed app from Boemska AppFactory®.  As such it comes bundled with standard features such as log handling and SASLogon redirects.  It is deployed the the root of the SAS Web Server (mid-tier), typically `htdocs`.

## Instructions

1 - Unzip dcfrontend.zip and upload the entire `datacontroller` directory to the static content server

2 - Open the `h54s.config` file and update the `metadataRoot` value to the location of the Stored Processes as per [backend](dci-backend.md) deployment.

It should now be possible to use the application - simpliy navigate to YO
URSASWEBLOC.domain/yourRoot/datacontroller and sign in!

The next step is to [configure](dcc-tables.md) the tables.
