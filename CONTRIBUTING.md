# HMIS API Specification Contribution Guide

HMIS API is an evolving specification (spec). This repository contains the 
(latest specification)[#hmis-openapi-spec.yml], Issues containing 
RFCs (Request For Comments) on how to improve the specification, and Pull Requests 
to implement those RFCs.

Contributions that do not change the interpretation of the spec but instead
improve legibility, fix editorial errors, clear up ambiguity and improve
examples are encouraged and are often merged by a spec editor with little
process.

Contributions that _do_ meaningfully change the interpretation of the
spec must follow an RFC process led by a _champion_
through a series of _stages_ intended to improve _visibility_, allow for
_discussion_ to reach the best solution, and arrive at _consensus_. This process
becomes ever more important as the scope of this specification broadens.

When proposing or weighing-in on any issue or pull request, consider the
[Code of Conduct](#CODE-OF-CONDUCT.md) as a guideline for how to do so
while maintaining a productive environment.

## Contributing to the API Specification

A common point of confusion for those who wish to contribute to the HMIS API is where
to start. You may have found yourself here after attempting to make an
improvement to an HMIS API client library. Should a new addition be made to the HMIS API
specification first or an HMIS API client library first? Admittedly, this can become a bit of a
[chicken-or-egg](https://en.wikipedia.org/wiki/Chicken_or_the_egg) dilemma.

HMIS API libraries must be "spec compliant", which means they discourage
changes that cause them to behave differently from the specification as written. 
Pull requests for changes that accompany an RFC _proposal_ or RFC _draft_ are 
encouraged. Those requests cannot be part of a library's stable release until the 
underlying RFC is _released_.

To allow a library to remain spec compliant while also implementing _proposals_
and _drafts_, the library's maintainers may request that these new features are
disabled by default with opt-in option flags or they may simply wait to merge a
well-tested pull request until the RFC is _released_.

## Guiding Principles

HMIS API's evolution is guided by a few principles. Suggested contributions
should use these principles to guide the details of an RFC and decisions to move
forward.

- **User driven**
  The HMIS API specification and its libraries are built for the purpose of reducing 
  homelessness. Future changes to the API specification must be evaluated under this 
  lense first and with the greatest weight.

- **Backwards compatibility**

  HMIS API libraries should strive to maintain the structure and meaning of existing
  resources. Future changes should avoid incompatability with the existing
  resources and should avoid breaking changes across prior verions of this 
  specification. When breaking changes are required they should be clearly tied to
  the guiding principles here and follow the guidelines for 
  (schema evolution)[SCHEMA-EVOLUTION].

- **Favor no change**

  As the HMIS API is implemented under the collaboration of hundreds of individuals, 
  incorporating any change has a high cost. Proposed changes must meet a very high bar 
  of added value. The burden of proof is on the contributor to illustrate this value.

- **Enable new capabilities motivated by real use cases**

  Every change should intend on unlocking a real and reasonable use case. Real
  examples are always more compelling than theoretical ones, and common
  scenarios are more compelling than rare ones. RFCs should do more than offer a
  different way to reach an already achievable outcome.

- **Simplicity and consistency over expressiveness and terseness**

  There are many avenues for data exchange and interoperability between HMIS and
  other systems within and outside of Communities of Care. This specification seeks
  to enable a broad spectrum of those use cases in a way that can be applied across
  those use cases. "Possible but awkward" is often favored over more complex or 
  scenario-specific alternatives. Simplicity (e.g. fewer concepts) is more important 
  than expressing more sophisticated ideas or writing less.

- **Preserve option value**

  It's hard to know what the future brings; whenever possible, decisions should
  be made that allow for more options in the future. Sometimes this is
  unintuitive: specification rules often begin more strict than necessary with a 
  future option to loosen when motivated by a real use case.

- **Understandability is just as important as correctness**

  The HMIS API specification, despite describing technical behavior, is intended to be
  read by people. Use natural tone and include motivation and examples.

## RFC Contribution Champions

Contributing to the HMIS API specification requires a lot of dedicated work. To set clear
expectations and provide accountability, each proposed RFC (request for
comments) must have a _champion_ who is responsible for addressing feedback and
completing next steps. An RFC may have multiple _champions_. The specification 
maintainers are not responsible for completing RFCs which lack a _champion_ (though a
maintainer may be a _champion_ for an RFC).

An RFC which does not have a _champion_ may not progress through stages, and can
become stale. Stale proposals may be picked up by a new _champion_ or may be
_rejected_.

## RFC Contribution Stages

RFCs are guided by a _champion_ through a series of stages: _idea_,
_proposal_, _draft_, _accepted_, and _released_ (or _rejected_), each of which has
suggested entrance criteria and next steps detailed below. RFCs typically advance one
stage at a time, but may advance multiple stages at a time. Stage advancements
typically occur during [HUD OIG](https://www.hudoig.gov/) meetings, but may also occur 
here.

In general, it's preferable to start with a pull request so that we can best
evaluate the RFC in detail. However, starting with an issue is also permitted if
the full details are not worked out.

All RFCs start as either an _idea_ or a _proposal_.

## Stage 0: _Idea_

An RFC at the _idea_ stage captures a described problem or
partially-considered solutions. An _idea_ does not need to meet any entrance
criteria. An _idea's_ goal is to prove or disprove a problem and guide
discussion towards either rejection or a preferred solution. An _idea_ may be
an issue or a pull request (though an illustrative pull request is preferrable).

_There is no entrance criteria for an idea_

The guiding principle _favor no change_ encourages a _reject_ outcome by considering 
other possible related solutions, showing that the motivating problem can be solved 
with no change to the specification, or that it is not aligned with other 
_guiding principles_.

If the _idea_ is compelling, it should seek the entrance criteria for _proposal_.

## Stage 1: _Proposal_

An RFC at the _proposal_ stage is a solution to a problem with enough fidelity
to be discussed in detail. It must be backed by a willing _champion_. A
_proposal_'s goal is to make a compelling case for acceptance by describing both
the problem and the solution via examples and specification edits. A _proposal_ 
should be a pull request.

_Entrance criteria:_

- Identified _champion_
- Clear explanation of problem and solution
- Illustrative examples
- Incomplete specification edits
- Identification of potential concerns, challenges, and drawbacks

A _proposal_ is subject to the same discussion as an _idea_: ensuring that it
is well aligned with the _guiding principles_, is a problem worth solving, and
is the preferred solution to that problem. A _champion_ is not expected to have
confidence in every detail at this stage and should instead focus on identifying
and resolving issues and edge-cases. To better understand the technical
ramifications of the _proposal_, a _champion_ is encouraged to implement it in a
HMIS API library.

Most _proposals_ are expected to evolve or change and may be rejected.
Therefore, it is unwise to rely on a _proposal_ in a production HMIS service.
HMIS API libraries _may_ implement _proposals_, though are encouraged to not
enable the _proposed_ feature without explicit opt-in.

## Stage 2: _Draft_

An RFC at the _draft_ stage is a fully formed solution. There is consensus the 
problem identified should be solved, and this particular solution
is preferred. A _draft's_ goal is to precisely and completely describe the
solution and resolve any concerns through library implementations. A _draft_
must be a pull request.

_Entrance criteria:_

- RFC participant consensus is preferred
- Resolution of identified concerns and challenges
- Precisely described with spec edits
- Compliant implementation in HMIS API library (might not be merged)

A _proposal_ becomes a _draft_ when the set of problems or drawbacks have been
fully considered and accepted or resolved, and the solution is deemed desirable.
A _draft_'s goal is to complete final spec edits that are ready to be merged and
implement the _draft_ in HMIS libraries along with tests to gain confidence
that the specification text is sufficient.

_Drafts_ may continue to evolve and change, occasionally dramatically, and are
not guaranteed to be accepted. Therefore, it is unwise to rely on a _draft_ in a
production HMIS API Service. HMIS API libraries _should_ implement _drafts_ to
provide valuable feedback and they are encouraged not to enable the _draft_
feature without explicit opt-in when possible.

## Stage 3: _Accepted_

An RFC at the _accepted_ stage is a completed solution approved by the Department
of Housing and Urban Development (HUD OIG) (https://www.hudoig.gov/). It is ready to be 
merged as-is into the specification document. The RFC is ready to be deployed in 
HMIS API libraries. An _accepted_ RFC must be implemented as part of an upcoming
release in HMIS API libraries.

_Entrance criteria:_

- Consensus the solution is complete (via editor or working group)
- Complete specification edits, including examples and prose
- Compliant implementation in an HMIS API library (fully tested and merged or ready to
  merge)

A _draft_ is _accepted_ when HUD OIG or a maintainer has been convinced via
implementations and tests that it appropriately handles all edge cases; that the
specification changes not only precisely describe the new syntax and semantics but
include sufficient motivating prose and examples; and that the RFC includes
edits to any other affected areas of the spec. Once _accepted_, its _champion_
should encourage adoption of the RFC by opening issues or pull requests on other
HMIS API libraries.

An _accepted_ RFC is merged into the HMIS API specification's main branch by an 
maintainer and will be included in the next released revision.

## Stage 3: _Released_

An RFC at the _released_ stage when the Department of Housing and Urband Development 
(HUD OIG) (https://www.hudoig.gov/) has included it as part of a Data Standards release. 
HMIS API libraries that do not implement the RFC are considered out of compliance.

_Entrance criteria:_

- Included as part of a HUD Data Standards release

Once an RFC is _released_, its _champion_ should encourage adoption of the RFC by ensuring 
issues or pull requests on other HMIS API libraries are promptly merged. HMIS API libraries
out of compliance should not be used by HMIS.

A _released_ RFC is tagged in this repository by an maintainer via 
(Semantic Versioning)[https://semver.org].

## Stage X: _Rejected_

An RFC may be _rejected_ at any point and for any reason. Most rejections occur
when an _idea_ is proven to be unnecessary, is misaligned with the _guiding
principles_, or fails to meet the entrance criteria to become a _proposal_. A
_proposal_ may become _rejected_ for similar reasons as well as if it fails to
reach consensus or loses the confidence of its _champion_. Likewise a _draft_
may encounter unforeseen issues during implementations which cause it to lose
consensus or the confidence of its _champion_. _Accepted_ proposals are unlikely
to be _rejected_, though there may be significant lag before they are _released_.

RFCs which have lost a _champion_ will not be _rejected_ immediately, but may
become _rejected_ if they fail to attract a new _champion_.

Once _rejected_, an RFC will typically not be reconsidered. Reconsideration is
possible if a _champion_ believes the original reason for rejection no longer
applies due to new circumstances or new evidence.

## Attribution

These contribution guidelines have been adapted from the GraphQL Contributing specification, available at [https://github.com/graphql/graphql-spec/blob/main/CONTRIBUTING.md](https://github.com/graphql/graphql-spec/blob/main/CONTRIBUTING.md).