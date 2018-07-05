# Data Controller for SAS: Overview

## What does the Data Controller do?

The Data Controller for SAS allows user to add, modify data. All changes are staged and approved before being applied to the target table. The review process, as well as using generic and repeatable code to perform updates, works to ensure data integrity.

## What is a Target Table?
A Target Table is a physical table, such as a SAS dataset or a Table in a database. The attributes of this table (eg Primary Key, loadtype, library, SCD variables etc) will have been predefined by your administrator so that you can change the data in that table safely and easily.

## Why do I need the Data Controller?

Alternatives to using the Data Controller for performing data updates include:

 - Writing SAS or SQL code yourself to perform data updates
 - Asking your DBA to to perform updates (following a change mangement process)
 - Saving CSVs / data on a shared-visibility network drive and building / running jobs to perform uploads in batch
 - Opening (and therefore locking) datasets in Enterprise Guide or SAS® Table Viewer to perform direct updates
 - Building a custom web application yourself to perform secure updates

Problems with the above approaches include one or more of the following:

 - Risk of manual error / data corruption
 - End users requiring direct write access to critical data sources in production
 - Breaches due to unnecessary parties having access to the data
 - Inability to trace who made the change, when, and why
 - Reliance on key individuals to perform updates
 - Requirement to build load routines every time a new data source is added
 - Upload routines have to be manually modified when the table changes
 - Legacy 'black box' solutions with little to no testing, documentation or support

The Data Controller for SAS® solves the issues above.

## How does it work?

From the Editor tab, a user selects a library and table for editing. Data can then be edited directly, or a uploaded from a file.  After submitting the change, the data is loaded to a secure staging area, and the approvers are notified.  The approver (wich may also be the editor, depeneding on cconfiguration) reviews the changes and accepts / or rejects. If accepted, the changes are applied to the target table by the system account, and the history of that change is recorded.

## Who is it for?

There are 5 roles identified for users of the Data Controller:

1. *Viewer*.  A viewer uses the Data Controller as a means to explore data without risk of locking datasets. By using the Data Controller to view data, it also becomes possible to 'link' to data (share a url to share a table with a colleague, for instance).
2. *Editor*.  An editor makes changes to data in a table (add, modify, delete) and submits those changes to the approver(s) for acceptance.
3. *Approver*.  An approver accepts / rejects proposed changes to data under their control. If accepted, the change is applied to the target table.
4. *Auditor*.  An auditor has the ability to review the history of changes to a particular table.
5. *Administrator*.  An administrator has the ability to add new tables to the Data Controller, and to configure the security settings (at metadata group level) as required.
