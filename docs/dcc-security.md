# Data Controller for SAS® - Security

## Summary
DC security is applied at the level of Table and Group.  Permissions can only be set at group level. There are two parts to adding a user:

1 - Adding the user to the relevant group in SAS metadata

2 - Ensuring that group has the appropriate access level in the configuration table

For guidance with adding SAS users, see [SAS Documentation](http://support.sas.com/documentation/cdl/en/mcsecug/69854/HTML/default/viewer.htm#n05epzfefjyh3dn1xdw2lkaxwyrz.htm).

## Details

In order to surface a table to a new group, simply add a record to the `DATACTRL.MPE_SECURITY` table.  The `library.dataset` value should go in the `BASE_TABLE` field, the level of access (either _EDIT_ or _APPROVE_) should go in the `ACCESS_LEVEL` field, and the exact name of the relevant metadata group should go in the `SAS_GROUP` field.  The change should then be submitted, and approved, at which point the new security setting will be applied.

![Screenshot](img/securitytable.png)

## EDIT vs APPROVE

The `EDIT` permission determines which groups will be able to upload CSVs and submit changes via the web interface for that table.  The `APPROVE` permission determines which groups will be able to approve those changes, and hence enable the target table to be loaded.  If you wish to have members of a particular group both edit AND approve, then two lines (one for each group) must be entered, per table.


## Determining Group Members

Before adding a group to Data Controller, it helps to know the members of that group!  The following options are available:

1 - Use SAS Management Console

2 - Deploy the [Boemska User Navigator](https://github.com/Boemska/user-navigator)

3 - Use Code

The "code" option can be performed as follows:

```
/* get macro library */
filename mc url "https://raw.githubusercontent.com/Boemska/macrocore/master/macrocore.sas";
%inc mc;
/* call macro */
%mm_getgroupmembers(YOURGROUPNAME)
/* the above will create a dataset containing the group members */
```