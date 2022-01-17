---
layout: article
title: API
description: The Data Controller API provides a machine-programmable interface for loading spreadsheets into SAS
---

!!! warning
    Work in Progress!

# API

Where a project has a requirement to load Excel Files automatically into SAS, from a remote machine, an API approach is desirable for many reasons:

* Security.  Client access can be limited to just the endpoints they need (rather than being granted full server access).
* Flexibility.  Well documented, stable APIs allow consumers to build and extend additional products and solutions.
* Cost. API solutions are typically self-contained, quick to implement, and easy to learn.

A Data Controller API enables teams from across an enterprise to easily and securely send data to SAS in a transparent and fully automated fashion.

The API will benefit from all of Data Controllers existing [data validation](https://docs.datacontroller.io/dcc-validations/) logic (both frontend and backend), data auditing, [alerts](https://docs.datacontroller.io/emails/), and [security control](https://docs.datacontroller.io/dcc-security/) features.

It is also a significant departure from the existing "SAS Content" based deployment, in the following ways:

1. Server Driven.  A machine is required on which to launch, and run, the API application itself.
2. Fully Automated.  There is no browser, or interface, or - human, involved.
3. Extends outside of SAS.  There are firewalls, and authentication methods, to consider.

Data Controller does not have an API right now - but we do have plans, just waiting for the right project.  The technical solution will differ, depending on the type of SAS Platform being used.  There are three types of SAS Platform:

1. Foundation SAS.  Regular, Base SAS.
2. SAS EBI.  SAS 9, with Metadata.
3. SAS Viya.  SAS, cloud enabled.

And there are three main options when it comes to building APIs on SAS:

1. Standalone DC API (Viya Only).  Viya comes with [REST APIs](https://developer.sas.com/apis/rest/) out of the box, no middleware needed.
2. [SAS 9 API](https://github.com/analytium/sas9api).  This is an open-source Java Application, using SAS Authentication.
3. [SASjs Server](https://github.com/sasjs/server). An open source NodeJS application, compatible with all major authentication methods and all versions of SAS

An additional REST API option for SAS EBI might have been [BI Web Services](https://documentation.sas.com/doc/en/bicdc/9.4/bimtag/p1acycjd86du2hn11czxuog9x0ra.htm), however - it requires platform changes and is not highly secure.

The compatibility matrix is therefore as follows:

| Product | Foundation SAS| SAS EBI | SAS VIYA |
|---|---|---|---|
| DCAPI | ❌ | ❌ | ✅ |
| DCAPI + SASjs Server | ✅ | ✅ | ✅ |
| DCAPI + SAS 9 API | ❌ | ✅ | ❌ |

In all cases, a Data Controller API will be surfaced, that makes use of the underlying (raw) API server.

The following sections break down these options, and the work remaining to make them a reality.  

## Standalone DC API (Viya Only)

For Viya, the investment necessary is relatively low, thanks to the API-first nature of the platform. In addition, the SASjs framework already provides most of the necessary functionality - such as authentication, service execution, handling results & logs, etc.  Finally, the Data Controller team have already built an API Bridge (specific to another customer, hence the building blocks are in place).

The work to complete the Viya version of the API is as follows:

* Authorisation interface
* Creation of API services
* Tests & Automated Deployments
* Developer docs
* Swagger API 
* Public Documentation

Cost to complete - £5,000 (Viya Only)


## SASjs Server (Foundation SAS)

[SASjs Server](https://github.com/sasjs/server) already provides an API interface over Foundation SAS.  An example of building a web app using SASjs Server can be found [here](https://www.youtube.com/watch?v=F23j0R2RxSA).  In order for it to fulfill the role as the engine behind the Data Controller API, additional work is needed - specifically:

* Secure (Enterprise) Authentication
* Users & Groups
* Feature configuration (ability to restrict features to different groups)

On top of this, the DC API part would cover: 

* Authorisation interface
* Creation of API services
* Tests & Automated Deployments
* Developer docs
* Swagger API 
* Public Documentation

Cost to complete - £10,000 

Given that all three SAS platforms have Foundation SAS available, this option will work everywhere.  The only restriction is that the sasjs/server instance **must** be located on the same server as SAS.  


## SAS 9 API (SAS EBI)

This product has one major benefit - there is nothing to install on the SAS Platform itself. It connects to SAS in much the same way as Enterprise Guide (using the SAS IOM).

Website:  [https://sas9api.io](https://sas9api.io)
Github:  [https://github.com/analytium/sas9api](https://github.com/analytium/sas9api)

The downside is that the features needed by Data Controller are not present in the API.  Furthermore, the tool is not under active development.  To build out the necessary functionality, it will require us to source a senior Java developer on a short term contract to first, understand the tool, and secondly, to update it in a sustainable way.

We estimate the cost to build Data Controller API on this mechanism at £25,000.
