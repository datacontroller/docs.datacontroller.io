# Data Controller for SAS: User Guide

## Viewer

The viewer screen provides a raw view of the underlying table.
Choose a library, then a table, and click view to see the first 5000 rows.
A filter option is provided should you wish to view a different section of rows.

The Download button gives three options for obtaining the current view of data:

1) CSV.  This provides a comma delimited file.

2) Excel.  This provides a tab delimited file.

3) SAS.  This provides a SAS program with data as datalines, so that the data can be rebuilt as a SAS table.

Note - if the table is registered in Data Controller as being TXTEMPORAL (SCD2) then the download option will prefilter for the _current_ records and removes the valid from / valid to variables.  This makes the CSV suitable for DC file upload, if desired.
