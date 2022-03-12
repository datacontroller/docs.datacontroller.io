---
layout: article
title: Groups
description: By default, Data Controller will work with the SAS Groups defined in metadata or Viya.  It is also possible to define custom groups with Data Controller itself
og_image:  https://i.imgur.com/drGQBBV.png
---

# Adding Groups

## Overview
By default, Data Controller will work with the SAS Groups defined in metadata or Viya.  It is also possible to define custom groups with Data Controller itself - to do this simply add the user and group name (and optionally, a group description) in the `DATACTRL.MPE_GROUPS` table.

![](https://i.imgur.com/drGQBBV.png)

## Data Controller Admin Group

When configuring Data Controller for the first time, a group is designated as the 'admin' group.  This group has unrestricted access to Data Controller.  To change this group, modify the `%let dc_admin_group=` entry in the settings program.  To prevent others from changing this group, ensure the containing folder is write-protected!
