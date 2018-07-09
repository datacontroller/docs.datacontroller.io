# Data Controller for SAS: User Guide

## Overview

The Data Controller has 5 tabs, as follows:

* *Viewer*.  This tab lets users view any table to which they have been granted access in metadata.  They can also download the data as csv, excel, or as a SAS program (datalines).
* *Editor*.  This tab enables users to add, modify or delete data. This can be done directly in the browser, or by uploading a CSV file. Values can also be copy-pasted from a spreadsheet. Once changes are ready, they can be submitted, with a corresponding reason.
* *Submissions*.  This shows and editor the outstanding changes that have been submitted for approval (but have not yet been approved or rejected).
* *Approvals*.  This shows an approver all their outstanding approval requests.
* *History*.  This shows an auditor, or other interested party, what changes have been submitted for each table.

## Viewer

The Viewer screen lets any user with a SAS profile view tables to which they have already been granted access in metadata.  Simply Select library / table and the View button.  The first 5,000 rows of the table in question are displayed.

It is also possible to build complex filters against data before viewing, via the Filter button.  The filter string is converted into an ID, as can be seen in the URL.  Simply share this link with any other SAS user to share that particular view.
The Viewer also has a Download option.  This lets you Download your view of the data in CSV, Excel, and SAS format.  The SAS format option gives you a SAS program with the relevant DATALINES so that you can easily recreate your data in another instance of SAS.

## Editor

The Editor screen lets users who have been pre-authorised (via the `DATACTRL.MPE_SECURITY` table) to edit a particular table.  A user selects a particular library, and table and then has 3 options:

1 - *Filter*.  The user can filter before proceeding to perform edits.

2 - *Upload*.  The user can upload a CSV file directly, instead of using the interface.  The CSV must have the same structure as the target.  Use the 'download csv' option in Viewer to obtain a template of this CSV.

3 - *Edit*.  This is the main interface, data is displayed in tabular format.  The first column is always "Delete?", as this allows you to mark rows for deletion.  Note that removing a row from display does not mark it for deletion!  It simply means that this row is not part of the changeset being submitted.
The next set of columns are the Primary Key, and are shaded grey.  If the table has a surrogate / retained key, then it is the Business Key that is shown here (the RK field is calculated / updated at the backend).  For SCD2 type tables, the 'validity' fields are not shown.  It is assumed that the user is always working with the current version of the data, and the view is filtered as such.
After this, remaining columns are shown.  Dates / datetime fields have appropriate datepickers.  Other fields may also have dropdowns to ensure entry of standard values, these can be configured in the `DATACTRL.MPE_SELECTBOX` table.

New rows can be added using the right click context menu, or the 'Add Row' button.  The data can also be sorted by clicking on the column headers.

When ready to submit, hit the SUBMIT button and enter a reason for the change.  The owners of the data are now alerted (so long as their email addresses are in metadata) with a link to the approve screen.
If you are also an approver you can approve this change yourself.

## Submitted
This page shows a list of the changes you have submitted (that are not yet approved).

## Approvals
This shows the list of changes that have been submitted to you (or your group) for approval.

## History
View the list of changes to each table, who made the change, when, etc.
