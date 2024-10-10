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

- Start with a Client to Server API
- Start with a Server to Server API

## Decision Outcome

Chosen option: "Start with a Client to Server API"

### Positive Consequences <!-- optional -->

- Allows real-time access to data and allows client applications to retrieve and display up-to-date information
- Allows for end-user interaction with the process, specifically record matching

### Negative Consequences <!-- optional -->

- This specific approach it is not intended for bulk data import/export

## Pros and Cons of the Options <!-- optional -->

### Start with a Client to Server API

This option would allow an external system to connect to HMIS and provide users of that external system with the ability to interact with HMIS data. <!-- optional -->

- Good, because Client to Server APIs enable real-time access to data, allowing client applications to retrieve and display up-to-date information, which is crucial for decision-making and user experience.
- Good, because Client to Server APIs streamline data exchange processes and enhance overall efficiency.
- Good, because Client to Server APIs provide the flexibility to customize interactions and data exchanges to meet specific business needs and user requirements.
- Good, because it allows for end-user interaction with the process, specifically record matching, though record-matching could also be part of a server-to-server workflow.
- Bad, because this specific approach it is not intended for bulk data import/export

### Start with a Server to Server API

This option would allow an external system to connect to HMIS and transfer data without end-user interaction. <!-- optional -->

- Good, because Server-to-Server APIs often use strong authentication methods and encrypted communication channels, ensuring data is securely transmitted between servers.
- Good, because direct server-to-server communication reduces latency and speeds up data transfer, leading to faster response times and overall improved performance.
- Good, because they enable automated workflows and processes, reducing the need for manual intervention and minimizing the potential for human error.
- Good, because they allow for centralized management of services and data, simplifying administration and oversight.
- Bad, because they do not enable end-user intervention in the record matching process.

## Links <!-- optional -->

- [Link type](link to adr) <!-- example: Refined by [xxx](yyyymmdd-xxx.md) -->
- … <!-- numbers of links can vary -->
