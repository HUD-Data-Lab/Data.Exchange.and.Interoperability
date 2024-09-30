# Naming conventions within the API Refernece

- Status: [draft]
- Deciders: ICF
- Date: 2024-08-12

## Context and Problem Statement

Within the HUD CSV Specifications some of the fields/columns match the name of their lists. For the prupose of the API we have been following this naming convention:

- Use Pascal Case (i.e., FirstWordsSecondWords)
- All lists and options will end with a "_list"


# HMIS API Reference Schema naming convention

- [CSVTableName]Base - Core list of all information contained in a CSV Table for a record. This does not include the uniqueID(s). This schema would be the base schema used for updating and creating information. 
- [CSVTableName]BaseAdditional - Additional list of data elements. This would include any of the uniqueID(s) associated with the record or needed to connect this record to other CSV tables. It is expected that this schema would generally be items the user woudl be unable to create or change (i.e., a PersonalID or EnrollmentID). 

[CSVTableName]Base = [CSVTableName]BaseAdditional = All the elements from the HMIS CSV Specifications except for exportID.

- [CSVTableName]BaseUpdate - All fields an end user is able to update via patch. This is referenced in the RequestBody
- [CSVTableName]BaseRequestBody - Fields to assist RequestBody

- [CSVTableName]SummaryInfo - Response based on uniqueID of other tables

- [CSVTableName]SummaryQuery - The request body to search for uniqueIDs
- [CSVTableName]SummaryResponse - A response based on the Query to identify potential uniqueIds that match query