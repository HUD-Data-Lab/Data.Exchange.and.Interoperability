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

```
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

```
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

```  
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
## Enter the new client information

```
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

```
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

[Create endpoint for this]

1. Identify PersonalID
2. Use PersonalID to identify all enrollments (add more fields into EnrollmentSummary{PersonalID})

# See if a person is or has been enrolled in a specific project type (ES, PSH, etc.) 
 
[Create endpoint for this]

# See if a person is or has been enrolled in a project with specific funding (PATH, Pay for Success, etc.) 

[Create endpoint for this]