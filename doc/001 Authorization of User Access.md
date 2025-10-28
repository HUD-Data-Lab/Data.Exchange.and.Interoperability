# Authorization of the user to access the data

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