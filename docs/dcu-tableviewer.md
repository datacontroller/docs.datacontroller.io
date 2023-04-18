# Data Controller for SAS: Viewer

The viewer screen provides a raw view of the underlying table.
Choose a library, then a table, and click view to see the first 5000 rows.
A filter option is provided should you wish to view a different section of rows.

The following libraries will be visible:

* All libraries available on startup (session autoexec)
* Any libraries configured in the `services/public/[Data_Controller_Settings/settings]` Stored Process / Viya Job
* All libraries available to the logged in user in metadata (SAS 9 only)

Row and Column level security can also be applied in VIEW mode, as can additional table-level permissions (MPE_SECURITY table).

## Full Table Search

A single search box can be used to make a full table search on any character or numeric value, using this [macro](https://core.sasjs.io/mp__searchdata_8sas.html).

<iframe width="560" height="315" src="https://www.youtube.com/embed/i27w-xq85WQ" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

## Options

This button shows a range of options.  If the table is editable, you will also see a EDIT option.

### Download
The Download button gives several options for obtaining the current view of data:

1) CSV.  This provides a comma delimited file.

2) Excel.  This provides a tab delimited file.

3) SAS Datalines.  This provides a SAS program with data as datalines, so that the data can be rebuilt as a SAS table.

4) SAS DDL.  A download of a DDL file using SAS flavoured syntax.

5) TSQL DDL.  A DDL download using SQL Server flavoured syntax.

Note - if the table is registered in Data Controller as being TXTEMPORAL (SCD2) then the download option will prefilter for the _current_ records and removes the valid from / valid to variables.  This makes the CSV suitable for DC file upload, if desired.

### Web Query URL

This option gives you a URL that can be used to import data directly into third party tools such as Power BI or Microsoft Excel (as a "web query").  You can set up a filter, eg for a particular month, and refresh the query on demand using client tooling such as VBA.
