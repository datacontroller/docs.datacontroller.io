---
layout: article
title: Roadmap
description: The Data Controller roadmap is aligned with the needs of our customers - we continue to build and prioritise on Features requested by, and funded by, new and existing customers.
og_image:  https://i.imgur.com/xFGhgg0.png
---

# Roadmap

## Overview

On this page you can find details of the Features that have currently been requested, that we agree would add value to the product, and are therefore in our development roadmap.

Where customers are paying for the new Features (eg with our discounted Developer Days offer), then those Features will always take priority.  Where funding is not available, new Features will be addressed during the Bench Time of our developers, and will always be performed after Bug Fixes.

If you would like to see a new Feature added to Data Controller, then let's have a chat!


## Requested Features

Where features are requested, whether there is budget or not, we will describe the work below and provide estimates.

There is currently one feature requested:

* Ability to restore previous versions (estimate - 6 to 9 days).  Sponsor needed.

## Delivered Features

Below are some examples of Features that have been requested (and delivered) into Data Controller.

### Dynamic Filtering

Previously, if a user filtered on, say, "region", and then filtered on "store", they would see stores for ALL regions (not just the region/regions already selected in the filter).

![](https://i.imgur.com/KDEVvDi.png)

#### Solution

We added a checkbox to the top left of the filter dialog (default ON) for "Dynamic Where Clause".  Whilst enabled, whenever a list of values is requested, it is filtered using every filter clause EXCEPT the one currently being modified.

See [documentation](/filter/).  Available from [v.3.12.](https://datacontroller.io/3-12-four-new-data-management-features/)


### Dynamic Cell Validation

When editing a value in a grid, the values presented to the user should be filtered according to additional rules, based on the values of other cells in the same row.

![](https://i.imgur.com/J1q4lqo.png)

#### Solution

We provided two new config item in the MPE_VALIDATIONS table - to links an editable column to a HOOK script via a web service.

The configuration would like like so:

![](https://i.imgur.com/8Hx05GP.png)

In this way, the entire record can be sent to SAS, for processing by the hook script, before returning the desired list of values.

The HOOK_SCRIPT can be either a SAS program on a filesystem (identified by a ".sas" extension) or the path to a registered SAS Service (STP or JES).  The latter is identified by the absence of an extension.

This approach provides maximum flexibility for delivering bespoke values in the edit grid dropdown.

See [documentation](/dynamic-cell-dropdown/).  Available from [v.3.12.](https://datacontroller.io/3-12-four-new-data-management-features/)

---

### Row Level Security

Row level security is provided by various products in both SAS 9 and Viya, based on the logged in user identity.

This is problematic for the EDIT page, which - by necessity - operates under system account credentials.

It is also the case that some customers need row level security but the data access engine does not support that.

Therefore, there was a need to configure such a feature within the Data Controller product.

#### Solution

A new table (MPE_ROW_LEVEL_SECURITY) was added to the data controller library to allow complex rules to be applied based on the SAS group and the target table. Documentation is [here](/row-level-security/)

Available from [v.3.12.](https://datacontroller.io/3-12-four-new-data-management-features/)

### Formula Preservation

Data Controller uses an OEM licence with the excellent [sheetJS](https://sheetjs.com/) library.  This enables us to read pretty much any version of Excel at breakneck speeds.

By default, Data Controller will use the data model of the target table when extracting data, eg to determine whether a column should be character, numeric, date, datetime or time.

Formats used to be ignored and only the cell _values_ would be extracted when formulas are being used.

Now, it is possible to extract and retain the actual formula itself, so it can be re-used when downloading the data again later.

#### Solution

A new table (MPE_EXCEL_CONFIG) was be added to the data controller library to allow the column with the formula to be specified.  See [documentation](/excel/)

Available from [v.3.12.](https://datacontroller.io/3-12-four-new-data-management-features/)

### Configurable Locale

When importing spreadsheets with ambiguous dates (eg 01/02 or 02/01) the ANYDTDTM. informat was using the locale of the browser (en_us) instead of that of the client's actual country, resulting in incorrect dates being loaded.  This is due to the [default behaviour](https://rawsas.com/look-out-locale-gotcha/) of the SAS Stored Process server.

#### Solution

We added a [new config item](/dcc-options/#dc_locale) so that the locale can be explicitly set for all Data Controller users.

### Restricted Viewer

Data Controller relies on metadata permissions (in SAS 9) or authorization rules (in Viya) to determine who can see which table.

We had a customer who was using Data Controller to provide data access to a company wide audience, most of whom did not have access to SAS client tools (such as Enterprise Guide) and so had not been set up in metadata before.

It was necessary to find a way to restrict the tables which certain groups could see, without having to tweak permissions in SAS Management Console.

#### Solution

We added a [new access level](/dcc-security/#view) in the MPE_SECURITY table so that access could be restricted at both TABLE and LIBRARY level.