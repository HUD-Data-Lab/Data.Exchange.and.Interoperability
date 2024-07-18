# [short title of solved problem and solution]

- Status: proposed
- Deciders: ICF, HUD, USDS
- Date Updated: July 16, 2024 
- Tags: API, HUD

Technical Story: [description | ticket/issue URL] <!-- optional -->

## Context and Problem Statement

The goal is machine-to-machine communications of data. There are a growing list of technical approaches available.
This ADR discusses many of pro/cons of the various options.

Why use a REST API over other options like GraphQL or FHIR?

## Decision Drivers <!-- optional -->

### Primary goals:
- Easy to adopt. 
- Easy to document.
- Secure
- Support for future enhancements
- Easy to map existing CSV specification/requirements into it

### Factors to consider:
- Type of application: Public APIs, internal APIs, mobile apps, healthcare systems.
- Data complexity: Simple data structures vs. complex nested objects.
- Performance requirements: Need for speed and efficiency.
- Developer familiarity: Choose a style your team is comfortable with.

## Considered Options

- REST API
- GraphQL
- FHIR/HL7
- SOAP
- gRPC

## Decision Outcome

Chosen option: "REST API", because [justification. e.g., only option, which meets k.o. criterion decision driver | which resolves force force | … | comes out best (see below)].

### Positive Consequences <!-- optional -->

- [e.g., improvement of quality attribute satisfaction, follow-up decisions required, …]
- …

### Negative Consequences <!-- optional -->

- [e.g., compromising quality attribute, follow-up decisions required, …]
- …

## Pros and Cons of the Options <!-- optional -->

### REST API
REST is the most widely used style due to its simplicity and flexibility.

Uses standard HTTP protocol with URIs for requests and JSON for responses.

See: https://en.wikipedia.org/wiki/REST

Common use Cases: Internal APIs, enterprise integrations, financial transactions

- Good, because simple, widely adopted, flexible. Good for public APIs.
- Good, because lots of support libraries for various dev environments
- Good, because security is well understood. Lots of existing products already support.
- Good, because it's stateless.
- Good, because it can migrated to FHIR using something like [SMART](https://docs.smarthealthit.org/).
- Bad, because it can be chatty (multiple requests for complex data), not ideal for complex data structures.
- Bad, an architecture not a standard, so lots of different opinions on the best way to do the same thing.


### GraphQL
GraphQL is gaining popularity for its efficiency in complex data retrieval scenarios.

Client specifies exact data needs through a query language. Efficient for fetching complex data structures allowing developers to specify the exact data they need via a rich query language.
Uses standard HTTP protocol with URIs for requests and JSON for responses.

See: https://spec.graphql.org/October2021/

Common use cases: Mobile apps, single-page applications, complex data relationships.

- Good, because efficient data fetching, reduces over-fetching.
- Good, because good for complex user interfaces (e.g. websites).
- Bad, because learning curve for query language, potential performance overhead for simple queries.
- Bad, because more complex query features, it can be harder to correctly enforce access permissions.

### FHIR
HL7 and FHIR are specific to healthcare data exchange and interoperability. FHIR is the newer, more modern standard.

HL7 is not very human readable, but FHIR improves when used with JSON responses.

See: https://www.hl7.org/fhir/http.html

Common use cases: Sharing electronic health records, healthcare information exchange.

- Good, because specific to healthcare data exchange, focuses on standardized resources and interactions. Could argue HUD data is similar to healthcare data
- Good, because standardized for healthcare data exchange, simplifies interoperability between healthcare systems.
- Good, uses standardized resources and formats (standardized for healthcare).
- Good, rapidly being adopted because closer to REST.
- Bad, because limited use case outside healthcare.
- Bad, because requires mapping the existing complex CSV types into FHIR.
- Bad, supports multiple response types (XML, JSON, RDF), so more complex. Subset of JSON-only might be acceptable?

### gRPC
gRPC is ideal for high-performance internal APIs within microservices architectures.

Makes remote function calls appear like local calls. Focuses on functionality over data modeling.

Common use cases: Internal microservices communication, high-performance data transfers.

- Good, because of it's high performance, efficient for internal communication (microservices)
- Good, because flexible encoding (JSON, Protocol Buffers).
- Bad, because flexible encoding means trickier to standardize.
- Bad, because tightly coupled, less flexible than REST, not ideal for public APIs.


### SOAP
SOAP is still used for enterprise applications but can be considered legacy compared to REST.

Exposes procedures (functions) as central concepts. More structured than REST. Primarily XML, more verbose than JSON.

Common use cases: Internal APIs, enterprise integrations, financial transactions.

- Good, because mature, good for enterprise applications
- Good, because robust security features
- Bad, because Complex, verbose, less flexible than REST

## Links <!-- optional -->

- [Link type](link to adr) <!-- example: Refined by [xxx](yyyymmdd-xxx.md) -->
- … <!-- numbers of links can vary -->


**Design Philosophy/Pattern:**
- REST (Representational State Transfer): Focuses on resources accessed through HTTP verbs (GET, POST, PUT, DELETE). Simple and widely used for web APIs.
- GraphQL: Query language allowing clients to request specific data from the server, efficient for complex data retrieval.
- FHIR (Fast Healthcare Interoperability Resources): Specifically designed for healthcare data exchange, uses a standardized resource model.
- RPC (Remote Procedure Call): Direct invocation of functions on a remote server. Simple but less flexible for data modeling.
- SOAP (Simple Object Access Protocol): Based on Remote Procedure Calls (RPC), exposes procedures as functionalities. More standardized and complex.

**Communication Protocol:**
- REST: Primarily uses HTTP/1.1, but can also use HTTP/2.
- GraphQL: Often uses HTTP/1.1, but can leverage other protocols like WebSockets for real-time updates.
- FHIR: Primarily uses HTTP/1.1 with specific message headers.
- RPC: Varies, can use HTTP, TCP, or custom protocols.
- SOAP: Relies on HTTP for transport, but defines its own messaging format using XML.

**Data Encoding:**
- REST: Commonly uses JSON or XML for human-readable data exchange.
- GraphQL: Employs JSON for responses, but the underlying data format can vary.
- FHIR: Utilizes JSON or XML for resource representation.
- RPC: Can use various formats like JSON, XML, or Protocol Buffers (gRPC).
- SOAP: Exclusively uses XML for messages.
