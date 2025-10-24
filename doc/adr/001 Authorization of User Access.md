# Authorization of the user to access the data

```json
{
  "@context": "HMIS-Logic-Model/001. Upcoming Versions/FY26HMIS_JSON-LD_v1.jsonld at main · HUD-Data-Lab/HMIS-Logi…"
  "@type": "AuthorizationError",
  "@id": "_:error-12345",
  "status": 403,
  "code": "INVALID_ROI",
  "message": "Access denied: No valid ROI covers requested data",
  "timestamp": "2025-10-21T14:30:00Z",
  "affectedResource": {
    "@type": "Client",
    "@id": "http://hmis.example.org/clients/456",
    "personalID": "456"
  },
  "requestingOrganization": {
    "@type": "Organization",
    "@id": "http://hmis.example.org/organizations/org-123",
    "organizationID": "org-123"
  },
  "owningOrganization": {
    "@type": "Organization",
    "@id": "http://hmis.example.org/organizations/org-789",
    "organizationID": "org-789"
  },
  "violatedRequirement": {
    "@type": "HUDRequirement",
    "requirementType": "ROI_VALIDATION",
    "description": "Cross-organization data sharing requires valid ROI",
    "citation": {
      "@type": "Citation",
      "document": "2004 HMIS Technical Standards",
      "section": "4.2",
      "url": "2004 HMIS Data and Technical Standards Final Notice (July 2004) - HUD Exchange" 
    }
  },
  "failureReason": "No active ROI exists for cross-organization data sharing"
  "actionableSteps": [   "Verify client has signed ROI authorizing data sharing",   "Check ROI effective dates cover requested period" ]
}
```
How does this schema address the following?
- User doesn't have authorization to access the API
- User doesn't have authorization to see a client
- User doesn't have authorization to see some of the client's enrollments

When do we need to tell a user that they don't have authorization and when do we just send filtered data?
