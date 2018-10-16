# Data Controller for SAS: File Uploads

Files can be uploaded via the Editor interface - first choose the library and table, then click "Upload".


<img src="/img/dcu-files1.png" height="350" style="border:3px solid black" >

The following should be considered when uploading data in this way:

 - A header row (with variable names) is required
 - Variable names must match the target
 - Duplicate variable names are not permitted
 - Missing columns are not permitted
 - Additional columns are ignored
 - The order of variables does not matter
 - The delimiter is extracted from the header row (so for `var1;var2;var3` the delimeter would be assumed to be a semicolon)
 - The above assumes the delimeter is the first special character! so `var,1;var2;var3` would fail
 - The following characters should not be used as delimeters: `"' ` (doubleqoute, quote, space)

When loading dates, be aware that the data controller makes use of the `ANYDTDTE` and `ANYDTDTTME` informats.
This means that uploaded date / datetime values should be unambiguous (eg `01FEB1942` vs `01/02/42`) to avoid confusion - as the latter could be interpreted as `02JAN2042` depending on your locale and options `YEARCUTOFF` settings.

!!! tip
    To get a copy of a file in the right format for upload, use the [file download](/dc-userguide/#usage) feature in the Viewer tab