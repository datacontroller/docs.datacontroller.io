# Data Controller for SAS® - System Requirements

## Overview
The Data Controller is a SAS Web Application, deployed into an existing SAS platform, and as such has no special requirements beyond what is typically available in a SAS Foundation or Viya environment.

## SAS 9
### Backend
A SAS Foundation deployment of at least 9.4M3 must be available. Earlier versions of SAS can be supported, on request.  A SAS Stored Process Server must be configured, running under a system account.

### Mid-Tier
A web server with `/SASLogon` and the SAS SPWA must be available to end users

## SAS Viya
A minimum of Viya 3.5 is recommended to make use of the ability to run a shared compute instance.

## Frontend
All major browsers supported, including IE11 (earlier versions of IE may not work properly).
For IE, note that [compatibility view](dci-troubleshooting#Internet Explorer - blank screen) must be disabled. 