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