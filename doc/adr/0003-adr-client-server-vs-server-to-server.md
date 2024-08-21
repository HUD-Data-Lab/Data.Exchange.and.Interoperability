# Discussion client-to-server vs. server-to-server approach

- Status: draft
- Deciders: ICF, USDS, HUD
- Date updated: 2024-08-12
- Tags: api


## Context and Problem Statement

For the HUD HMIS API, the initial focus is transactional data exchange between an HMIS and a third part system (i.e., separate case management software, health systems, and 211 call center) to improve frontline staff's data collection efforts and reduce the number of times a person experiencing homelessness needs to re-share their sensitive information and personal story.

Our process:
- Early Iterations
  - Client to Server
  - 1 to 1 mapping from the HUD CSV Specifications
- Future Iterations
  - Server to Server
  - Bulk data transfer
  - FHIR and HUD Mapping/implementation

## Decision Drivers <!-- optional -->

- HUD is defining the minimum requirements for the API through the initial version of the API reference.
- Many HMIS vendors are in different places with API implementation.
- Focusing on the most impactful initial step(s) to full HMIS API functionality.

## Considered Options

- [option 1] Establish a reference for Client to Server API designed around HUD CSV specs with Server to Server functionality and FHIR integration as future goals
- [option 2] Establish a reference for Server to Server API designed around HUD CSV specs with FHIR integration as a future goal
- [option 3] Establish a reference for Client to Server API designed around FHIR with Server to Server functionality as a future goal
- [option 4] Establish a reference for Server to Server API designed around FHIR

## Decision Outcome

Chosen option: "[option 1]",  

### Positive Consequences <!-- optional -->

-
- [e.g., improvement of quality attribute satisfaction, follow-up decisions required, …]
- …

### Negative Consequences <!-- optional -->

- 
- Requires user interaction on the client side
- [e.g., compromising quality attribute, follow-up decisions required, …]
- …

## Pros and Cons of the Options <!-- optional -->

### [option 1]

[example | description | pointer to more information | …] <!-- optional -->

- Good, because [argument a]
- Good, because [argument b]
- Bad, because does not establish process for bulk data import/export via API
- … <!-- numbers of pros and cons can vary -->

### [option 2]

[example | description | pointer to more information | …] <!-- optional -->

- Good, because [argument a]
- Good, because [argument b]
- Bad, because [argument c]
- … <!-- numbers of pros and cons can vary -->

### [option 3]

[example | description | pointer to more information | …] <!-- optional -->

- Good, because [argument a]
- Good, because [argument b]
- Bad, because [argument c]
- … <!-- numbers of pros and cons can vary -->

## Links <!-- optional -->

- [Link type](link to adr) <!-- example: Refined by [xxx](yyyymmdd-xxx.md) -->
- … <!-- numbers of links can vary -->
