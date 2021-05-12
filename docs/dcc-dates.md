# Data Controller for SAS® - Dates & Datetimes

## Overview

Dates & datetimes are actually stored as plain numerics in regular SAS tables. In order for the Data Controller to recognise these values as dates / datetimes a format must be applied.

![displayed](img/dcc-dates1.png) ![source](img/dcc-dates2.png)

Supported date formats:

* DATE.
* DDMMYY.
* MMDDYY.
* YYMMDD.
* E8601DA.
* B8601DA.

Supported datetime formats:

* DATETIME.

Supported time formats:

* TIME.
* HHMM.

In SAS 9, this format must also be present / updated in the metadata view of the (physical) table to be displayed properly.  This can be done using DI Studio, or by running the following (template) code:

```sas
proc metalib;
  omr (library="Your Library");
  folder="/Shared Data/table storage location";
  update_rule=(delete);
run;
```

If you have other dates / datetimes / times you would like us to support, do [get in touch](http://datacontroller.io/contact)!






