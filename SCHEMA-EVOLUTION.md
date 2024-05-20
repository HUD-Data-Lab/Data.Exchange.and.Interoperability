# Schema Evolution Guidelines

Schema evolution involves making changes to a schema while maintaining compatibility 
and ensuring smooth transitions. [Semantic versioning](https://www.semver.org) will be
used to manage versions of this document as it is an established framework for signaling 
the expected affect of a change across each version. This document outlines best practices 
for evolving schemas using this framework, categorized by the types of changes and their 
expected impact. 

## Patch Changes
Patch changes are minor modifications that do not impact the existing functionality or 
structure. These changes must be backward compatible and typically involve quality of 
life improvements or fixes.

- Grammar corrections
- Spelling corrections
- Minor clarification of documentation
- Typographical corrections
- Adding or updating examples in documentation
- Fixing broken links in documentation
- Minor formatting changes in documentation
- Clarifications that do not change the meaning or utility of a field or resource

## Minor Changes
Minor changes introduce new, optional functionalities or expand existing ones without 
breaking existing implementations. These changes must be backward compatible.

- Expanding the definition of a field (note: this does not include adding additional value types)
- Adding new optional endpoints, resources, or fields
- Clarifying and expanding existing functionalities in documentation
- Introducing non-breaking constraints (e.g., setting a maximum length for a string without affecting existing data)
- Providing additional metadata or auxiliary information

## Major Changes
Major changes introduce significant modifications that may impact existing implementations. 
These changes can be backward incompatible and typically require careful consideration and planning.

- Adding required fields
- Expanding existing field utilities
- Renaming endpoints, resources, fields
- Changing field types (e.g., from string to integer)
- Removing endpoints, resources, or fields
- Introducing new mandatory constraints (e.g., changing a field to a non-nullable type)
- Changing the structure of the response objects
- Any changes that require clients to update their implementations to avoid breaking

## Best Practices for Schema Evolution

### Versioning
- Use semantic versioning to signal the potential impact of changes:
  - **Patch Version (X.Y.Z)**: Patch changes that are backward compatible.
  - **Minor Version (X.Y)**: Minor changes that are backward compatible.
  - **Major Version (X)**: Major changes that may introduce breaking changes.

### Deprecation Strategy
- Avoid breaking or backward incompatible changes if possible. Always consider expanding a field's utility or adding a new field/object over deleting or other breaking changes.
- If breaking changes are needed, save them for a major version bump.
- Allow for deprecation windows (e.g., "this field will be deprecated in future versions").
- Provide a similar window for "this should be supported" periods to give clients time to transition.

### Communication
- Changes, especially breaking changes, will be clearly communicated to all stakeholders. The change management
  process (see (CONTRIBUTING)[#CONTRIBUTING.md]) will provide a transparent timeline for changes to the API.
- Provide detailed migration guides and examples for major changes.
- Announce deprecations well in advance and provide alternatives.

### Documentation
- Keep documentation up to date with every change.
- Provide clear, concise, and comprehensive documentation for new fields, resources, endpoints, and functionalities.
- Include examples and use cases for new features to aid in the understanding and implemention of changes.

### Testing
- Ensure thorough testing of changes, especially major changes, to identify potential issues early.
- Encourage clients to implement changes in test environments before rolling out to production.