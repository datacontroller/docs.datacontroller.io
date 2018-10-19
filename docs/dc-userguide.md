# Data Controller for SAS: User Guide

## Interface

The Data Controller has 5 tabs, as follows:

* *[Viewer](#viewer)*.  This tab lets users view any table to which they have been granted access in metadata.  They can also download the data as csv, excel, or as a SAS program (datalines).
* *[Editor](#editor)*.  This tab enables users to add, modify or delete data. This can be done directly in the browser, or by uploading a CSV file. Values can also be copy-pasted from a spreadsheet. Once changes are ready, they can be submitted, with a corresponding reason.
* *[Submitted](#submitted)*.  This shows and editor the outstanding changes that have been submitted for approval (but have not yet been approved or rejected).
* *[Approvals](#approvals)*.  This shows an approver all their outstanding approval requests.
* *[History](#history)*.  This shows an auditor, or other interested party, what changes have been submitted for each table.

### Viewer

#### Overview
The viewer screen provides users with a raw view of underlying data.  It is only possible to view tables that have been registered in metadata.
Advantages of using the viewer (over client tools) for browsing data include:

* Ability to provide links to tables / filtered views of tables (just copy url)
* In the case of SAS datasets, prevent file locks from ocurring
* Ability to quickly download a CSV / Excel / SAS Cards program for that table

#### Usage
Choose a library, then a table, and click view to see the first 5000 rows.
A filter option is provided should you wish to view a different section of rows.

The Download button gives three options for obtaining the current view of data:

1) CSV.  This provides a comma delimited file.

2) Excel.  This provides a tab delimited file.

3) SAS.  This provides a SAS program with data as datalines, so that the data can be rebuilt as a SAS table.

Note - if the table is registered in Data Controller as being TXTEMPORAL (SCD2) then the download option will prefilter for the _current_ records and removes the valid from / valid to variables.  This makes the CSV a suitable format for subsequent DC file upload, if desired.

### Editor

The Editor screen lets users who have been pre-authorised (via the `DATACTRL.MPE_SECURITY` table) to edit a particular table.  A user selects a particular library, and table and then has 3 options:

1 - *Filter*.  The user can filter before proceeding to perform edits.

2 - *Upload*.  If you have a lot of data, you can [upload it directly](dcu-fileupload).  The changes are then approved in the usual way.

3 - *Edit*.  This is the main interface, data is displayed in tabular format.  The first column is always "Delete?", as this allows you to mark rows for deletion.  Note that removing a row from display does not mark it for deletion!  It simply means that this row is not part of the changeset being submitted.
The next set of columns are the Primary Key, and are shaded grey.  If the table has a surrogate / retained key, then it is the Business Key that is shown here (the RK field is calculated / updated at the backend).  For SCD2 type tables, the 'validity' fields are not shown.  It is assumed that the user is always working with the current version of the data, and the view is filtered as such.
After this, remaining columns are shown.  Dates / datetime fields have appropriate datepickers.  Other fields may also have dropdowns to ensure entry of standard values, these can be configured in the `DATACTRL.MPE_SELECTBOX` table.

New rows can be added using the right click context menu, or the 'Add Row' button.  The data can also be sorted by clicking on the column headers.

When ready to submit, hit the SUBMIT button and enter a reason for the change.  The owners of the data are now alerted (so long as their email addresses are in metadata) with a link to the approve screen.
If you are also an approver you can approve this change yourself.

#### BiTemporal Tables

The Data Controller only permits BiTemporal data uploads at a single point in time - so for convenience, when viewing data in the edit screen, only the most recent records are displayed.  To edit earlier records, either use file upload, or apply a filter.

### Submitted
This page shows a list of the changes you have submitted (that are not yet approved).

### Approvals
This shows the list of changes that have been submitted to you (or your groups) for approval.

### History
View the list of changes to each table, who made the change, when, etc.

