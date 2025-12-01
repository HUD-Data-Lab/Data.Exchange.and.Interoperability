# HMIS API Reference Guide
Version 1.0
- Status: [draft]

## Overview

The HMIS API was developed in collaboration with the Data Exchange and Interoperability Workgroup, which included several HMIS vendors and the Department of Housing and Urban Development (HUD). 

It is intended to support Continuums of Care (CoCs) in implementing data exchange and interoperability processes in their communities. Specifically, the HMIS API Reference aims to facilitate real-time data exchange that directly benefits people experiencing homelessness by reducing the need for duplicative storytelling and improving access to critical services or supports needed to resolve their housing crisis. It also minimizes the data entry burden on service providers by reducing duplicative data entry, allowing them to focus more on delivering care.

## Document Purpose and scope
The HMIS API Reference is designed to provide a standardized baseline for what HMIS end users, vendors, external cross-system partners, and other interested entities can expect from an application programming interface (API) built within HMIS.

The HMIS API has the following components:
- A standardized format for data exchange. 
- A set of baseline scenarios that every HMIS vendor can facilitate using the standardized format. 
- Guidelines for extensibility using the standard format.

This HMIS API specification defines the format, method, and baseline scenarios that Continuums of Care (CoCs) can implement directly "off the shelf". The specification intentionally defers to HMIS vendors for any additional business logic necessary to support data exchange, as well as for any extensions beyond the scope of this specification that may be needed to address specific scenarios or requirements from individual CoCs. Some examples of business logic, extension scenarios, and how to leverage the linked data workflow can be found in the [appendix](#appendix).

# HMIS API Standardized Format
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



# Baseline Scenarios

|||
| - | - |
| [Scenario 1](#scenario-1) | Search for a client record by identifying information |
| [Scenario 2](#scenario-2) | Generate a new client record|
| [Scenario 3](#scenario-3)| Generate a list of all client records in a project |
| [Scenario 4](#scenario-4) | Generate a list of all client records in a project|
| [Scenario 5](#scenario-5)| Generate a list of enrollments related to a single client|
| [Scenario 6](#scenario-6)| Generate a list of projects being funded by HUD: CoC Rapid Re-Housing|
| [Scenario 7](#scenario-7) | Generate a list of projects with project type: Rapid Re-Housing|
| [Scenario 8](#scenario-8) | Generate a list of clients being funded by HUD: CoC Rapid Re-Housing|
| [Scenario 9](#scenario-9) | Generate a list of clients who are active in project type Rapid Re-Housing |
| [Scenario 10](#scenario-10) | Identify if a client has had a change in the last 30 days. Changes may include new enrollments, new exit dates, new destinations, any updates to data elements collected at the client level|
| [Scenario 11](#scenario-11) | Comprehensive return of all a person’s services. Within a timeframe or all time|
| [Scenario 12](#scenario-12)| FHIR|
| [Scenario 13](#scenario-13)| Medicaid Billing|

To view the expected request and response for each baseline see the documentation [here](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/HUD-Data-Lab/Data.Exchange.and.Interoperability/refs/heads/main/hmis_api_ld_0.4.yaml#operation/clientSearch)

## Appendix
### HMIS Data Standards Model
HUD’s data model identifies resources to organize and manage data related to individuals and households at-risk of and experiencing homelessness. These resources are required to identify participation and fulfill reporting requirements established by the U.S. Department of Housing and Urban Development (HUD), the U.S. Department of Health and Human Services (HHS), the U.S. Department of Veterans Affairs (VA), and other federal partners. The data model is comprised of: 
- HMIS Data Dictionary: designed for HMIS/comparable database vendors and HMIS Leads/System Administrators to identify the data elements required in an HMIS and understand the function and specific use of each element by the appropriate federal partner.
- HMIS CSV Format Specifications: describes the common format and associated basic expectations and assumptions for standardized HMIS data import and export. In general, HUD expects that it is possible to export, in a standard format, all data entered into an HMIS platform for any data element defined by the HMIS Data Dictionary, regardless of whether a given data element is required based on project type or funder.

### HMIS Logic Model
Defines the normative relationships for the HUD HMIS data elements, independent of any technical implementation considerations. The model is intended to technically express the relationships and underlying constraints described in the HMIS Data Standards Model. The logic model is comprised of:
- [Entity Relationship Diagram (ERD)](https://dbdiagram.io/d/FY2026-Entity-Relationship-Diagram-67e1e1c175d75cc8444e549b) based on the HUD CSV Format Specifications
- HMIS Ontology: A machine-readable [semantic model](https://github.com/HUD-Data-Lab/HMIS-Logic-Model/blob/main/FY2026_HMIS_Logic_Model_RDF.owl) made in the Web Ontology Language (OWL) with an supporting [human-readable class diagram](https://alexandriaconsulting.com/webvowl/#iri=https://raw.githubusercontent.com/HUD-Data-Lab/HMIS-Logic-Model/refs/heads/main/FY2026_HMIS_Logic_Model_RDF.owl).

## HMIS Vendor Business Logic
The HMIS API 

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

## HMIS API Extensions Examples
Enter examples here.

## HMIS API Linked Data
The HMIS Logic model as an [ontology](https://github.com/HUD-Data-Lab/HMIS-Logic-Model/blob/main/FY2026_HMIS_Logic_Model_RDF.owl) can be exported in a JSON-LD format. 

