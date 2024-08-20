# HMIS API Reference Walkthrough Guide

- Status: draft
- Deciders: ICF, HUD
- Date: 2024-08-12

## Context and Problem Statement

The HUD HMIS API Reference was created to set the minimum requirements for data exhcange and interoperability using APIs for HMIS. This walkthrough is meant to serve as a guide to show how the API can be used to solve various user scenarios. 


# User Scenarios

1. Allow an external platform/user(s) confirm if a client is enrolled in CES
2. 

| **Scenario** | **API Version** | **Endpoint(s)** |
| - | - | - |
| Enrolled in CES | v.1.0 | ``` clientsummary/ ``` |
| Sarah | Developer | $60,000 |  
| Lisa | Designer | $50,000 |


# HMIS openapi guide

Version 1.0 of the API reference is intended to allow for the following functionality from external platforms/users:
- See if a person has a record in HMIS
- Update/create a client-level record
- See if a person has active enrollments 
- See if a person is or has been enrolled in a CE project 
- See if a person is or has been enrolled in a specific project type (ES, PSH, etc.) 
- See if a person is or has been enrolled in a project with specific funding (PATH, Pay for Success, etc.) 
- Update records associated with these tables [note: full enrollment functionality would come with v1.1]

## See if a person has a record in HMIS

To accomplish this action the workflow shown in the API is for the external platform/user to do the following:

## Request a list of PersonalIDs and select the correct PersonalIDs (Skip this step is PersonalIDs is known)

NOTE: We chose to use a post instead of a get. 

```yaml
 /clientsummary:
    post:
      tags:
        - ClientSummary
      summary: Request via POST a summary list of clients.
      description: |
        Get a list of clients by partial Personal Identifiable Information (PII). 
        The request parameter are passed via the http body for security/privacy reasons. 
        Putting PII in url parameter could in them ending up in logs.

        The fields in the ClientSummary can be partial. e.g. Prefix of last name
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/ClientSummary'
      responses:
        '200':
          description: A list of clients that match the query
          content:
            application/json:
              schema:
                type: array
                items:
                  $ref: '#/components/schemas/ClientSummaryResponse'
        '404':
          description: Client not found
        '400':
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorResponse'
          description: The request generated an error and could not process.
```

## Using the PersonalIDs return the client data

```yaml
  /clients/{PersonalID}:
    get:
      tags:
        - Clients
      summary: Get client data by their Personal Identifier
      description: Get client data by their Personal Identifier
      parameters:
        - name: PersonalID
          in: path
          required: true
          description: Unique identifier for a client
          schema:
            type: string
            maxLength: 32
      responses:
        '200':
          description: Successful response with client data
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Client'
        '404':
          description: Client not found
```


# Update/Create a client-level record

To accomplish this action the workflow shown in the API is for the external platform/user to do the following:

## Use PersonalID to update a client-level record (If PersonalID is unknown use the workflow in "See if a person has a record in HMIS" to identify PersonalID)

```yaml  
/clients/{PersonalID}:
    put:
      tags:
        - Clients
      summary: Update an existing client record.
      description: Update an existing client record.
      parameters:
        - name: PersonalID
          in: path
          required: true
          description: Unique identifier for the client to update
          schema:
            type: string
            maxLength: 32
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/ClientBase'
      responses:
        '200':
          description: Client successfully updated
        '404':
          description: Client not found
        '400':
          description: Invalid input provided
```
## Create a new client information 

```yaml
/clients:
    post:
      summary: Create a new client record
      description: This creates a new client record
      tags:
        - Clients
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/ClientBase'
      responses:
        '200':
          description: Successful response with client data
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Client'
        '201':
          description: Client successfully created
        '400':
          description: Invalid input provided
```

# See if a person has active enrollments 

## Using the PersonalID return a list of their enrollments (If PersonalID is unknown use the workflow in "See if a person has a record in HMIS" to identify PersonalID)

```yaml
/enrollmentsummary/{PersonalID}:
    get:
      tags: 
        -  EnrollmentSummary
      summary: Get enrollments by PersonalID
      description: |
        This gets enrollments by PersonalID. 
        Commonly sorted alphabetically by ProjectName, EntryDate (most recent entry date at top), ExitDate (NULL exit date at top)
      parameters:
        - name: PersonalID
          in: path
          required: true
          description: Unique identifier for a client
          schema:
            type: string
            maxLength: 32
        - $ref: '#/components/parameters/OffsetParam'
        - $ref: '#/components/parameters/LimitParam'
      responses:
        '200':
          description: A list of enrollments 
          content:
            application/json:
              schema:
                allOf:
                  - $ref: '#/components/schemas/EnrollmentSummaryResponse'
                  - $ref: '#/components/schemas/PaginatedList'
        '404':
          description: Enrollment not found
```

# See if a person has been enrolled in a CE project

For Discussion:

1. Add more fields to enrollmentsummary (returns the CEParticipation data elements + Enrollment information)
2. Create new endpoint at the client level (/CEparticpationExample/{PersonalID}) that returns a yes/no. Add a query to the GET and a yes/no response.

# See if a person is or has been enrolled in a specific project type (ES, PSH, etc.) 
 
Use the /enrollmentsummary/{PersonalID} endpoint to return a table of all enrollments the client has. This table includes project type.


# See if a person is or has been enrolled in a project with specific funding (PATH, Pay for Success, etc.) 

```yaml
/fundersummary/{ProjectID}:
    get:
      tags: 
        -  FunderSummary
      summary: |
        Get Funder information by ProjectID. 
        This table includes all the funding sources for the specific ProjectID.
      description: |
        Get Funder information by ProjectID. 
        This table includes all the funding sources for the specific ProjectID.
      parameters:
        - name: ProjectID
          in: path
          required: true
          description: Unique identifier for a project
          schema:
            type: string
            maxLength: 32
        - $ref: '#/components/parameters/OffsetParam'
        - $ref: '#/components/parameters/LimitParam'
      responses:
        '200':
          description: All clients, enrollments, and projects using a specific funding source 
          content:
            application/json:
              schema:
                allOf:
                  - $ref: '#/components/schemas/FunderSummaryResponse'
                  - $ref: '#/components/schemas/PaginatedList'
        '404':
            description: FunderID not found
```