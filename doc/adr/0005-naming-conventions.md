# Naming conventions within the API Reference

- Status: [draft]
- Deciders: ICF
- Date: 2024-08-12

## Context and Problem Statement

Within the HUD CSV Specifications some of the fields/columns match the name of their lists. For the purpose of the API we have been following this naming convention:

- Use Pascal Case (i.e., FirstWordsSecondWords)
- All lists and options will end with a "_list"


# HMIS API Reference Schema naming convention

- [CSVTableName]PrimaryKey - The primary key associated with that CSV table. 
- [CSVTableName]Base - Core list of all information contained in a CSV Table for a record. This does not include the primary key, but will include any secondary/foreign keys. This schema would be the base schema used for updating and creating information. 
- [CSVTableName]BaseMetaData - Includes the set of metadata for each record.

[CSVTableName]PrimaryKey + [CSVTableName]Base + [CSVTableName]BaseMetadata = All the elements from the HMIS CSV Specifications except for exportID.

- [CSVTableName]SummaryInfo - Response based on uniqueID of other tables
- [CSVTableName]SummaryQuery - The request body to search for uniqueIDs
- [CSVTableName]SummaryResponse - A response based on the Query to identify potential uniqueIds that match query