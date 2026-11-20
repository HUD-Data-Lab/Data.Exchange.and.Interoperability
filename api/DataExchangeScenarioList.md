# Data exchange scenario list

The eight FY2026 baseline data exchange scenarios, and the HMIS data elements
each one uses in its request and its response. The OpenAPI description in
[hmis-api.openapi.yaml](hmis-api.openapi.yaml) defines the same scenarios.

This file replaces `DataExchangeScenarioList.xlsx`. Its two sections are that
workbook's two sheets, `Scenario` and `ScenarioMapping`, with the same columns
in the same order. Since the conversion, the three C4 Translation Assistance
Needed rows, which the FY2026 standards removed, have been deleted, and three
names in **dataExchangeOntologyName** have been updated to match the FY26
ontology.

## Scenarios

One row per scenario. `ScenarioName` is the prefix of that scenario's
`Request` and `Response` columns in the mapping below.

| ScenarioName | Method | Label | Summary |
| --- | --- | --- | --- |
| ClientSearch | Get | Search for Client | Search for clients by identifying information or PersonalID |
| NewClient | Post | Create Client | Create a new client record |
| UpdateClient | Patch | Update Client | Update an existing client record |
| ClientSearchProject | Get | Clients in a Project | Get all clients associated with a specific project |
| ClientEnrollments | Get | Retrieve Client Enrollments | Get all enrollments for a specific client |
| ProjectSearchTypeFunder | Get | Search Projects | Get projects by funder and project type |
| ClientSearchProjectTypeFunder | Get | Search Clients by Project Type or Funder Type | Get clients enrolled in projects filtered by funder and project type |
| ClientAllData | Get | Client Full HMIS Record | Comprehensive return of all a person's services and information |

## Scenario mapping

One row per HMIS data element field:

- **Class** is the class the field belonged to in the earlier data exchange ontology.
- **CSVTable** is the HMIS CSV export file it comes from.
- **DE#** is the data element and field number, made of **DataElement** and **FieldNumber**.
- **Name** is the field's name.
- **dataExchangeOntologyName** is the field's property in the FY26 HMIS Logic Model (`FY26_HMIS_Logic_Model.ttl`). It is the same as **Name** except for `StartDate`, `EndDate` and `Event`, whose properties are `GrantStartDate`, `GrantEndDate` and `EventType`. (In the workbook this column was a formula that copied **Name**.)
- Each remaining column is one scenario's request or response. An `x` means the scenario uses the field there. `UpdateClientRequst` is spelled as it was in the workbook.

| Class | CSVTable | DE# | DataElement | FieldNumber | Name | dataExchangeOntologyName | ClientSearchRequest | ClientSearchResponse | NewClientRequest | NewClientResponse | UpdateClientRequst | UpdateClientResponse | ClientSearchProjectRequest | ClientSearchProjectResponse | ClientEnrollmentsRequest | ClientEnrollmentsResponse | ProjectSearchTypeFunderRequest | ProjectSearchTypeFunderResponse | ClientSearchProjectTypeFunderRequest | ClientSearchProjectTypeFunderResponse | ClientAllDataRequest | ClientAllDataResponse |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Benefit | IncomeBenefits | 4.03.2 | 4.03 | 2 | BenefitsFromAnySource | BenefitsFromAnySource |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Benefit | IncomeBenefits | 4.03.3 | 4.03 | 3 | SNAP | SNAP |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Benefit | IncomeBenefits | 4.03.4 | 4.03 | 4 | WIC | WIC |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Benefit | IncomeBenefits | 4.03.5 | 4.03 | 5 | TANFChildCare | TANFChildCare |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Benefit | IncomeBenefits | 4.03.6 | 4.03 | 6 | TANFTransportation | TANFTransportation |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Benefit | IncomeBenefits | 4.03.7 | 4.03 | 7 | OtherTANF | OtherTANF |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Benefit | IncomeBenefits | 4.03.8 | 4.03 | 8 | OtherBenefitsSource | OtherBenefitsSource |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Benefit | IncomeBenefits | 4.03.A | 4.03 | A | OtherBenefitsSourceIdentify | OtherBenefitsSourceIdentify |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| CEAssessment | Assessment | 4.19.3 | 4.19 | 3 | AssessmentType | AssessmentType |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| CEAssessment | Assessment | 4.19.4 | 4.19 | 4 | AssessmentLevel | AssessmentLevel |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| CEAssessment | Assessment | 4.19.7 | 4.19 | 7 | PrioritizationStatus | PrioritizationStatus |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| CEAssessment | Assessment | 4.19.1 | 4.19 | 1 | AssessmentDate | AssessmentDate |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| CEAssessment | Assessment | 4.19.2 | 4.19 | 2 | AssessmentLocation | AssessmentLocation |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| CEEvent | Event | 4.20.2 | 4.20 | 2 | Event | EventType |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| CEEvent | Event | 4.20.A | 4.20 | A | ProbSolDivRRResult | ProbSolDivRRResult |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| CEEvent | Event | 4.20.B | 4.20 | B | ReferralCaseManageAfter | ReferralCaseManageAfter |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| CEEvent | Event | 4.20.D | 4.20 | D | ReferralResult | ReferralResult |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| CEEvent | Event | 4.20.1 | 4.20 | 1 | EventDate | EventDate |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| CEEvent | Event | 4.20.C | 4.20 | C | LocationCrisisOrPHHousing | LocationCrisisOrPHHousing |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| CEEvent | Event | 4.20.E | 4.20 | E | ResultDate | ResultDate |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| CEParticipation | CEParticipation | 2.09.1 | 2.09 | 1 | AccessPoint | AccessPoint |  | x | x | x |  |  |  |  |  |  |  |  |  |  |  | x |
| CEParticipation | CEParticipation | 2.09.A | 2.09 | A | PreventionAssessment | PreventionAssessment |  | x | x | x |  |  |  |  |  |  |  |  |  |  |  | x |
| CEParticipation | CEParticipation | 2.09.A | 2.09 | A | CrisisAssessment | CrisisAssessment |  | x | x | x |  |  |  |  |  |  |  |  |  |  |  | x |
| CEParticipation | CEParticipation | 2.09.A | 2.09 | A | HousingAssessment | HousingAssessment |  | x | x | x |  |  |  |  |  |  |  |  |  |  |  | x |
| CEParticipation | CEParticipation | 2.09.A | 2.09 | A | DirectServices | DirectServices |  | x | x | x |  |  |  |  |  |  |  |  |  |  |  | x |
| CEParticipation | CEParticipation | 2.09.2 | 2.09 | 2 | ReceivesReferrals | ReceivesReferrals |  | x | x | x |  |  |  |  |  |  |  |  |  |  |  | x |
| CEParticipation | CEParticipation | 2.09.3 | 2.09 | 3 | CEParticipationStatusStartDate | CEParticipationStatusStartDate |  | x | x | x |  |  |  |  |  |  |  |  |  |  |  | x |
| CEParticipation | CEParticipation | 2.09.4 | 2.09 | 4 | CEParticipationStatusEndDate | CEParticipationStatusEndDate |  | x | x | x |  |  |  |  |  |  |  |  |  |  |  | x |
| CEQuestion | AssessmentQuestions | 4.19.5 | 4.19 | 5 | AssessmentQuestion | AssessmentQuestion |  | x | x | x |  |  |  |  |  |  |  |  |  |  |  | x |
| CEQuestion | AssessmentQuestions | 4.19.A | 4.19 | A | AssessmentAnswer | AssessmentAnswer |  | x | x | x |  |  |  |  |  |  |  |  |  |  |  | x |
| CEResult | AssessmentResults | 4.19.6 | 4.19 | 6 | AssessmentResultType | AssessmentResultType |  | x | x | x |  |  |  |  |  |  |  |  |  |  |  | x |
| CEResult | AssessmentResults | 4.19.B | 4.19 | B | AssessmentResult | AssessmentResult |  | x | x | x |  |  |  |  |  |  |  |  |  |  |  | x |
| Client | Client | 3.01.5 | 3.01 | 5 | NameDataQuality | NameDataQuality |  | x | x | x | x | x |  | x |  |  |  |  |  |  |  | x |
| Client | Client | 3.02.2 | 3.02 | 2 | SSNDataQuality | SSNDataQuality |  | x | x | x | x | x |  | x |  |  |  |  |  |  |  | x |
| Client | Client | 3.03.2 | 3.03 | 2 | DOBDataQuality | DOBDataQuality |  | x | x | x | x | x |  | x |  |  |  |  |  |  |  | x |
| Client | Client | 4.21 | 4.21 |  | Sex | Sex |  | x | x | x | x | x |  | x |  |  |  |  |  |  |  | x |
| Client | Client | 3.04.1 | 3.04 | 1 | AmIndAKNative | AmIndAKNative |  | x | x | x | x | x |  | x |  |  |  |  |  |  |  | x |
| Client | Client | 3.04.1 | 3.04 | 1 | Asian | Asian |  | x | x | x | x | x |  | x |  |  |  |  |  |  |  | x |
| Client | Client | 3.04.1 | 3.04 | 1 | BlackAfAmerican | BlackAfAmerican |  | x | x | x | x | x |  | x |  |  |  |  |  |  |  | x |
| Client | Client | 3.04.1 | 3.04 | 1 | HispanicLatinao | HispanicLatinao |  | x | x | x | x | x |  | x |  |  |  |  |  |  |  | x |
| Client | Client | 3.04.1 | 3.04 | 1 | MidEastNAfrican | MidEastNAfrican |  | x | x | x | x | x |  | x |  |  |  |  |  |  |  | x |
| Client | Client | 3.04.1 | 3.04 | 1 | NativeHIPacific | NativeHIPacific |  | x | x | x | x | x |  | x |  |  |  |  |  |  |  | x |
| Client | Client | 3.04.1 | 3.04 | 1 | White | White |  | x | x | x | x | x |  | x |  |  |  |  |  |  |  | x |
| Client | Client | 3.04.1 | 3.04 | 1 | RaceNone | RaceNone |  |  |  |  | x | x |  | x |  |  |  |  |  |  |  | x |
| Client | Client | 3.07.1 | 3.07 | 1 | VeteranStatus | VeteranStatus |  |  |  |  | x | x |  | x |  |  |  |  |  |  |  | x |
| Client | Client | V1.3 | V1 | 3 | WorldWarII | WorldWarII |  |  |  |  | x | x |  | x |  |  |  |  |  |  |  | x |
| Client | Client | V1.4 | V1 | 4 | KoreanWar | KoreanWar |  |  |  |  | x | x |  | x |  |  |  |  |  |  |  | x |
| Client | Client | V1.5 | V1 | 5 | VietnamWar | VietnamWar |  |  |  |  | x | x |  | x |  |  |  |  |  |  |  | x |
| Client | Client | V1.6 | V1 | 6 | DesertStorm | DesertStorm |  |  |  |  | x | x |  | x |  |  |  |  |  |  |  | x |
| Client | Client | V1.7 | V1 | 7 | AfghanistanOEF | AfghanistanOEF |  |  |  |  | x | x |  | x |  |  |  |  |  |  |  | x |
| Client | Client | V1.8 | V1 | 8 | IraqOIF | IraqOIF |  |  |  |  | x | x |  | x |  |  |  |  |  |  |  | x |
| Client | Client | V1.9 | V1 | 9 | IraqOND | IraqOND |  |  |  |  | x | x |  | x |  |  |  |  |  |  |  | x |
| Client | Client | V1.10 | V1 | 10 | OtherTheater | OtherTheater |  |  |  |  | x | x |  | x |  |  |  |  |  |  |  | x |
| Client | Client | V1.11 | V1 | 11 | MilitaryBranch | MilitaryBranch |  |  |  |  | x | x |  | x |  |  |  |  |  |  |  | x |
| Client | Client | V1.12 | V1 | 12 | DischargeStatus | DischargeStatus |  |  |  |  | x | x |  | x |  |  |  |  |  |  |  | x |
| Client | Client | 5.08 | 5.08 |  | PersonalID | PersonalID |  |  |  |  | x | x |  | x | x | x |  |  |  |  | x | x |
| Client | Client | 3.01.1 | 3.01 | 1 | FirstName | FirstName |  |  |  |  | x | x |  | x |  |  |  |  |  | x |  | x |
| Client | Client | 3.01.2 | 3.01 | 2 | MiddleName | MiddleName |  |  |  |  | x | x |  | x |  |  |  |  |  |  |  | x |
| Client | Client | 3.01.3 | 3.01 | 3 | LastName | LastName |  |  |  |  | x | x |  | x |  |  |  |  |  | x |  | x |
| Client | Client | 3.01.4 | 3.01 | 4 | NameSuffix | NameSuffix |  |  |  |  | x | x |  | x |  |  |  |  |  |  |  | x |
| Client | Client | 3.02.1 | 3.02 | 1 | SSN | SSN |  |  |  |  | x | x |  | x |  |  |  |  |  |  |  | x |
| Client | Client | 3.03.1 | 3.03 | 1 | DOB | DOB |  |  |  |  | x | x |  | x |  |  |  |  |  | x |  | x |
| Client | Client | 3.04.2 | 3.04 | 2 | AdditionalRaceEthnicity | AdditionalRaceEthnicity |  |  |  |  | x | x |  | x |  |  |  |  |  |  |  | x |
| Client | Client | V1.1 | V1 | 1 | YearEnteredService | YearEnteredService |  |  |  |  | x | x |  | x |  |  |  |  |  |  |  | x |
| Client | Client | V1.2 | V1 | 2 | YearSeparated | YearSeparated |  |  |  |  | x | x |  | x |  |  |  |  |  |  |  | x |
| CurrentLivingSituation | CurrentLivingSituation | 4.12.2 | 4.12 | 2 | CurrentLivingSituation | CurrentLivingSituation |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| CurrentLivingSituation | CurrentLivingSituation | 4.12.A | 4.12 | A | CLSSubsidyType | CLSSubsidyType |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| CurrentLivingSituation | CurrentLivingSituation | 4.12.B | 4.12 | B | LeaveSituation14Days | LeaveSituation14Days |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| CurrentLivingSituation | CurrentLivingSituation | 4.12.C | 4.12 | C | SubsequentResidence | SubsequentResidence |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| CurrentLivingSituation | CurrentLivingSituation | 4.12.D | 4.12 | D | ResourcesToObtain | ResourcesToObtain |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| CurrentLivingSituation | CurrentLivingSituation | 4.12.E | 4.12 | E | LeaseOwn60Day | LeaseOwn60Day |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| CurrentLivingSituation | CurrentLivingSituation | 4.12.F | 4.12 | F | MovedTwoOrMore | MovedTwoOrMore |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| CurrentLivingSituation | CurrentLivingSituation | 4.12.1 | 4.12 | 1 | InformationDate | InformationDate |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| CurrentLivingSituation | CurrentLivingSituation | 4.12.3 | 4.12 | 3 | VerifiedBy | VerifiedBy |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| CurrentLivingSituation | CurrentLivingSituation | 4.12.4 | 4.12 | 4 | LocationDetails | LocationDetails |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Disability | Disabilities | W4.2 | W4 | 2 | TCellCountAvailable | TCellCountAvailable |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Disability | Disabilities | W4.B | W4 | B | TCellSource | TCellSource |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Disability | Disabilities | W4.3 | W4 | 3 | ViralLoadAvailable | ViralLoadAvailable |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Disability | Disabilities | W4.D | W4 | D | ViralLoadSource | ViralLoadSource |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Disability | Disabilities | W6.2 | W6 | 2 | AntiRetroviral | AntiRetroviral |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Disability | Disabilities | W4.A | W4 | A | TCellCount | TCellCount |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Disability | Disabilities | W4.C | W4 | C | ViralLoad | ViralLoad |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| EmploymentEducation | EmploymentEducation | R4.1 | R4 | 1 | LastGradeCompleted | LastGradeCompleted |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| EmploymentEducation | EmploymentEducation | R5.1 | R5 | 1 | SchoolStatus | SchoolStatus |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| EmploymentEducation | EmploymentEducation | R6.2 | R6 | 2 | Employed | Employed |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| EmploymentEducation | EmploymentEducation | R6.A | R6 | A | EmploymentType | EmploymentType |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| EmploymentEducation | EmploymentEducation | R6.B | R6 | B | NotEmployedReason | NotEmployedReason |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| EmploymentEducation | EmploymentEducation | R6.1 | R6 | 1 | InformationDate | InformationDate |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| EnrollAssessment | Enrollment | 3.917.1 | 3.917 | 1 | LivingSituation | LivingSituation |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| EnrollAssessment | Enrollment | 3.917.A | 3.917 | A | RentalSubsidyType | RentalSubsidyType |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| EnrollAssessment | Enrollment | 3.917.2 | 3.917 | 2 | LengthOfStay | LengthOfStay |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| EnrollAssessment | Enrollment | 3.917.2 A | 3.917 | 2 A | LOSUnderThreshold | LOSUnderThreshold |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| EnrollAssessment | Enrollment | 3.917.2 B | 3.917 | 2 B | LOSUnderThreshold | LOSUnderThreshold |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| EnrollAssessment | Enrollment | 3.917.2 C | 3.917 | 2 C | PreviousStreetESSH | PreviousStreetESSH |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| EnrollAssessment | Enrollment | 3.917.4 | 3.917 | 4 | TimesHomelessPastThreeYears | TimesHomelessPastThreeYears |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| EnrollAssessment | Enrollment | 3.917.5 | 3.917 | 5 | MonthsHomelessPastThreeYears | MonthsHomelessPastThreeYears |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| EnrollAssessment | Enrollment | 3.08 | 3.08 |  | DisablingCondition | DisablingCondition |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| EnrollAssessment | Exit | 3.12.1 | 3.12 | 1 | Destination | Destination |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| EnrollAssessment | Exit | 3.12.A | 3.12 | A | DestinationSubsidyType | DestinationSubsidyType |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| EnrollAssessment | Exit | W5.1 | W5 | 1 | HousingAssessment | HousingAssessment |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| EnrollAssessment | Exit | W5.A | W5 | A | SubsidyInformation | SubsidyInformation |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| EnrollAssessment | Exit | W5.B | W5 | B | SubsidyInformation | SubsidyInformation |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| EnrollAssessment | Exit | R17.1 | R17 | 1 | ProjectCompletionStatus | ProjectCompletionStatus |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| EnrollAssessment | Exit | R17.A | R17 | A | EarlyExitReason | EarlyExitReason |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| EnrollAssessment | Exit | R15.1 | R15 | 1 | ExchangeForSex | ExchangeForSex |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| EnrollAssessment | Exit | R15.A | R15 | A | ExchangeForSexPastThreeMonths | ExchangeForSexPastThreeMonths |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| EnrollAssessment | Exit | R15.B | R15 | B | CountOfExchangeForSex | CountOfExchangeForSex |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| EnrollAssessment | Exit | R15.C | R15 | C | AskedOrForcedToExchangeForSex | AskedOrForcedToExchangeForSex |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| EnrollAssessment | Exit | R15.D | R15 | D | AskedOrForcedToExchangeForSexPastThreeMonths | AskedOrForcedToExchangeForSexPastThreeMonths |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| EnrollAssessment | Exit | R16.1 | R16 | 1 | WorkplaceViolenceThreats | WorkplaceViolenceThreats |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| EnrollAssessment | Exit | R16.2 | R16 | 2 | WorkplacePromiseDifference | WorkplacePromiseDifference |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| EnrollAssessment | Exit | R16.A | R16 | A | CoercedToContinueWork | CoercedToContinueWork |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| EnrollAssessment | Exit | R16.B | R16 | B | LaborExploitPastThreeMonths | LaborExploitPastThreeMonths |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| EnrollAssessment | Exit | R18.1 | R18 | 1 | CounselingReceived | CounselingReceived |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| EnrollAssessment | Exit | R18.A | R18 | A | IndividualCounseling | IndividualCounseling |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| EnrollAssessment | Exit | R18.A | R18 | A | FamilyCounseling | FamilyCounseling |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| EnrollAssessment | Exit | R18.A | R18 | A | GroupCounseling | GroupCounseling |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| EnrollAssessment | Exit | R18.3 | R18 | 3 | PostExitCounselingPlan | PostExitCounselingPlan |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| EnrollAssessment | Exit | R19.1 | R19 | 1 | DestinationSafeClient | DestinationSafeClient |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| EnrollAssessment | Exit | R19.2 | R19 | 2 | DestinationSafeWorker | DestinationSafeWorker |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| EnrollAssessment | Exit | R19.3 | R19 | 3 | PosAdultConnections | PosAdultConnections |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| EnrollAssessment | Exit | R19.4 | R19 | 4 | PosPeerConnections | PosPeerConnections |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| EnrollAssessment | Exit | R19.5 | R19 | 5 | PosCommunityConnections | PosCommunityConnections |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| EnrollAssessment | Exit | R20.2 | R20 | 2 | AftercareProvided | AftercareProvided |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| EnrollAssessment | Exit | R20.A | R20 | A | EmailSocialMedia | EmailSocialMedia |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| EnrollAssessment | Exit | R20.A | R20 | A | Telephone | Telephone |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| EnrollAssessment | Exit | R20.A | R20 | A | InPersonIndividual | InPersonIndividual |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| EnrollAssessment | Exit | R20.A | R20 | A | InPersonGroup | InPersonGroup |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| EnrollAssessment | Exit | V9.1 | V9 | 1 | CMExitReason | CMExitReason |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| EnrollAssessment | YouthEducationStatus | C3.2 | C3 | 2 | CurrentSchoolAttend | CurrentSchoolAttend |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| EnrollAssessment | YouthEducationStatus | C3.A | C3 | A | MostRecentEdStatus | MostRecentEdStatus |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| EnrollAssessment | YouthEducationStatus | C3.B | C3 | B | CurrentEdStatus | CurrentEdStatus |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| EnrollAssessment | Enrollment | 3.10.1 | 3.10 | 1 | EntryDate | EntryDate |  |  |  |  |  |  | x | x | x | x |  |  | x | x | x | x |
| EnrollAssessment | Enrollment | 3.16.1 | 3.16 | 1 | EnrollmentCoC | EnrollmentCoC |  |  |  |  |  |  |  |  |  | x |  |  |  |  |  | x |
| EnrollAssessment | Enrollment | 3.917.3 | 3.917 | 3 | DateToStreetESSH | DateToStreetESSH |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| EnrollAssessment | Enrollment | 4.13.1 | 4.13 | 1 | DateOfEngagement | DateOfEngagement |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| EnrollAssessment | Enrollment | 3.20.1 | 3.20 | 1 | MoveInDate | MoveInDate |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| EnrollAssessment | Exit | 3.11.1 | 3.11 | 1 | ExitDate | ExitDate |  |  |  |  |  |  | x | x | x | x |  |  | x | x | x | x |
| EnrollAssessment | Exit | 3.12.B | 3.12 | B | OtherDestination | OtherDestination |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| EnrollAssessment | Exit | R18.B | R18 | B | SessionCountAtExit | SessionCountAtExit |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| EnrollAssessment | Exit | R18.2 | R18 | 2 | SessionsInPlan | SessionsInPlan |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| EnrollAssessment | Exit | R20.1 | R20 | 1 | AftercareDate | AftercareDate |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| EnrollAssessment | YouthEducationStatus | C3.1 | C3 | 1 | InformationDate | InformationDate |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Enrollment | Enrollment | P3.2 | P3 | 2 | ClientEnrolledInPATH | ClientEnrolledInPATH |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Enrollment | Enrollment | P3.A | P3 | A | ReasonNotEnrolled | ReasonNotEnrolled |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Enrollment | Enrollment | V4.1 | V4 | 1 | PercentAMI | PercentAMI |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Enrollment | Enrollment | R1.1 | R1 | 1 | ReferralSource | ReferralSource |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Enrollment | Enrollment | R2.2 | R2 | 2 | EligibleForRHY | EligibleForRHY |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Enrollment | Enrollment | R2.A | R2 | A | ReasonNoServices | ReasonNoServices |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Enrollment | Enrollment | R2.B | R2 | B | RunawayYouth | RunawayYouth |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Enrollment | Enrollment | R11.1 | R11 | 1 | FormerWardChildWelfare | FormerWardChildWelfare |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Enrollment | Enrollment | R11.A | R11 | A | ChildWelfareYears | ChildWelfareYears |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Enrollment | Enrollment | R12.1 | R12 | 1 | FormerWardJuvenileJustice | FormerWardJuvenileJustice |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Enrollment | Enrollment | R12.A | R12 | A | JuvenileJusticeYears | JuvenileJusticeYears |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Enrollment | Enrollment | R13.9 | R13 | 9 | UnemploymentFam | UnemploymentFam |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Enrollment | Enrollment | R13.11 | R13 | 11 | MentalHealthDisorderFam | MentalHealthDisorderFam |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Enrollment | Enrollment | R13.15 | R13 | 15 | PhysicalDisabilityFam | PhysicalDisabilityFam |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Enrollment | Enrollment | R13.21 | R13 | 21 | AlcoholDrugUseDisorderFam | AlcoholDrugUseDisorderFam |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Enrollment | Enrollment | R13.22 | R13 | 22 | InsufficientIncome | InsufficientIncome |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Enrollment | Enrollment | R13.24 | R13 | 24 | IncarceratedParent | IncarceratedParent |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Enrollment | Enrollment | V6.1 | V6 | 1 | VAMCStation | VAMCStation |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Enrollment | Enrollment | V7.1 | V7 | 1 | TargetScreenReqd | TargetScreenReqd |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Enrollment | Enrollment | V7.A | V7 | A | TimeToHousingLoss | TimeToHousingLoss |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Enrollment | Enrollment | V7.B | V7 | B | AnnualPercentAMI | AnnualPercentAMI |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Enrollment | Enrollment | V7.C | V7 | C | LiteralHomelessHistory | LiteralHomelessHistory |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Enrollment | Enrollment | V7.D | V7 | D | ClientLeaseholder | ClientLeaseholder |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Enrollment | Enrollment | V7.E | V7 | E | HOHLeaseholder | HOHLeaseholder |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Enrollment | Enrollment | V7.F | V7 | F | SubsidyAtRisk | SubsidyAtRisk |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Enrollment | Enrollment | V7.G | V7 | G | EvictionHistory | EvictionHistory |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Enrollment | Enrollment | V7.H | V7 | H | CriminalRecord | CriminalRecord |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Enrollment | Enrollment | V7.I | V7 | I | IncarceratedAdult | IncarceratedAdult |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Enrollment | Enrollment | V7.J | V7 | J | PrisonDischarge | PrisonDischarge |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Enrollment | Enrollment | V7.K | V7 | K | SexOffender | SexOffender |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Enrollment | Enrollment | V7.L | V7 | L | DisabledHoH | DisabledHoH |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Enrollment | Enrollment | V7.M | V7 | M | CurrentPregnant | CurrentPregnant |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Enrollment | Enrollment | V7.N | V7 | N | SingleParent | SingleParent |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Enrollment | Enrollment | V7.O | V7 | O | DependentUnder6 | DependentUnder6 |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Enrollment | Enrollment | V7.P | V7 | P | HH5Plus | HH5Plus |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Enrollment | Enrollment | V7.Q | V7 | Q | CoCPrioritized | CoCPrioritized |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Enrollment | Enrollment | V10 | V10 |  | MentalHealthConsultation | MentalHealthConsultation |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Enrollment | Enrollment | 5.06.1 | 5.06 | 1 | EnrollmentID | EnrollmentID |  |  |  |  |  |  |  |  |  | x |  |  |  | x |  | x |
| Enrollment | Enrollment | 5.08.1 | 5.08 | 1 | PersonalID | PersonalID |  |  |  |  |  |  |  |  |  |  |  |  |  | x | x | x |
| Enrollment | Enrollment | 2.02.1 | 2.02 | 1 | ProjectID | ProjectID |  |  |  |  |  |  |  |  | x | x |  | x |  | x |  | x |
| Enrollment | Enrollment | P3.1 | P3 | 1 | DateOfPATHStatus | DateOfPATHStatus |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Enrollment | Enrollment | R1.A | R1 | A | CountOutreachReferralApproaches | CountOutreachReferralApproaches |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Enrollment | Enrollment | R2.1 | R2 | 1 | DateOfBCPStatus | DateOfBCPStatus |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Enrollment | Enrollment | R11.B | R11 | B | ChildWelfareMonths | ChildWelfareMonths |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Enrollment | Enrollment | R12.B | R12 | B | JuvenileJusticeMonths | JuvenileJusticeMonths |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Enrollment | Enrollment | V7.R | V7 | R | HPScreeningScore | HPScreeningScore |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Enrollment | Enrollment | V7.S | V7 | S | ThresholdScore | ThresholdScore |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| FundSource | Funder | 2.06.1 | 2.06 | 1 | Funder | Funder |  |  |  |  |  |  |  |  |  |  | x |  | x |  |  | x |
| FundSource | Funder | 2.06.A | 2.06 | A | OtherFunder | OtherFunder |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| FundSource | Funder | 2.06.2 | 2.06 | 2 | GrantID | GrantID |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| FundSource | Funder | 2.06.3 | 2.06 | 3 | StartDate | GrantStartDate |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| FundSource | Funder | 2.06.4 | 2.06 | 4 | EndDate | GrantEndDate |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Geography | ProjectCoC | 2.03.8 | 2.03 | 8 | GeographyType | GeographyType |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Geography | ProjectCoC | 2.03.1 | 2.03 | 1 | CoCCode | CoCCode |  |  |  |  |  |  |  |  |  |  | x |  |  |  |  | x |
| Geography | ProjectCoC | 2.03.2 | 2.03 | 2 | Geocode | Geocode |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Geography | ProjectCoC | 2.03.3 | 2.03 | 3 | Address1 | Address1 |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Geography | ProjectCoC | 2.03.4 | 2.03 | 4 | Address2 | Address2 |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Geography | ProjectCoC | 2.03.5 | 2.03 | 5 | City | City |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Geography | ProjectCoC | 2.03.6 | 2.03 | 6 | State | State |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Geography | ProjectCoC | 2.03.7 | 2.03 | 7 | ZIP | ZIP |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| HealthAndDV | HealthAndDV | 4.11.2 | 4.11 | 2 | DomesticViolenceSurvivor | DomesticViolenceSurvivor |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| HealthAndDV | HealthAndDV | 4.11.A | 4.11 | A | WhenOccurred | WhenOccurred |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| HealthAndDV | HealthAndDV | 4.11.B | 4.11 | B | CurrentlyFleeing | CurrentlyFleeing |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| HealthAndDV | HealthAndDV | R7.1 | R7 | 1 | GeneralHealthStatus | GeneralHealthStatus |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| HealthAndDV | HealthAndDV | R8.1 | R8 | 1 | DentalHealthStatus | DentalHealthStatus |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| HealthAndDV | HealthAndDV | R9.1 | R9 | 1 | MentalHealthStatus | MentalHealthStatus |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| HealthAndDV | HealthAndDV | R10.1 | R10 | 1 | PregnancyStatus | PregnancyStatus |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| HealthAndDV | HealthAndDV | 4.11.1 | 4.11 | 1 | InformationDate | InformationDate |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| HealthAndDV | HealthAndDV | R10.A | R10 | A | DueDate | DueDate |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| HealthInsurance | IncomeBenefits | 4.04.2 | 4.04 | 2 | InsuranceFromAnySource | InsuranceFromAnySource |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| HealthInsurance | IncomeBenefits | 4.04.3 | 4.04 | 3 | Medicaid | Medicaid |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| HealthInsurance | IncomeBenefits | 4.04.3A | 4.04 | 3A | NoMedicaidReason | NoMedicaidReason |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| HealthInsurance | IncomeBenefits | 4.04.4 | 4.04 | 4 | Medicare | Medicare |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| HealthInsurance | IncomeBenefits | 4.04.4A | 4.04 | 4A | NoMedicareReason | NoMedicareReason |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| HealthInsurance | IncomeBenefits | 4.04.5 | 4.04 | 5 | SCHIP | SCHIP |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| HealthInsurance | IncomeBenefits | 4.04.5A | 4.04 | 5A | NoSCHIPReason | NoSCHIPReason |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| HealthInsurance | IncomeBenefits | 4.04.6 | 4.04 | 6 | VHAServices | VHAServices |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| HealthInsurance | IncomeBenefits | 4.04.6A | 4.04 | 6A | NoVHAReason | NoVHAReason |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| HealthInsurance | IncomeBenefits | 4.04.7 | 4.04 | 7 | EmployerProvided | EmployerProvided |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| HealthInsurance | IncomeBenefits | 4.04.7A | 4.04 | 7A | NoEmployerProvidedReason | NoEmployerProvidedReason |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| HealthInsurance | IncomeBenefits | 4.04.8 | 4.04 | 8 | COBRA | COBRA |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| HealthInsurance | IncomeBenefits | 4.04.8A | 4.04 | 8A | NoCOBRAReason | NoCOBRAReason |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| HealthInsurance | IncomeBenefits | 4.04.9 | 4.04 | 9 | PrivatePay | PrivatePay |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| HealthInsurance | IncomeBenefits | 4.04.9A | 4.04 | 9A | NoPrivatePayReason | NoPrivatePayReason |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| HealthInsurance | IncomeBenefits | 4.04.10 | 4.04 | 10 | StateHealthIns | StateHealthIns |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| HealthInsurance | IncomeBenefits | 4.04.10A | 4.04 | 10A | NoStateHealthInsReason | NoStateHealthInsReason |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| HealthInsurance | IncomeBenefits | 4.04.11 | 4.04 | 11 | IndianHealthServices | IndianHealthServices |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| HealthInsurance | IncomeBenefits | 4.04.11A | 4.04 | 11A | NoIndianHealthServicesReason | NoIndianHealthServicesReason |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| HealthInsurance | IncomeBenefits | 4.04.12 | 4.04 | 12 | OtherInsurance | OtherInsurance |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| HealthInsurance | IncomeBenefits | 4.04.12A | 4.04 | 12A | OtherInsuranceIdentify | OtherInsuranceIdentify |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| HMISParticipation | HMISParticipation | 2.08.1 | 2.08 | 1 | HMISParticipationType | HMISParticipationType |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| HMISParticipation | HMISParticipation | 2.08.2 | 2.08 | 2 | HMISParticipationStatusStartDate | HMISParticipationStatusStartDate |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| HMISParticipation | HMISParticipation | 2.08.3 | 2.08 | 3 | HMISParticipationStatusEndDate | HMISParticipationStatusEndDate |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Household | Enrollment | 3.15.1 | 3.15 | 1 | RelationshipToHoH | RelationshipToHoH |  |  |  |  |  |  |  |  |  | x |  |  |  |  |  | x |
| Household | Enrollment | 5.09.1 | 5.09 | 1 | HouseholdID | HouseholdID |  |  |  |  |  |  |  |  |  | x |  |  |  |  |  | x |
| Income | IncomeBenefits | 4.02.2 | 4.02 | 2 | IncomeFromAnySource | IncomeFromAnySource |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Income | IncomeBenefits | 4.02.3 | 4.02 | 3 | Earned | Earned | x | x |  | x |  |  |  |  |  |  |  |  |  |  |  | x |
| Income | IncomeBenefits | 4.02.4 | 4.02 | 4 | Unemployment | Unemployment | x | x | x | x |  |  |  |  |  |  |  |  |  |  |  | x |
| Income | IncomeBenefits | 4.02.5 | 4.02 | 5 | SSI | SSI |  | x | x | x |  |  |  |  |  |  |  |  |  |  |  | x |
| Income | IncomeBenefits | 4.02.6 | 4.02 | 6 | SSDI | SSDI | x | x | x | x |  |  |  |  |  |  |  |  |  |  |  | x |
| Income | IncomeBenefits | 4.02.7 | 4.02 | 7 | VADisabilityService | VADisabilityService |  | x | x | x |  |  |  |  |  |  |  |  |  |  |  | x |
| Income | IncomeBenefits | 4.02.8 | 4.02 | 8 | VADisabilityNonService | VADisabilityNonService | x | x | x | x |  |  |  |  |  |  |  |  |  |  |  | x |
| Income | IncomeBenefits | 4.02.9 | 4.02 | 9 | PrivateDisability | PrivateDisability | x | x | x | x |  |  |  |  |  |  |  |  |  |  |  | x |
| Income | IncomeBenefits | 4.02.10 | 4.02 | 10 | WorkersComp | WorkersComp |  | x | x | x |  |  |  |  |  |  |  |  |  |  |  | x |
| Income | IncomeBenefits | 4.02.11 | 4.02 | 11 | TANF | TANF |  | x | x | x |  |  |  |  |  |  |  |  |  |  |  | x |
| Income | IncomeBenefits | 4.02.12 | 4.02 | 12 | GA | GA |  | x | x | x |  |  |  |  |  |  |  |  |  |  |  | x |
| Income | IncomeBenefits | 4.02.13 | 4.02 | 13 | SocSecRetirement | SocSecRetirement |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Income | IncomeBenefits | 4.02.14 | 4.02 | 14 | Pension | Pension |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Income | IncomeBenefits | 4.02.15 | 4.02 | 15 | ChildSupport | ChildSupport |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Income | IncomeBenefits | 4.02.16 | 4.02 | 16 | Alimony | Alimony |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Income | IncomeBenefits | 4.02.17 | 4.02 | 17 | OtherIncomeSource | OtherIncomeSource |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Income | IncomeBenefits | 4.02.18 | 4.02 | 18 | TotalMonthlyIncome | TotalMonthlyIncome |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Income | IncomeBenefits | 4.02.A | 4.02 | A | EarnedAmount | EarnedAmount |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Income | IncomeBenefits | 4.02.B | 4.02 | B | UnemploymentAmount | UnemploymentAmount |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Income | IncomeBenefits | 4.02.C | 4.02 | C | SSIAmount | SSIAmount |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Income | IncomeBenefits | 4.02.D | 4.02 | D | SSDIAmount | SSDIAmount |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Income | IncomeBenefits | 4.02.E | 4.02 | E | VADisabilityServiceAmount | VADisabilityServiceAmount |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Income | IncomeBenefits | 4.02.F | 4.02 | F | VADisabilityNonServiceAmount | VADisabilityNonServiceAmount |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Income | IncomeBenefits | 4.02.G | 4.02 | G | PrivateDisabilityAmount | PrivateDisabilityAmount |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Income | IncomeBenefits | 4.02.H | 4.02 | H | WorkersCompAmount | WorkersCompAmount |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Income | IncomeBenefits | 4.02.I | 4.02 | I | TANFAmount | TANFAmount |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Income | IncomeBenefits | 4.02.J | 4.02 | J | GAAmount | GAAmount |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Income | IncomeBenefits | 4.02.K | 4.02 | K | SocSecRetirementAmount | SocSecRetirementAmount |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Income | IncomeBenefits | 4.02.L | 4.02 | L | PensionAmount | PensionAmount |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Income | IncomeBenefits | 4.02.M | 4.02 | M | ChildSupportAmount | ChildSupportAmount |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Income | IncomeBenefits | 4.02.N | 4.02 | N | AlimonyAmount | AlimonyAmount |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Income | IncomeBenefits | 4.02.O | 4.02 | O | OtherIncomeAmount | OtherIncomeAmount |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Income | IncomeBenefits | 4.02.P | 4.02 | P | OtherIncomeSourceIdentify | OtherIncomeSourceIdentify |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Inventory | Inventory | 2.07.4 | 2.07 | 4 | HouseholdType | HouseholdType |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Inventory | Inventory | 2.07.6 | 2.07 | 6 | Availability | Availability |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Inventory | Inventory | 2.07.5 | 2.07 | 5 | ESBedType | ESBedType |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Inventory | Inventory | 2.07.3 | 2.07 | 3 | CoCCode | CoCCode |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Inventory | Inventory | 2.07.15 | 2.07 | 15 | UnitInventory | UnitInventory |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Inventory | Inventory | 2.07.14 | 2.07 | 14 | BedInventory | BedInventory |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Inventory | Inventory | 2.07.7 | 2.07 | 7 | CHVetBedInventory | CHVetBedInventory |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Inventory | Inventory | 2.07.8 | 2.07 | 8 | YouthVetBedInventory | YouthVetBedInventory |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Inventory | Inventory | 2.07.9 | 2.07 | 9 | VetBedInventory | VetBedInventory |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Inventory | Inventory | 2.07.10 | 2.07 | 10 | CHYouthBedInventory | CHYouthBedInventory |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Inventory | Inventory | 2.07.11 | 2.07 | 11 | YouthBedInventory | YouthBedInventory |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Inventory | Inventory | 2.07.12 | 2.07 | 12 | CHBedInventory | CHBedInventory |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Inventory | Inventory | 2.07.13 | 2.07 | 13 | OtherBedInventory | OtherBedInventory |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Inventory | Inventory | 2.07.1 | 2.07 | 1 | InventoryStartDate | InventoryStartDate |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Inventory | Inventory | 2.07.2 | 2.07 | 2 | InventoryEndDate | InventoryEndDate |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Organization | Organization | 2.01.3 | 2.01 | 3 | VictimServiceProvider | VictimServiceProvider |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Organization | Organization | 2.01.1 | 2.01 | 1 | OrganizationID | OrganizationID |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Organization | Organization | 2.01.2 | 2.01 | 2 | OrganizationName | OrganizationName |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Project | Project | 2.02.5 | 2.02 | 5 | ContinuumProject | ContinuumProject |  |  |  |  |  |  |  |  |  |  |  | x |  |  |  | x |
| Project | Project | 2.02.6 | 2.02 | 6 | ProjectType | ProjectType |  |  |  |  |  |  |  |  |  |  | x | x | x |  |  | x |
| Project | Project | 2.02.D | 2.02 | D | HousingType | HousingType |  |  |  |  |  |  |  |  |  |  |  | x |  |  |  | x |
| Project | Project | 2.02.A | 2.02 | A | RRHSubType | RRHSubType |  |  |  |  |  |  |  |  |  |  |  | x |  |  |  | x |
| Project | Project | 2.02.B | 2.02 | B | ResidentialAffiliation | ResidentialAffiliation |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Project | Project | 2.02.7 | 2.02 | 7 | TargetPopulation | TargetPopulation |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Project | Project | 2.02.8 | 2.02 | 8 | HOPWAMedAssistedLivingFac | HOPWAMedAssistedLivingFac |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Project | Project | 2.02.1 | 2.02 | 1 | ProjectID | ProjectID |  |  |  |  |  |  | x | x |  |  |  |  |  |  |  | x |
| Project | Project | 2.01.1 | 2.01 | 1 | OrganizationID | OrganizationID |  |  |  |  |  |  |  |  |  |  |  | x |  |  |  | x |
| Project | Project | 2.02.2 | 2.02 | 2 | ProjectName | ProjectName |  |  |  |  |  |  |  | x |  | x |  | x |  | x |  | x |
| Project | Project | 2.02.3 | 2.02 | 3 | OperatingStartDate | OperatingStartDate |  |  |  |  |  |  |  |  |  |  | x | x |  |  |  | x |
| Project | Project | 2.02.4 | 2.02 | 4 | OperatingEndDate | OperatingEndDate |  |  |  |  |  |  |  |  |  |  | x | x |  |  |  | x |
| Project | Affiliation | 2.02.C | 2.02 | C | ResProjectID | ResProjectID |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Service | IncomeBenefits | W3.3 | W3 | 3 | ADAP | ADAP |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Service | IncomeBenefits | W3.B | W3 | B | NoADAPReason | NoADAPReason |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Service | IncomeBenefits | W3.4 | W3 | 4 | RyanWhiteMedDent | RyanWhiteMedDent |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Service | IncomeBenefits | W3.C | W3 | C | NoRyanWhiteReason | NoRyanWhiteReason |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Service | IncomeBenefits | P4.1 | P4 | 1 | ConnectionWithSOAR | ConnectionWithSOAR |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Service | Services | P2 | P2 |  | ReferralOutcome | ReferralOutcome |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Service | Services | V2.D | V2 | D | OtherTypeProvided | OtherTypeProvided |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Service | Services | V8.A | V8 | A | OtherTypeProvided | OtherTypeProvided |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Service | Services | C2.A | C2 | A | MovingOnOtherType | MovingOnOtherType |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Service | Services | V2.A | V2 | A | SubTypeProvided | SubTypeProvided |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Service | Services | V2.B | V2 | B | SubTypeProvided | SubTypeProvided |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Service | Services | V2.C | V2 | C | SubTypeProvided | SubTypeProvided |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Service | Services | W2 | W2 |  | FAAmount | FAAmount |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Service | Services | V3.2 | V3 | 2 | FAAmount | FAAmount |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Service | Services | V3.1 | V3 | 1 | FAStartDate | FAStartDate |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Service | Services | V3.4 | V3 | 4 | FAEndDate | FAEndDate |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| Service | Services | FW.5 | FW | 5 | ExportID | ExportID |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
| User | User | 5.07 | 5.07 |  | UserID | UserID |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | x |
