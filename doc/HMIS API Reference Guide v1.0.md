# HMIS API Reference Guide
Version 1.0
- Status: [draft]

## Overview
The HMIS API Product Suite was developed in collaboration with the Data Exchange and Interoperability Workgroup, which included several HMIS vendors and the Department of Housing and Urban Development (HUD). 

This product suite is intended to support HMIS Vendors and developers implement data exchange and interoperability processes for Continuums of Care (CoCs). The intention of this suite of products is to directly benefit people experiencing homelessness by reducing the need for duplicative storytelling and improving access to critical services or support needed to resolve their housing crisis. It also minimizes the data entry burden on service providers by reducing duplicative data entry, allowing them to focus more on delivering care. 

Please note that HMIS API Reference guide is intended to provide an overview of each of the components of the HMIS API Product Suite. The HMIS API Product Suite is a living set of tools for HMIS vendors, developers, and CoCs.

# Key Concepts and Definitions
- **Data Exchange**: The ability to move information from System A to System B in a structured format. Example: CSV imports and exports, or transfer of HMIS data between distinct APIs or filepaths.
- **Interoperability**: Shared semantic reference points for data classifications and business rules facilitate automated data exchange AND processing without custom translation layers and enable event-driven coordination of information systems. Example: Verifying client eligibility for intervention based on lookup in benefits information system.
- **HMIS Ontology**: An explicit description of the concepts, relationships, attributes, and enumerations of the HMIS Data Standards. An ontology provides a common vocabulary and shared understanding of the HMIS Data Standards.
- **API Specification**: Defines how to document an API’s endpoints, request/response formats, authentication methods, and other details in a machine-readable way. 
- **API Artifacts**: Collection of files that are developed in a pipeline.

# HMIS API Product Suite
The components of the HMIS API Product Suite are:
- HMIS ontology
- HMIS API Specification
- Model-Driven Development Features

## HMIS Data Model / Ontology
The HMIS Data Model identifies resources to organize and manage data related to individuals and households at-risk of and experiencing homelessness. These resources are required to identify participation and fulfill reporting requirements established by the U.S. Department of Housing and Urban Development (HUD), the U.S. Department of Health and Human Services (HHS), the U.S. Department of Veterans Affairs (VA), and other federal partners. The data model is comprised of: 
- HMIS Data Dictionary: designed for HMIS/comparable database vendors and HMIS Leads/System Administrators to identify the data elements required in an HMIS and understand the function and specific use of each element by the appropriate federal partner.
- HMIS CSV Format Specifications: describes the common format and associated basic expectations and assumptions for standardized HMIS data import and export. In general, HUD expects that it is possible to export, in a standard format, all data entered into an HMIS platform for any data element defined by the HMIS Data Dictionary, regardless of whether a given data element is required based on project type or funder.
The HMIS Ontology defines the normative relationships for the HUD HMIS data elements, independent of any technical implementation considerations. The model is intended to technically express the relationships and underlying constraints described in the HMIS Data Standards Model. The logic model is comprised of:
- [Entity Relationship Diagram (ERD)](https://dbdiagram.io/d/FY2026-Entity-Relationship-Diagram-67e1e1c175d75cc8444e549b) based on the HUD CSV Format Specifications
- HMIS Ontology: A machine-readable [semantic model](https://github.com/HUD-Data-Lab/HMIS-Logic-Model/blob/main/FY2026_HMIS_Logic_Model_RDF.owl) made in the Web Ontology Language (OWL) with an supporting [human-readable class diagram](https://alexandriaconsulting.com/webvowl/#iri=https://raw.githubusercontent.com/HUD-Data-Lab/HMIS-Logic-Model/refs/heads/main/FY2026_HMIS_Logic_Model_RDF.owl).

## HMIS API Specification
This HMIS API specification defines the format, method, and baseline scenarios that Continuums of Care (CoCs) can implement directly "off the shelf". The specification intentionally defers to HMIS vendors for any additional business logic necessary to support data exchange, as well as for any extensions beyond the scope of this specification that may be needed to address specific scenarios or requirements from individual CoCs. 

The HMIS API has the following components:
- A standardized format for data exchange. 
- A set of baseline scenarios that every HMIS vendor can facilitate using the standardized format. 

This HMIS API specification defines the format, method, and baseline scenarios that Continuums of Care (CoCs) can implement directly "off the shelf". The specification intentionally defers to HMIS vendors for any additional business logic necessary to support data exchange, as well as for any extensions beyond the scope of this specification that may be needed to address specific scenarios or requirements from individual CoCs.

### HMIS API Standardized Format
The HMIS API is a RESTFul API that exposes multiple endpoints, each returning data in JSON format. Resources are accessed via standard HTTP methods (GET, POST, PUT, DELETE) using UTF-8 encoding. All requests are made to specific endpoints over HTTP(S), and responses conform to REST principles, enabling easy integration and interoperability.

The HMIS API uses the following HTTP verbs:

| **Method** | **Action** |
| - | - |
| GET | Used for retrieving resources |
| POST | Used for creating resources |
| PATCH | Used for changing or replacing resources and queries |
|

The HMIS API will follow the following versions when formatting requests and responses:

|||
| - | - |
| OpenAPI | [Version 3.1.1](https://swagger.io/specification/) |
| JSON | [Draft 2020-12](https://json-schema.org/draft/2020-12) |
| YAML | [Version 1.2](https://yaml.org/spec/1.2.2/) |
| HTTP Codes | [IANA Status Code Registry](https://www.iana.org/assignments/http-status-codes/http-status-codes.xhtml) |
|

## Authorization of the user to access the data

When a user has authorization to view only part of a client's data—such as specific project enrollments—the API must return only the data the user is permitted to access, without revealing the existence of any restricted data. Then HMIS API responses should have the following behavior:

- Include only authorized data: The response must contain only the project enrollments or fields the user is allowed to view.
- Exclude restricted data entirely: Do not include placeholders, nulls, or metadata that imply the presence of hidden data.
- Avoid total counts: Do not return counts or summaries that could reveal the existence of additional data.

For example, if a client is enrolled in Project A and Project B, but the user only has access to Project A, the API should respond:
```json
{
  "client_id": "12345",
  "Enrollments": [
    {
      "ProjectID": "A001",
      "ProjectName": "Project A",
      "EntryDate": "2023-06-01",
      "ExitDate":
    }
  ]
}
```

### Baseline Scenarios

||Description| System Logic |
| - | - | - |
| Scenario 1| Search for a client record by identifying information or PersonalID | PII should be protected from system logs. Approach used in HMIS API Specs is to use POST instead of GET|
| Scenario 2| Generate a new client record| |
| Scenario 3| Update an existing client record |
| Scenario 4| Generate a list of enrollments related to a single project| Include the ability to filter by Entry Date, and Exit Date.|
| Scenario 5| Generate a list of enrollments related to a single client|  Include the ability to filter by ProjectID, Entry Date, and Exit Date|
| Scenario 6| Generate a list of projects filtered by funder and project type| Include the ability to filter by funding source, project type, operating start date, operating end date, and CoC Code|
| Scenario 7 | Generate a list of clients filtered by funder and project type| Include the ability to filter by funding source, project type, entry date, and exit date|
| Scenario 8 | Comprehensive return of all a person's services and data changes in CSV format| Change window filters should be applied to the date created, date updated, date deleted. This should include the ability to filter to a specific change type. For example, if user wants to see only the updates then the change window applies to Date Updated.If the user wants to see any update then the change window applies to date created, date updated, and date deleted|

To view the full description of the expected request and response schemas for each baseline scenario see the documentation [here](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/HUD-Data-Lab/Data.Exchange.and.Interoperability/refs/heads/main/hmis_api_ld_0.5.yaml#operation/clientSearch) and the [yaml file here](https://raw.githubusercontent.com/HUD-Data-Lab/Data.Exchange.and.Interoperability/refs/heads/main/hmis_api_ld_0.5.yaml).

# Model-Driven Development Features
 
The HMIS API Specification will be enhanced by the development of three additional layers:
- Foundation Layer - [HMIS Ontology](https://github.com/HUD-Data-Lab/HMIS-Logic-Model)
- Translation Layer - [HMIS API Toolchain](https://github.com/HUD-Data-Lab/Data.Exchange.and.Interoperability/blob/main/hmis-codegen/README.md)
- Implementation Layer - HMIS Sandbox

These layers will set a single-source of truth that usable artifacts (OpenAPI specifications, mapping schemas to external standards, and effect handlers for packaged behaviors) can be generated from. Please refer to the [HMIS API Toolchain](https://github.com/HUD-Data-Lab/Data.Exchange.and.Interoperability/blob/main/hmis-codegen/README.md) for more information.

