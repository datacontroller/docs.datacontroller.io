# Data Controller for SAS®: Overview

## What does the Data Controller do?

The Data Controller allows users to add, modify, and delete data. All changes are staged and approved before being applied to the target table. The review process, as well as using generic and repeatable code to perform updates, works to ensure data integrity.

## What is a Target Table?
A Target Table is a physical table, such as a SAS dataset or a Table in a database. The attributes of this table (eg Primary Key, loadtype, library, SCD variables etc) will have been predefined by your administrator so that you can change the data in that table safely and easily.

## How does it work?

From the Editor tab, a user selects a library and table for editing. Data can then be edited directly, or a uploaded from a file.  After submitting the change, the data is loaded to a secure staging area, and the approvers are notified.  The approver (which may also be the editor, depending on configuration) reviews the changes and accepts / or rejects them. If accepted, the changes are applied to the target table by the system account, and the history of that change is recorded.

## Who is it for?

There are 5 roles identified for users of the Data Controller:

1. *Viewer*.  A viewer uses the Data Controller as a means to explore data without risk of locking datasets. By using the Data Controller to view data, it also becomes possible to 'link' to data (eg copy the url to share a table with a colleague).
2. *Editor*.  An editor makes changes to data in a table (add, modify, delete) and submits those changes to the approver(s) for acceptance.
3. *Approver*.  An approver accepts / rejects proposed changes to data under their control. If accepted, the change is applied to the target table.
4. *Auditor*.  An auditor has the ability to review the [history](dc-userguide.md#history) of changes to a particular table.
5. *Administrator*.  An administrator has the ability to add new [tables](dcc-tables.md) to the Data Controller, and to configure the security settings (at metadata group level) as required.
