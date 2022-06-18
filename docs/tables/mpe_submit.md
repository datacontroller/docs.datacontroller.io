---
layout: article
title: MPE_SUBMIT
description: The MPE_SUBMIT table tracks the status of submitted modifications - ie SUBMITTED, APPROVED, or REJECTED.
og_title: MPE_SUBMIT Table Documentation
og_image: /img/mpe_submit.png
---

# MPE_SUBMIT

The MPE_SUBMIT table tracks the status of submitted modifications - ie SUBMITTED, APPROVED, or REJECTED.  It is unique on TABLE_ID.  A record is created whenever a submit is submitted.  

![submits](/img/mpe_submit.png)


## Columns

 - 🔑 `TABLE_ID char(32)`:  A unique code for the submission, and corresponds to the folder in which the staged data resides.
 - `SUBMIT_STATUS_CD char(10)`: Either SUBMITTED, APPROVED, or REJECTED.  Remains SUBMITTED until the final approval, or first rejection.
 - `BASE_LIB char(8)`: The LIBREF of the table being updated
 - `BASE_DS char(32)`: The name of the dataset (or format catalog) being updated
 - `SUBMITTED_BY_NM (100)`: The username of the submitter
 - `SUBMITTED_ON_DTTM num`: The timestamp of the submission
 - `SUBMITTED_REASON_TXT char(400)`: The description provided by the submitter
 - `INPUT_OBS num`: The number of observations staged
 - `INPUT_VARS num`: The number of variables staged
 - `NUM_OF_APPROVALS_REQUIRED num`: Taken from MPE_TABLES at the time of submission
 - `NUM_OF_APPROVALS_REMAINING num`: Decreased by 1 with every approval, set to 0 on rejection.
 - `REVIEWED_BY_NM char(100)`: User id that made the final approval / rejection
 - `REVIEWED_ON_DTTM num`: Timestamp of the final approval / rejection