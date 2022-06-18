---
layout: article
title: MPE_REVIEW
description: The MPE_REVIEW table tracks APPROVALS and REJECTIONS against SUBMITS
og_title: MPE_REVIEW Table Documentation
og_image: /img/mpe_review.png
---

# MPE_REVIEW

The MPE_REVIEW table tracks Approval and Rejection events.  This is useful for checking the history where tables require more than 1 approval. A user may only review a submit once (accept or reject).

![submits](/img/mpe_review.png)


## Columns

 - 🔑 `TABLE_ID char(32)`:  A unique code for the submission, and corresponds to the folder in which the staged data resides.
 - 🔑 `REVIEWED_BY_NM char(100)`: User id that made the final approval / rejection
 - `BASE_TABLE char(41) NOT NULL`: The LIBREF.MEMBER of the table being reviewed
 - `REVIEW_STATUS_CD char(10) NOT NULL`: Either APPROVED or REJECTED.  
 - `REVIEWED_ON_DTTM num NOT NULL`: Timestamp of the approval / rejection
 - `REVIEW_REASON_TXT char(400)`: Reason for rejection (for approvals, no reason is requested)
