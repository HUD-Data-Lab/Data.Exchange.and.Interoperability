# HMIS API Reference Walkthrough Guide for v1.0

- Status: draft
- Deciders: ICF, HUD
- Date last updated: 2024-09-26

## Context and Problem Statement

The HUD API reference is to provide a standardized baseline of what external parties and users can expect from an HMIS vendor. Each vendor is required to implement the foundational endpoints.

This walkthrough is meant to serve as a guide to show how the API can be used to solve various user scenarios using the foundational endpoints. There may be additional business logic needed to implement these scenarios, but these walkthroughs highlight how the API reference can be used.


# User Scenario Workflows


| **Scenario** | **API Version** | **Relevant Endpoint(s)** | **Foundational/Optional** |
| - | - | - | - |
| See if a person has a record in HMIS | v.1.0 | ``` clientsummary/ ```, ```/clients/{PersonalID}```| Foundational |
| Update/create a client-level record | v.1.0 | ``` /clients/{PersonalID}```,```/clients```  | Foundational |
| See if a person has any enrollments | v.1.0 | ``` /enrollmentsummary/{PersonalID} ``` | Foundartional |
| See if a person has been enrolled in a CE project | TBD | Upcoming | Optional |
| See if a person is or has been enrolled in a specific project type (ES, PSH, etc.)  | v.1.0 | ```/enrollmentsummary/{PersonalID}``` | Foundational |

## Workflow: See if a person has a record in HMIS

## Request a list of PersonalIDs by PII and select the correct PersonalID (Skip this step is PersonalID is known)

NOTE: We are intentionally using POST for this search.

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
From the returned list of PersonalIDs the end user will select the correct PersonalID. Once the PersonalID is known then that can be used to return the rest of the client data.

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


# Workflow: Update/Create a client-level record

## Use PersonalID to update a client-level record (If PersonalID is unknown use the workflow in "See if a person has a record in HMIS" to identify PersonalID)

```yaml  
/clients/{PersonalID}:
    patch:
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
If the client is not in HMIS use this workflow to create a new client.
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

# Workflow: See if a person has any enrollments 

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

# Workflow: See if a person has been enrolled in a CE project

Under Discussion.

1. Add more fields to enrollmentsummary (returns the CEParticipation data elements + Enrollment information)
2. Create new endpoint at the client level (/CEparticpationExample/{PersonalID}) that returns a yes/no. Add a query to the GET and a yes/no response.

# Workflow: See if a person is or has been enrolled in a specific project type (ES, PSH, etc.) 
 
Use the /enrollmentsummary/{PersonalID} endpoint to return a table of all enrollments the client has. This table includes project type.

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
