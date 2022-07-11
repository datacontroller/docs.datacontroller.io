---
layout: article
title: MPE_CONFIG
description: The MPE_CONFIG table is used to apply global system options in DC
og_title: MPE_CONFIG Table Documentation
og_image: /img/mpe_config.png
---

# MPE_CONFIG

The MPE_CONFIG table enables global system options.  Further detail on each option can be found in the description of the option itself, or on the [options](/dcc-options) page.

![submits](/img/mpe_config.png)

The table is SCD2 controlled for ease of rollback and version management.

## Columns

 - 🔑 `TX_FROM num`: SCD2 open datetime
 - 🔑 `VAR_SCOPE char(10)`:  A short code for grouping sets of options
 - 🔑 `VAR_NAME char(32)`: The name of the option
 - `VAR_VALUE char(5000)`: The value of the option
 - `VAR_ACTIVE num`: Whether the rule should be used (1) or ignored (0).  Setting rules to 0 is a convenient way to turn them off without deleting them.
 - `VAR_DESC char(300)`: A short description of the option.
 - `TX_TO num`: SCD2 close datetime
