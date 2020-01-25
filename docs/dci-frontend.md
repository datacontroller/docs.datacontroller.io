# Data Controller for SAS® - Frontend Deployment

## Overview
The Data Controller front end comes pre-built, and ready to deploy to the root of the SAS Web Server (mid-tier), typically `htdocs`.

## Instructions

1 - Unzip dcfrontend.zip and upload the entire `datacontroller` directory to the static content server.

2 - Open the `h54s.config` file and update the `metadataRoot` value to the location of the Stored Processes as per [backend](dci-backend.md) deployment.  Remember to include the trailing slash (`/`).

It should now be possible to use the application - simply navigate to `YO
URSASWEBLOC.domain/yourRoot/datacontroller` and sign in!

The next step is to [configure](dcc-tables.md) the tables.
