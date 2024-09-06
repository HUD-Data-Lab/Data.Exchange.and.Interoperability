# Shift to Foundational endpoints vs Use Case Endpoints

- Status: proposed
- Deciders: ICF, HUD
- Date: 2024-08-29

Technical Story: 
[#18](https://github.com/HUD-Data-Lab/Data.Exchange.and.Interoperability/issues/18)


## Context and Problem Statement
The HUD HMIS API Reference provides a standardized baseline of what external parties and users can expect from an HMIS API. USDS, HUD, and ICF intended to build the API around use cases to allow the API to address the needs of CoCs to exhange data. However, the API should also be as minimal as possible. THe HMIS Vendors have also flagged the potential challenge of having the HUD HMIS API try to create a new endpoint of every user scenario need. The challenge is, how do we address the user scenarios while also keeping the API as minimal as possible.

## Decision Drivers

- API Reference should support specific use cases from CoCs
- API Reference should be as minimal as possible
- The API Reference should provide a standardized baseline of what external parties and users can expect from an HMIS API.

## Considered Options

- [option 1]: Build the API based around a single use case to create a minimul viable product
- [option 2]: Focus the api on being 1:1 to the csv with the additon of user scenarios
- [option 3]: Specify the foundational endpoints with a maintained library of use cases.

## Decision Outcome

Chosen option: "[option 3]". 

HUD HMIS API Reference is grouped by collections. These collections are 1:1 the HUD CSV file. These collections will make up the foundaton collection. The foundatonal endpoints are the endpoints that allow an external user to create, update, view, or delete any information from a foundation collection. This will be focused on the data elements themselves and less on a specifc use case.

THe HUD Data Lab will manage a collection of use case resources. These resources will be the modified collections and new endpoints to address a variety of use cases. These are not required by the vendor to implement, but can easily be integrated into the reference if they choose. 

The vendors will be required to implement the foundational endpoints. This would keep the API Reference as minimul as possible and allow a clear standardized baseline for external systems to expect from HMIS. 

The library of use cases is will be an open library. Communities and vendors can add to it and use it as a starting point. This would allow a level of customizability for each community.


### Example of a Foundation Resource: Client

``` yaml 
 paths:
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

        delete:
        tags:
            - Clients
        summary: Delete a client record
        description: This marks the client record as deleted
        parameters:
            - name: PersonalID
            in: path
            required: true
            description: Unique identifier for the client to delete
            schema:
                type: string
                maxLength: 32
        responses:
            '204':
            description: Client successfully deleted
            '404':
            description: Client not found
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
        parameters: 
            - $ref: "#/components/parameters/LimitParam"
            - $ref: "#/components/parameters/OffsetParam"
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
                    allOf: 
                    - $ref: '#/components/schemas/ClientSummaryResponse'
                    - $ref: "#/components/schemas/BaseResponse"
            '404':
            description: Client not found
            '400':
            content:
                application/json:
                schema:
                    $ref: '#/components/schemas/ErrorResponse'
            description: The request generated an error and could not process.

components:
    schemas:
            ClientBase:
      type: object
      properties:
        FirstName:
          type: string
          description: First name of the client. Data Element 3.01 Name
          externalDocs: 
            url: https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/universal-data-elements/301-name/
          maxLength: 50
        MiddleName:
          type: string
          description: Middle name of the client. Data Element 3.01 Name
          externalDocs: 
            url: https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/universal-data-elements/301-name/
          maxLength: 50
        LastName:
          type: string
          description: Last name of the client. Data Element 3.01 Name
          externalDocs: 
            url: https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/universal-data-elements/301-name/
          maxLength: 50
        NameSuffix:
          type: string
          description: Suffix of the client's name. Data Element 3.01 Name
          externalDocs: 
            url: https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/universal-data-elements/301-name/
          maxLength: 50
        NameDataQuality:
          type: integer
          description: Data Element 3.01 Name
          externalDocs: 
            url: https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/universal-data-elements/301-name/
          oneOf:
            - $ref: '#/components/schemas/NameDataQuality_list'
        SocialSecurityNumber:
          type: string
          description: Social Security Number, potentially masked with 'x'. 
          pattern: '^[0-9]{9}$'
        SocialSecurityNumberDataQuality:
          type: integer
          oneOf:
            - $ref: '#/components/schemas/SocialSecurityNumberDataQuality_list'
        DateOfBirth:
          type: string
          description: Date of birth of the client
          format: date
        DateOfBirthDataQuality:
          type: integer
          oneOf:
            - $ref: '#/components/schemas/DateOfBirthDataQuality_list'
        AmIndAkNative:
          type: integer
          oneOf:
            - $ref: '#/components/schemas/NoYes_list'
        Asian:
          type: integer
          oneOf:
            - $ref: '#/components/schemas/NoYes_list'
        BlackAfAmerican:
          type: integer
          oneOf:
            - $ref: '#/components/schemas/NoYes_list'
        HispanicLatinaeo:
          type: integer
          oneOf:
            - $ref: '#/components/schemas/NoYes_list'
        MidEastNAfrican:
          type: integer
          oneOf:
            - $ref: '#/components/schemas/NoYes_list'
        NativeHiPacific:
          type: integer
          oneOf:
            - $ref: '#/components/schemas/NoYes_list'
        White:
          type: integer
          oneOf:
            - $ref: '#/components/schemas/NoYes_list'
        RaceNone:
          type: integer
          description: non-null only if all other race fields are 0 (UNKNOWN)
          oneOf:
            - $ref: '#/components/schemas/RaceGenderNone_list'
        AdditionalRaceEthnicity:
          type: string
          maxLength: 100
        Woman:
          type: integer
          oneOf:
            - $ref: '#/components/schemas/NoYes_list'
        Man:
          type: integer
          oneOf:
            - $ref: '#/components/schemas/NoYes_list'
        NonBinary:
          type: integer
          oneOf:
            - $ref: '#/components/schemas/NoYes_list'
        CulturallySpecific:
          type: integer
          oneOf:
            - $ref: '#/components/schemas/NoYes_list'
        Transgender:
          type: integer
          oneOf:
            - $ref: '#/components/schemas/NoYes_list'
        Questioning:
          type: integer
          oneOf:
            - $ref: '#/components/schemas/NoYes_list'
        DifferentIdentity:
          type: integer
          oneOf:
            - $ref: '#/components/schemas/NoYes_list'
        GenderNone:
          type: integer
          description: Non-null only if all other gender fields = 0
          oneOf:
            - $ref: '#/components/schemas/RaceGenderNone_list'
        DifferentIdentityText:
          type: string
          maxLength: 100
        VeteranStatus:
          type: integer
          oneOf:
            - $ref: '#/components/schemas/NoYesReasonsForMissingData_list'
        YearEnteredService:
          type: string
          pattern: '^(19[2-8][0-9]|199[0-9]|20[01][0-9]|202[0-4])$'
        YearSeparated:
          type: string
          pattern: '^(19[2-8][0-9]|199[0-9]|20[01][0-9]|202[0-4])$'
        WorldWarII:
          type: integer
          oneOf:
            - $ref: '#/components/schemas/NoYesReasonsForMissingData_list'
        KoreanWar:
          type: integer
          oneOf:
            - $ref: '#/components/schemas/NoYesReasonsForMissingData_list'
        VietnamWar:
          type: integer
          oneOf:
            - $ref: '#/components/schemas/NoYesReasonsForMissingData_list'
        DesertStorm:
          type: integer
          oneOf:
            - $ref: '#/components/schemas/NoYesReasonsForMissingData_list'
        AfghanistanOEF:
          type: integer
          oneOf:
            - $ref: '#/components/schemas/NoYesReasonsForMissingData_list'
        IraqOIF:
          type: integer
          oneOf:
            - $ref: '#/components/schemas/NoYesReasonsForMissingData_list'
        IraqOND:
          type: integer
          oneOf:
            - $ref: '#/components/schemas/NoYesReasonsForMissingData_list'
        OtherTheater:
          type: integer
          oneOf:
            - $ref: '#/components/schemas/NoYesReasonsForMissingData_list'
        MilitaryBranch:
          type: integer
          oneOf:
            - $ref: '#/components/schemas/MilitaryBranch_list'
        DischargeStatus:
          type: integer
          oneOf:
            - $ref: '#/components/schemas/DischargeStatus_list'
    Client:
      allOf: 
        -  $ref: '#/components/schemas/ClientBase'
        -  type: object
      properties:
        PersonalID:
          type: string
          description: Unique identifier for the client
          maxLength: 32
        UserId:
          type: string
          maxLength: 32
        DateCreated:
          type: string
          format: date-time
        DateUpdated:
          type: string
          format: date-time
        DateDeleted:
          type: string
          format: date-time
  
    ClientSummaryQuery:
      description: |
        This structure is used to query or return a subset of client fields. 
        For queries, the PersonalID field is not required but is returned in ClientSummaryResponses
      type: object
      properties:
        FirstName:
          type: string
          description: First name of the client (for Query optional and may be a prefix partial)
          maxLength: 50
        LastName:
          type: string
          description: Last name of the client (for Query optional and may be a prefix partial)
          maxLength: 50
        NameSuffix:
          type: string
          description: Suffix of the client's name (for Query optional and may be a prefix partial)
          maxLength: 50
        DateOfBirth:
          type: string
          format: date
          description: Optional date of birth of client. A date in ISO 8601 format. The year month + day is optional.
        SocialSecurityNumber:
          type: string
          description: Social Security Number, should be formatted as 4 characters representing the last 4 digit
          pattern: '^[0-9]{4}$'

    ClientSummary:
      allOf: 
        -  $ref: '#/components/schemas/ClientSummaryQuery'
        -  type: object
      properties:
        PersonalID:
          type: string
          description: Unique identifier for the client
          maxLength: 32

    ClientSummaryResponse:
      type: object
      properties: 
        query:
          type: object
        result:
          type: array
          items: 
            $ref: "#/components/schemas/ClientSummary"
            required: 
              - PersonalID  
        total:
          type: integer

```
