# Mockoon Specifications for the Sandbox API

There will be 12 key baseline scenarios in this API mockup. These are:

1. Search for a client record by identifying information
2. Generate a new client record
3. Generate a list of all client records in a project
4. Update an existing client's record
5. Generate a list of enrollments related to a single client
6. Generate a list of projects being funded by HUD: CoC Rapid Re-Housing
7. Generate a list of projects with project type: Rapid Re-Housing
8. Generate a list of clients being funded by HUD: CoC Rapid Re-Housing
9. Generate a list of clients who are active in project type Rapid Re-Housing
10. Set up a client “watch” for specific changes to their record
11. Determine a person’s services (historical and ongoing)
12. Authentication

## 1. Search for a client record by identifying information

### Request
Use any of the following to make the request:
- PersonalID
- First name
- Last name
- Date of Birth
- Social Security Number

The format of these should match the HUD data standards, each field is allowed to be null and partial matches are allowed. 

### Response

Use the following response HTTP codes:
- 200: Return a list of potential matches. Data fields to return include: PersonalID, FirstName, LastName, Date of Birth, Social Security number.
- 404: Return the message "Client not found".

## 2. Generate a new client record

### Request

Use any of the following items from [clientBase] to create the client record.

### Response

Use the following response HTTP codes:
- 200: Return a full list of all the client's data (clientPrimaryKey, ClientBase, and clientMetaData)
- 400: If an incorrect data type or missing information that would stop this record from being created return the message, "Invalid input provided".

## 3. Generate a list of all client records in a project

### Request
Use the following to make the request:
- ProjectID
A user should be able to request data from one or multiple ProjectIDs.

### Response
Use the following response HTTP codes:
- 200: Return a list of clients and any unmatched ProjectIDs. For matched clients return clientsBase. For unmatched Project Ids return ProjectID
- 404: If there was no matching IDs then return the list of requested ProjectIDs

## 4. Update an existing client's record

### Request
In the request the PersonalID should be in the PATH (e.g., /client/{PersonalID}:) We want to be able to search using the PersonalID, but not allow the user to change it. These are the fields that can be updated in the request (any of them can be NULL for this endpoint)

``` yaml
    clientBase:
      type: object
      properties: 
        FirstName:
          type: string
          description: First name of the client
          maxLength: 50
        MiddleName:
          type: string
          description: Middle name of the client
          maxLength: 50
        LastName:
          type: string
          description: Last name of the client
          maxLength: 50
        NameSuffix:
          type: string
          description: Suffix of the client's name
          maxLength: 50
        NameDataQuality:
          type: integer
          oneOf:
            - $ref: '#/components/schemas/NameDataQuality_list' 
        SSN:
          type: string
          description: Social Security Number
          pattern: '^[0-9]{9}$'
        SSNDataQuality:
          type: integer
          oneOf:
            - $ref: '#/components/schemas/SSNDataQuality_list'
        DOB:
          type: string
          description: Date of birth of the client
          format: date
        DOBDataQuality:
          type: integer
          oneOf:
            - $ref: '#/components/schemas/DOBDataQuality_list'
        AmIndAKNative:
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
        NativeHIPacific:
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

# Response Lists

    NameDataQuality_list:
      type: integer
      enum: [1, 2, 8, 9, 99]
      description: |
        1 - Full name reported
        2 - Partial, street name, or code name reported
        8 - Client doesn't know
        9 - Client prefers not to answer
        99 - Data not collected
    SSNDataQuality_list:
      type: integer
      enum: [1, 2, 8, 9, 99]
      description: |
        1 - Full SSN Reported
        2 - Approximate or partial SSN reported
        8 - Client doesn't know
        9 - Client prefers not to answer
        99 - Data not collected
    DOBDataQuality_list:
      type: integer
      enum: [1, 2, 8, 9, 99]
      description: |
        1 - Full DOB reported
        2 - Approximate or partial DOB reported
        8 - Client doesn't know
        9 - Client prefers not to answer
        99 - Data not collected
    NoYes_list:
      type: integer
      enum: [0, 1]
      description: |
        0 - No
        1 - Yes
    RaceGenderNone_list:
      type: integer
      enum: [8,9,99]
      description: |
        8 - Client doesn't know
        9 - Client prefers not to answer
        99 - Data not collected
    NoYesReasonsForMissingData_list:
      type: integer
      enum: [0, 1, 8, 9, 99]
      description: |
        0 - No
        1 - Yes
        8 - Client doesn't know
        9 - Client prefers not to answer
        99 - Data not collected
    MilitaryBranch_list:
      type: integer
      enum: [1, 2, 3, 4, 6, 7, 8, 9, 99]
      description: |
        1 - Army
        2 - Air Force
        3 - Navy
        4 - Marines
        6 - Coast Guard
        7 - Space Force
        8 - Client doesn't know
        9 - Client prefers not to answer
        99 - Data not collected
    DischargeStatus_list:
      type: integer
      enum: [1, 2, 4, 5, 6, 7, 8, 9, 99]
      description: |
        1 - Honorable
        2 - General under honorable conditions
        4 - Bad conduct
        5 - Dishonorable
        6 - Under other than honorable conditions (OTH)
        7 - Uncharacterized
        8 - Client doesn't know
        9 - Client prefers not to answer
        99 - Data not collected
```

### Response
Use the following response HTTP codes:
- 200: Return PersonalID and the rest of the client records. See schema below.
- 404: If there was no matching PersonalIDs then return the message "PersonalID is not found"
- 400: If an incorrect data type or missing information that would stop this record from being created return the message, "Invalid input provided".

``` yaml
   clientPrimaryKey:
      type: object
      properties:
        PersonalID:
          type: string
          description: Unique identifier for the client
          maxLength: 32
    clientBase:
      type: object
      properties: 
        FirstName:
          type: string
          description: First name of the client
          maxLength: 50
        MiddleName:
          type: string
          description: Middle name of the client
          maxLength: 50
        LastName:
          type: string
          description: Last name of the client
          maxLength: 50
        NameSuffix:
          type: string
          description: Suffix of the client's name
          maxLength: 50
        NameDataQuality:
          type: integer
          oneOf:
            - $ref: '#/components/schemas/NameDataQuality_list' 
        SSN:
          type: string
          description: Social Security Number
          pattern: '^[0-9]{9}$'
        SSNDataQuality:
          type: integer
          oneOf:
            - $ref: '#/components/schemas/SSNDataQuality_list'
        DOB:
          type: string
          description: Date of birth of the client
          format: date
        DOBDataQuality:
          type: integer
          oneOf:
            - $ref: '#/components/schemas/DOBDataQuality_list'
        AmIndAKNative:
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
        NativeHIPacific:
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
    clientMetaData:
      type: object
      properties:
        DateCreated:
          type: string
          format: date-time
        DateUpdated:
          type: string
          format: date-time
        UserID:
          type: string
          maxLength: 32
        DateDeleted:
          type: string
          format: date-time

# Response Lists

    NameDataQuality_list:
      type: integer
      enum: [1, 2, 8, 9, 99]
      description: |
        1 - Full name reported
        2 - Partial, street name, or code name reported
        8 - Client doesn't know
        9 - Client prefers not to answer
        99 - Data not collected
    SSNDataQuality_list:
      type: integer
      enum: [1, 2, 8, 9, 99]
      description: |
        1 - Full SSN Reported
        2 - Approximate or partial SSN reported
        8 - Client doesn't know
        9 - Client prefers not to answer
        99 - Data not collected
    DOBDataQuality_list:
      type: integer
      enum: [1, 2, 8, 9, 99]
      description: |
        1 - Full DOB reported
        2 - Approximate or partial DOB reported
        8 - Client doesn't know
        9 - Client prefers not to answer
        99 - Data not collected
    NoYes_list:
      type: integer
      enum: [0, 1]
      description: |
        0 - No
        1 - Yes
    RaceGenderNone_list:
      type: integer
      enum: [8,9,99]
      description: |
        8 - Client doesn't know
        9 - Client prefers not to answer
        99 - Data not collected
    NoYesReasonsForMissingData_list:
      type: integer
      enum: [0, 1, 8, 9, 99]
      description: |
        0 - No
        1 - Yes
        8 - Client doesn't know
        9 - Client prefers not to answer
        99 - Data not collected
    MilitaryBranch_list:
      type: integer
      enum: [1, 2, 3, 4, 6, 7, 8, 9, 99]
      description: |
        1 - Army
        2 - Air Force
        3 - Navy
        4 - Marines
        6 - Coast Guard
        7 - Space Force
        8 - Client doesn't know
        9 - Client prefers not to answer
        99 - Data not collected
    DischargeStatus_list:
      type: integer
      enum: [1, 2, 4, 5, 6, 7, 8, 9, 99]
      description: |
        1 - Honorable
        2 - General under honorable conditions
        4 - Bad conduct
        5 - Dishonorable
        6 - Under other than honorable conditions (OTH)
        7 - Uncharacterized
        8 - Client doesn't know
        9 - Client prefers not to answer
        99 - Data not collected

```

## 5. Generate a list of enrollments related to a single client
In the request is the PersonalID should be in the PATH (e.g., /enrollmentsSummary
onalID}:) with the option to filter by ProviderID or Enrollment Start and End Date. These can be null if you just want to have all the enrollments from a client. 
The request should include the following fields:

``` yaml
       
       ProjectID:
          type: string
          maxLength: 32
        EntryDate:
          type: string
          format: date
        ExitDate:
          type: string
          format: date
```