---
layout: article
title: MPE_TABLES
description: The MPE_TABLES table defines the tables that are EDITABLE within Data Controller for SAS® - along with attributes such as load type, number of approvals, and hook scripts.
---

# MPE_DATASTATUS_TABS

The `MPE_TABLES` table defines the tables that are EDITABLE - along with attributes such as load type, number of approvals, and hook scripts.

A more detailed breakdown of the columns / features is available in the [configuration](/dcc-tables/) section.

## Columns

 - `TX_FROM num`: SCD2 open datetime
 - 🔑 `TX_TO num`: SCD2 close datetime
 - 🔑 `LIBREF char(8)`: SAS Libref (8 chars)
 - 🔑 `DSN char(64)`: The library member name
 - `NUM_OF_APPROVALS_REQUIRED num`: The number of approvals required (against staged data) before the base table is updated.
 - `LOADTYPE char(12)`: The update method.  See [config](/dcc-tables/#loadtype)
 - `BUSKEY char(1000)`: The logical key.  See [config](/dcc-tables/#buskey)
 - `VAR_TXFROM char(32)`: The SCD2 start column of the base table.  See [config](/dcc-tables/#var_txfrom-var_txto)
 - `VAR_TXTO char(32)`: The SCD2 end column of the base table.  See [config](/dcc-tables/#var_txfrom-var_txto)
 - `VAR_BUSFROM char(32)`: The bitemporal business start column of the base table.  See [config](/dcc-tables/#var_busfrom-var_busto)
 - `VAR_BUSTO char(32)`: The bitemporal business end column of the base table.  See [config](/dcc-tables/#var_busfrom-var_busto)
 - `VAR_PROCESSED char(32)`: A column to contain the batch load time.  See [config](/dcc-tables/#var_processed)
 - `CLOSE_VARS char(500)`: Close out _unloaded_ records for a key section.  See [config](/dcc-tables/#close_vars)
 - `PRE_EDIT_HOOK char(200)`: Run SAS code before an EDIT.  See [config](/dcc-tables/#pre_edit_hook)
 - `POST_EDIT_HOOK char(200)`: Run SAS code after an EDIT.  See [config](/dcc-tables/#post_edit_hook)
 - `PRE_APPROVE_HOOK char(200)`: Run SAS code before an APPROVE.  See [config](/dcc-tables/#pre_approve_hook)
 - `POST_APPROVE_HOOK char(200)`: Run SAS code after final approval (and dataload).  See [config](/dcc-tables/#post_approve_hook)
 - `SIGNOFF_COLS char(200)`: For marking final approval.  See [config](/dcc-tables/#signoff_cols)
 - `SIGNOFF_HOOK char(200)`: Run SAS code after signoff.  See [config](/dcc-tables/#signoff_hook)
 - `NOTES char(1000)`: Additional notes. See [config](/dcc-tables/#notes)
 - `RK_UNDERLYING char(1000)`: The key on which the retained key is generated. See [config](/dcc-tables/#rk_underlying)
 - `AUDIT_LIBDS char(41)`: Configure alternative audit history tracking tables (or switch off audit history). See [config](/dcc-tables/#audit-libds)
