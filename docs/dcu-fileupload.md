# Data Controller for SAS: File Uploads

Files can be uploaded via the Editor interface - first choose the library and table, then click "Upload".  All versions of excel are supported.  

Uploaded data may *optionally* contain a column named `_____DELETE__THIS__RECORD_____` - where this contains the value "Yes" the row is marked for deletion.

If loading very large files (eg over 10mb) it is more efficient to use CSV format, as this bypasses the local rendering engine, but also the local DQ checks - so be careful!  Examples of local (excel) but not remote (CSV) file checks include:

* Length of character variables - CSV files are truncated at the max target column length
* Length of numeric variables - if the target numeric variable is below 8 bytes then the staged CSV value may be rounded if it is too large to fit
* NOTNULL - this rule is only applied at backend when the constraint is physical (rather than a DC setting)
* MINVAL 
* MAXVAL
* CASE

Note that the HARDSELECT_*** hooks are not applied to the rendered Excel values (they are currently only applied when editing a cell).

![image](https://user-images.githubusercontent.com/4420615/233036372-87b8dd02-a4cd-4f19-ac1b-bb9fdc850607.png)


## Excel Uploads

Thanks to our pro license of [sheetJS](https://sheetjs.com/), we can support all versions of excel, large workbooks, and extract data extremely fast.  We also support the ingest of [password-protected workbooks](/videos#uploading-a-password-protected-excel-file).

The rules for data extraction are:

* Scan the spreadsheet until a row is found with all the target columns (not case sensitive)
* Extract data below until the *first row containing a blank primary key value*

This is incredibly flexible, and means:

* data can be anywhere, on any worksheet
* data can contain additional columns (they are just ignored)
* data can be completely surrounded by other data

A copy of the original Excel file is also uploaded to the staging area.  This means that a complete audit trail can be captured, right back to the original source data.

!!! note
    If the excel contains more than one range with the target columns (eg, on different sheets), only the FIRST will be extracted.

## CSV Uploads

The following should be considered when uploading data in this way:

 - A header row (with variable names) is required
 - Variable names must match those in the target table (not case sensitive).  An easy way to ensure this is to download the data from Viewer and use this as a template.
 - Duplicate variable names are not permitted
 - Missing columns are not permitted
 - Additional columns are ignored
 - The order of variables does not matter EXCEPT for the (optional) `_____DELETE__THIS__RECORD_____` variable.  When using this variable, it must be the **first**.
 - The delimiter is extracted from the header row - so for `var1;var2;var3` the delimeter would be assumed to be a semicolon
 - The above assumes the delimiter is the first special character! So `var,1;var2;var3` would fail
 - The following characters should **not** be used as delimiters
    - doublequote
    - quote
    - space
    - underscore

When loading dates, be aware that Data Controller makes use of the `ANYDTDTE` and `ANYDTDTTME` informats (width 19).
This means that uploaded date / datetime values should be unambiguous (eg `01FEB1942` vs `01/02/42`), to avoid confusion - as the latter could be interpreted as `02JAN2042` depending on your locale and options `YEARCUTOFF` settings.  Note that UTC dates with offset values (eg `2018-12-26T09:19:25.123+0100`) are not currently supported.  If this is a feature you would like to see, contact us.

!!! tip
    To get a copy of a file in the right format for upload, use the [file download](/dc-userguide/#usage) feature in the Viewer tab
    
!!! warning
    Lengths are taken from the target table.  If a CSV contains long strings (eg `"ABCDE"` for a $3 variable) then the rest will be silently truncated (only `"ABC"` staged and loaded). This issue does not apply to excel uploads, which are first validated in the browser.


