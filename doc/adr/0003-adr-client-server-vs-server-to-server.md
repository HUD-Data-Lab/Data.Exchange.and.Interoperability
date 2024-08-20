# Discussion client-to-server vs. server-to-server approach

- Status: draft
- Deciders: ICF, USDS, HUD
- Date udpdated: 2024-08-12
- Tags: api


## Context and Problem Statement

For the HUD HMIS API the intitial focus is transactional data exchange between an HMIS and a third part system (i.e., seperate case managmenet software, health systems, and 211 call center) to improve frontline staffs data collection efforts and reduce the number of times a person experiencing homelessness needs to re-share their sensitive information and personal story. 

Our process:
1. Client to Server
2. 1 to 1 mapping from the HUD CSV Specifications
3. Server to Server
4. Bulk data transfer
5. FHIR and HUD Mapping/implementation

## Decision Drivers <!-- optional -->

- HUD is defining the minimum requirements for the API through the intial version of the API reference.
- Many HMIS vendors are in different places with API implementation.

## Considered Options

- [option 1] Start with a Client to Server API with several milestones with the ultimate goal of being able to have HUD HMIS API be compatible with FHIR.
- [option 2]
- [option 3]

## Decision Outcome

Chosen option: "[option 1]",  

### Positive Consequences <!-- optional -->

- [e.g., improvement of quality attribute satisfaction, follow-up decisions required, …]
- …

### Negative Consequences <!-- optional -->

- [e.g., compromising quality attribute, follow-up decisions required, …]
- …

## Pros and Cons of the Options <!-- optional -->

### [option 1]

[example | description | pointer to more information | …] <!-- optional -->

- Good, because [argument a]
- Good, because [argument b]
- Bad, because [argument c]
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
