# Data Controller for SAS® - Security

## Summary
The Data Controller works at the level of Table and Group.  Permissions can only be set at group level, and so there are two parts to adding a user:

1 - Adding the user to the relevant group in SAS metadata

2 - Ensuring that group has the appropriate access level in the configuration table

For guidance with adding SAS users, see SAS Documentation.

## Details

In order to surface a table to a new group, simply add a record to the `DATACTRL.MPE_SECURITY` table.  The `library.dataset` value should go in the `BASE_TABLE` field, the level of access (either _EDIT_ or _APPROVE_) should go in the `ACCESS_LEVEL` field, and the exact name of the relevant metadata group should go in the `SAS_GROUP` field.  The change should then be submitted, and approved, at which point the new security setting will be applied.

![Screenshot](img/securitytable.png)
