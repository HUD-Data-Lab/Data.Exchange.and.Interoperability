# HMIS data dictionary annotations

Plain-language guidance for each HMIS data element, taken from HUD's HMIS
Data Standards Manual. The Shiny app shows it on its Data Dictionary
panels. There is one section per data element, headed by the element's
identifier and name. Its fields are:

- **Element Type:** the kind of element, such as Project Descriptor or Universal.
- **Funder: Program-Component:** which funders and programs require it.
- **Project Type Applicability:** which HMIS project types collect it.
- **Data Collected About:** whose data it is, such as all clients or heads of household.
- **Collection Point:** when it is collected, such as at project start or exit.
- **System Logic and Other System Issues:** rules for HMIS software.
- **CSV:** where it appears in the HMIS CSV export.
- **Rationale:** why it is collected. Some elements have none.
- **Data Collection Instruction:** the element's page on HUD Exchange.

The app reads this file with `read_data_dictionary()` in `global.R`, which
expects this exact layout: a `## <identifier> <name>` heading per element,
then one `- **<field>:** <value>` item per field, with any further lines
of a value indented by two spaces. CSV values are in backticks, and the
documentation links are written as Markdown links.

## 2.01 Organization Information

- **Element Type:** Project Descriptor
- **Funder: Program-Component:** All Programs - All Components
- **Project Type Applicability:** All HMIS Project Types
- **Data Collected About:** All Organizations
- **Collection Point:** Initial HMIS project setup, reviewed/updated no less than annually
- **System Logic and Other System Issues:** An Organization ID must be assigned to each project via a system generated number or code.
- **CSV:** `Organization`
- **Rationale:** To uniquely identify organizations operating one or more projects that enter data into HMIS, as well as any organizations operating residential continuum projects that are not participating in HMIS. This element is also used to identify organizations that are classified as Victim Service Providers (VSPs).
- **Data Collection Instruction:** <https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/project-descriptor-data-elements/201-organization-information/>

## 2.02 Project Information

- **Element Type:** Project Descriptor
- **Funder: Program-Component:** All Programs - All Components
- **Project Type Applicability:** All HMIS Project Types
- **Data Collected About:** All Projects
- **Collection Point:** Initial HMIS project setup, reviewed/updated no less than annually
- **System Logic and Other System Issues:** Projects funded with 2.06 Funding Source HUD: Pay for Success (35) and do not provide
- **CSV:** `Project and Affiliation`
- **Rationale:** To identify each project entering data into HMIS, as well as any residential continuum projects not participating in HMIS; and to associate each project with the specific type of lodging or services provided and the details about those project types. The 'Project ID' is used to link project descriptor information in other data elements to the specific project, and to link clients and their enrollment data to the project. Data related to project type is necessary to identify corresponding data collection requirements and for reporting purposes. The element also identifies whether the project is a continuum project, Rapid Re-Housing subtypes, and the relationship of a 'Services Only' project (or RRH: Services Only subtype) to a housing project as necessary. Finally, HOPWA-funded projects identify whether they are 'Medically Assisted Living Facilities' at this stage of project setup.
- **Data Collection Instruction:** <https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/project-descriptor-data-elements/202-project-information/>

## 2.03 Continuum of Care Information

- **Element Type:** Project Descriptor
- **Funder: Program-Component:** All Programs - All Components
- **Project Type Applicability:** All HMIS Project Types
- **Data Collected About:** All Continuum Projects
- **Collection Point:** Initial HMIS project setup, reviewed/updated no less than annually
- **System Logic and Other System Issues:** There is a many-to-one relationship between this data element and 2.02 Project Information; there
- **CSV:** `ProjectCoC`
- **Rationale:** To associate each project entering data into HMIS, as well as any residential continuum projects not participating in HMIS, with one or more Continuum of Care (CoC) for reporting and data exchange purposes.
- **Data Collection Instruction:** <https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/project-descriptor-data-elements/203-continuum-of-care-information/>

## 2.06 Funding Sources

- **Element Type:** Project Descriptor
- **Funder: Program-Component:** All Programs - All Components
- **Project Type Applicability:** All HMIS Project Types
- **Data Collected About:** All Projects
- **Collection Point:** Initial HMIS project setup, reviewed/updated no less than annually
- **System Logic and Other System Issues:** This is a transactional data element; a single project may have multiple current and historical
- **CSV:** `Funder`
- **Rationale:** To identify funding sources for each project entering data into HMIS, as well as any residential continuum projects not participating in HMIS, and associate projects with corresponding data collection requirements and reporting specifications.
- **Data Collection Instruction:** <https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/project-descriptor-data-elements/206-funding-sources/>

## 2.07 Bed and Unit Inventory Information

- **Element Type:** Project Descriptor
- **Funder: Program-Component:** All Programs - All Components
- **Project Type Applicability:** 0: Emergency Shelter - Entry Exit 1: Emergency Shelter - Night-by-Night 2: Transitional Housing 3: PH - Permanent Supportive Housing 8: Safe Haven 9: PH - Housing Only 10: PH - Housing with Services 13: PH - Rapid Re-Housing (subtype 2: RRH: Housing with or without services)
- **Data Collected About:** All Residential Projects, except for PH - Rapid Re-Housing subtype 1: RRH: Services Only
- **Collection Point:** Initial HMIS project setup reviewed at least annually and updated as needed to reflect changes.
- **System Logic and Other System Issues:** A project may have multiple current and historical records of inventory.
- **CSV:** `Inventory`
- **Rationale:** To record bed and unit inventory information for each residential project entering data into HMIS, as well as any residential continuum projects not participating in HMIS, for use in tracking utilization, data quality analysis, and reporting.
- **Data Collection Instruction:** <https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/project-descriptor-data-elements/207-bed-and-unit-inventory-information/>

## 2.08 HMIS Participation Status

- **Element Type:** Project Descriptor
- **Funder: Program-Component:** All Programs - All Components
- **Project Type Applicability:** All Project Types
- **Data Collected About:** All Projects
- **Collection Point:** Initial project setup reviewed at least annually and updated as needed to reflect changes.
- **System Logic and Other System Issues:** These fields must be transactional, meaning they must be able to record multiple values over
- **CSV:** `HMISParticipation`
- **Rationale:** To identify the HMIS or comparable database participation status of all Continuum projects.
- **Data Collection Instruction:** <https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/project-descriptor-data-elements/208-hmis-participation-status/>

## 2.09 Coordinated Entry Participation Status

- **Element Type:** Project Descriptor
- **Funder: Program-Component:** All Programs - All Components
- **Project Type Applicability:** All HMIS Project Types
- **Data Collected About:** All Projects
- **Collection Point:** Initial HMIS project setup, reviewed/updated no less than annually.
- **System Logic and Other System Issues:** These fields must be transactional, meaning they must be able to record multiple values over time.
- **CSV:** `CEParticipation`
- **Rationale:** The Coordinated Entry Participation Status is designed to identify a project’s type of engagement in the local Coordinated Entry System (CES). This element captures information about whether a project is an access point for the CES and if the project accepts referrals from the CES.
- **Data Collection Instruction:** <https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/project-descriptor-data-elements/209-coordinated-entry-participation-status/>

## 3.01 Name

- **Element Type:** Universal
- **Funder: Program-Component:** All Programs - All Components
- **Project Type Applicability:** All HMIS Project Types
- **Data Collected About:** All Clients
- **Collection Point:** Record Creation
- **System Logic and Other System Issues:** HMIS end users must be able to edit data to correct errors or reflect changes in client responses.
- **CSV:** `Client`
- **Rationale:** To support the unique identification of each person served.
- **Data Collection Instruction:** <https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/universal-data-elements/301-name/>

## 3.02 Social Security Number

- **Element Type:** Universal
- **Funder: Program-Component:** All Programs - All Components
- **Project Type Applicability:** All HMIS Project Types
- **Data Collected About:** All Clients
- **Collection Point:** Record Creation
- **System Logic and Other System Issues:** System stores collected nine-digit SSN in one field and the appropriate SSN data quality in
- **CSV:** `Client`
- **Rationale:** To support the unique identification of each person served.

  Where data is shared across projects, the Social Security Number (SSN) greatly facilitates the process of identifying clients who have been served and allows projects to avoid creating duplicate records at Project Start.

  Where data is not shared, CoCs rely on unique identifiers to produce an unduplicated count in the HMIS. Name and date of birth are useful unique identifiers, but the SSN is helpful for deduplicating clients where name and/or date of birth might be the same.

  Also, an important objective for ending homelessness is to increase access and utilization of mainstream programs by persons who are experiencing homelessness or are at-risk of homelessness. Since SSN is a required data element for many mainstream programs, projects may need the SSN to help their clients access mainstream services.
- **Data Collection Instruction:** <https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/universal-data-elements/302-social-security-number/>

## 3.03 Date of Birth

- **Element Type:** Universal
- **Funder: Program-Component:** All Programs - All Components
- **Project Type Applicability:** All HMIS Project Types
- **Data Collected About:** All Clients
- **Collection Point:** Record Creation
- **System Logic and Other System Issues:** System stores collected Date of Birth (DOB) in one field and the appropriate DOB data quality type
- **CSV:** `Client`
- **Rationale:** To calculate the age of persons served at the time of project start or at any point during project enrollment and to support the unique identification of each person served.
- **Data Collection Instruction:** <https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/universal-data-elements/303-date-of-birth/>

## 3.04 Race and Ethnicity

- **Element Type:** Universal
- **Funder: Program-Component:** All Programs - All Components
- **Project Type Applicability:** All HMIS Project Types
- **Data Collected About:** All Clients
- **Collection Point:** Record Creation
- **System Logic and Other System Issues:** An HMIS end user must be able to edit data to correct errors or reflect changes in client responses.
- **CSV:** `Client`
- **Rationale:** To indicate client’s self-identification with one or more different racial and/or ethnic categories. This data supports system planning, and local and national understanding of who is experiencing homelessness.
- **Data Collection Instruction:** <https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/universal-data-elements/304-race-and-ethnicity/>

## 3.07 Veteran Status

- **Element Type:** Universal
- **Funder: Program-Component:** All Programs - All Components
- **Project Type Applicability:** All HMIS Project Types
- **Data Collected About:** All Adults
- **Collection Point:** Record Creation
- **System Logic and Other System Issues:** An HMIS end user must be able to edit data to correct errors or reflect changes in client responses
- **CSV:** `Client`
- **Rationale:** To indicate whether clients have ever spent time in the United States Armed Forces and may be eligible for VA Homeless Programs. Allows for an accurate count of how many Veterans experience homelessness. Useful for screening for possible housing and service interventions and for gaining understanding of Veterans' service needs.
- **Data Collection Instruction:** <https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/universal-data-elements/307-veteran-status/>

## 3.08 Disabling Condition

- **Element Type:** Universal
- **Funder: Program-Component:** All Programs - All Components
- **Project Type Applicability:** All HMIS Project Types
- **Data Collected About:** All Clients
- **Collection Point:** Project start (Edit as necessary to reflect new information)
- **System Logic and Other System Issues:** An HMIS end user must be able to set the value of this data element to "Yes" independent of any
- **CSV:** `Enrollment`
- **Rationale:** To indicate whether clients have a disabling condition as defined below. This data element is to be used with other information to identify whether a client meets the criteria for experiencing chronic homelessness.
- **Data Collection Instruction:** <https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/universal-data-elements/308-disabling-condition/>

## 3.10 Project Start Date

- **Element Type:** Universal
- **Funder: Program-Component:** All Programs - All Components
- **Project Type Applicability:** All HMIS Project Types
- **Data Collected About:** All Clients
- **Collection Point:** Project Start
- **System Logic and Other System Issues:** The "project start date" must be exportable in the [date field] format.
- **CSV:** `Enrollment`
- **Rationale:** To determine the start of each client's period of participation with a project. All projects need this data element for reporting time spent participating in the project by a given client. Paired with 3.20 ‘Housing Move-In Date’, it becomes possible to determine the length of time from project start to housing placement for all clients accessing permanent housing.
- **Data Collection Instruction:** <https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/universal-data-elements/310-project-start-date/>

## 3.11 Project Exit Date

- **Element Type:** Universal
- **Funder: Program-Component:** All Programs - All Components
- **Project Type Applicability:** All HMIS Project Types
- **Data Collected About:** All Clients
- **Collection Point:** Project Exit
- **System Logic and Other System Issues:** The "project exit date" must be exportable in the [date field] format.
- **CSV:** `Exit`
- **Rationale:** To determine the end of a client's period of participation with a project. All projects need this data element for reporting time spent participating in the project.
- **Data Collection Instruction:** <https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/universal-data-elements/311-project-exit-date/>

## 3.12 Destination

- **Element Type:** Universal
- **Funder: Program-Component:** All Programs - All Components
- **Project Type Applicability:** All HMIS Project Types
- **Data Collected About:** All Clients
- **Collection Point:** Project Exit
- **System Logic and Other System Issues:** Dependent B has a 50-character limit when exporting in the HMIS CSV.
- **CSV:** `Exit`
- **Rationale:** To identify where a client will stay just after exiting a project for purposes of tracking and outcome measurement.
- **Data Collection Instruction:** <https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/universal-data-elements/312-destination/>

## 3.15 Relationship to Head of Household

- **Element Type:** Universal
- **Funder: Program-Component:** All Programs - All Components
- **Project Type Applicability:** All HMIS Project Types
- **Data Collected About:** All Clients
- **Collection Point:** Project Start
- **System Logic and Other System Issues:** There must be exactly one Head of Household for each household (3.15
- **CSV:** `Enrollment`
- **Rationale:** To identify one person to whom all other household members can be linked to at the time they enter a project. This facilitates the identification and enumeration of households. In addition, specifying the relationship of household members to the Head of Household facilitates reporting on household composition.
- **Data Collection Instruction:** <https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/universal-data-elements/315-relationship-to-head-of-household/>

## 3.16 Enrollment CoC

- **Element Type:** Universal
- **Funder: Program-Component:** All Programs - All Components
- **Project Type Applicability:** All HMIS Project Types
- **Data Collected About:** Head of Household
- **Collection Point:** Project Start
- **System Logic and Other System Issues:** All project stays must be associated with a single Continuum of Care code. This data element must
- **CSV:** `Enrollment`
- **Rationale:** To link client household data to the relevant CoC in which the assisting project operates. Necessary for projects that operate across multiple CoCs for data export purposes and to ensure accurate counts of persons who are served within a CoC. 
- **Data Collection Instruction:** <https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/universal-data-elements/316-enrollment-coc/>

## 3.20 Housing Move-In Date

- **Element Type:** Universal
- **Funder: Program-Component:** All Programs - All Permanent Housing Components
- **Project Type Applicability:** 3: PH - Permanent Supportive Housing 6: Services Only (VA: GPD CM/HR ONLY) 7: Other (Pay for Success ONLY) 9: PH - Housing Only 10: PH - Housing with Services (no disability required for entry)
- **Data Collected About:** Head of Household
- **Collection Point:** Occurrence Point: At move-in - must be entered if/when a household moves into any type of permanent housing, regardless of funding source or whether the project is providing the rental assistance to differentiate between clients who are housed and those who are experiencing homelessness at different points during their enrollment.
- **System Logic and Other System Issues:** Housing Move-In Date must be a date occurring either on or between the "project start date" and
- **CSV:** `Enrollment`
- **Rationale:** To document the date that a household moves into housing. This date differentiates households that have already moved into permanent housing from households that are still experiencing literal homelessness (in Emergency Shelter, Safe Haven, Transitional Housing, or on the street) as they prepare to move into an available unit. This is critical to Housing Inventory Count (HIC) and Point-in-Time (PIT) counts.
- **Data Collection Instruction:** <https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/universal-data-elements/320-housing-move-in-date/>

## 3.917A Prior Living Situation (A)

- **Element Type:** Universal
- **Funder: Program-Component:** All Programs - All Components which are typed as Street Outreach, Emergency Shelter - Entry Exit,
- **Project Type Applicability:** 0: Emergency Shelter - Entry Exit 1: Emergency Shelter - Night-by-Night 4: Street Outreach 8: Safe Haven
- **Data Collected About:** Head of Household and Adults
- **Collection Point:** Project Start Relationship to No more than one Living Situation per Enrollment Enrollment ID (an enrollment)
- **System Logic and Other System Issues:** This data element, 3.917A is required for all projects which are typed in an HMIS as Emergency
- **CSV:** `Enrollment`
- **Rationale:** To identify the type of living situation and length of stay in that situation immediately prior to project start for all adults and the Head of Household. This data element is used with other information to identify whether a client appears to meet the criteria for experiencing chronic homelessness at various points of enrollment (i.e., at the point of project entry, at a point during a project enrollment, or at any point over the course of a specified reporting period).
- **Data Collection Instruction:** <https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/universal-data-elements/3917-prior-living-situation/>

## 3.917B Prior Living Situation (B)

- **Element Type:** Universal
- **Funder: Program-Component:** All Programs - All Components
- **Project Type Applicability:** 2: Transitional Housing 3: PH - Permanent Supportive Housing (disability required for entry) 6: Services Only 7: Other 9: PH - Housing Only 10: PH - Housing with Services (no disability required for entry) 11: Day Shelter 12: Homelessness Prevention 13: PH - Rapid Re-Housing 14: Coordinated Entry
- **Data Collected About:** Head of Household and Adults
- **Collection Point:** Project Start
- **System Logic and Other System Issues:** This data element, 3.917B, is required for all project types in an HMIS other than Emergency Shelter
- **CSV:** `Enrollment`
- **Rationale:** To identify the type of living situation and length of stay in that situation immediately prior to project start for all adults and the Head of Household. This data element is used with other information to identify whether a client appears to meet the criteria for experiencing chronic homelessness at various points of enrollment (i.e., at the point of project entry, at a point during a project enrollment, or at any point over the course of a specified reporting period).
- **Data Collection Instruction:** <https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/universal-data-elements/3917-prior-living-situation/>

## 4.02 Income and Sources

- **Element Type:** Program Specific
- **Funder: Program-Component:** HUD: CoC - Collection required for all components except SSO Coordinated Entry
- **Project Type Applicability:** All HMIS Project Types
- **Data Collected About:** Head of Household and Adults
- **Collection Point:** Project Start, Update, Annual Assessment, and Project Exit
- **System Logic and Other System Issues:** The system must record the appropriate data collection stage for each record of this data element.
- **CSV:** `IncomeBenefits`
- **Rationale:** To determine whether households are accessing all income sources for which they are eligible at the time of project start and to allow for analyzing changes in income between project start, annual assessment, and exit.

  Increase in income is a key performance measure of most federal partner programs. Collecting income information throughout a project stay supports plans to link clients with all income sources and benefits for which they are eligible and helps CoCs improve system design and partnerships by analyzing cross-systems connections to ensure access to additional income sources.
- **Data Collection Instruction:** <https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/common-program-specific-data-elements/402-income-and-sources/>

## 4.03 Non-Cash Benefits

- **Element Type:** Program Specific
- **Funder: Program-Component:** HUD: CoC - Collection required for all components except SSO Coordinated Entry
- **Project Type Applicability:** All HMIS Project Types
- **Data Collected About:** Head of Household and Adults
- **Collection Point:** Project Start, Update, Annual Assessment, and Project Exit
- **System Logic and Other System Issues:** The system must record the appropriate data collection stage for each record of this data element.
- **CSV:** `IncomeBenefits`
- **Rationale:** To determine whether households are accessing all mainstream program benefits for which they are eligible at the time of project start and to allow for analyzing changes in the composition of non-cash benefits between project start and exit.
- **Data Collection Instruction:** <https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/common-program-specific-data-elements/403-non-cash-benefits/>

## 4.04 Health Insurance

- **Element Type:** Program Specific
- **Funder: Program-Component:** HUD: CoC - Collection required for all components except SSO Coordinated Entry
- **Project Type Applicability:** All HMIS Project Types
- **Data Collected About:** All Clients
- **Collection Point:** Project Start, Update, Annual Assessment, and Project Exit
- **System Logic and Other System Issues:** The system must record the appropriate collection stage for each record of this data element.
- **CSV:** `IncomeBenefits`
- **Rationale:** To determine whether clients are accessing all mainstream medical assistance benefits for which they may be eligible, and to ascertain a more complete picture of changes to economic circumstances between project start and exit.
- **Data Collection Instruction:** <https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/common-program-specific-data-elements/404-health-insurance/>

## 4.05 Physical Disability

- **Element Type:** Program Specific
- **Funder: Program-Component:** HUD: CoC - Collection required for all components except SSO Coordinated Entry
- **Project Type Applicability:** All HMIS Project Types
- **Data Collected About:** All Clients
- **Collection Point:** Project Start, Update, and Project Exit
- **System Logic and Other System Issues:** The system must record the appropriate data collection stage for each record of this data element.
- **CSV:** `Disabilities`
- **Rationale:** To indicate whether clients have a physical disability which contribute to their experience of homelessness or may be a factor in housing.
- **Data Collection Instruction:** <https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/common-program-specific-data-elements/405-physical-disability/>

## 4.06 Developmental Disability

- **Element Type:** Program Specific
- **Funder: Program-Component:** HUD: CoC - Collection required for all components except SSO Coordinated Entry
- **Project Type Applicability:** All HMIS Project Types
- **Data Collected About:** All Clients
- **Collection Point:** Project Start, Update, and Project Exit
- **System Logic and Other System Issues:** The system must record the appropriate data collection stage for each record of this data element.
- **CSV:** `Disabilities`
- **Rationale:** To indicate whether clients have a developmental disability which contributes to their experience of homelessness or may be a factor in housing.
- **Data Collection Instruction:** <https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/common-program-specific-data-elements/406-developmental-disability/>

## 4.07 Chronic Health Condition

- **Element Type:** Program Specific
- **Funder: Program-Component:** HUD: CoC - Collection required for all components except SSO Coordinated Entry
- **Project Type Applicability:** All HMIS Project Types
- **Data Collected About:** All Clients
- **Collection Point:** Project Start, Update, and Project Exit
- **System Logic and Other System Issues:** The system must record the appropriate collection stage for each data element. Systems must
- **CSV:** `Disabilities`
- **Rationale:** To indicate whether clients have any disabling special needs which contribute to their experience of homelessness or may be a factor in housing.
- **Data Collection Instruction:** <https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/common-program-specific-data-elements/407-chronic-health-condition/>

## 4.08 HIV/AIDS

- **Element Type:** Program Specific
- **Funder: Program-Component:** HUD: CoC - Collection required for all components except SSO Coordinated Entry
- **Project Type Applicability:** All HMIS Project Types
- **Data Collected About:** All Clients
- **Collection Point:** Project Start, Update, and Project Exit
- **System Logic and Other System Issues:** The system must record the appropriate data collection stage for each record of this data element.
- **CSV:** `Disabilities`
- **Rationale:** To indicate whether clients have HIV/AIDS which contributes to their experience of homelessness or may be a factor in housing.
- **Data Collection Instruction:** <https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/common-program-specific-data-elements/408-hivaids/>

## 4.09 Mental Health Disorder

- **Element Type:** Program Specific
- **Funder: Program-Component:** HUD: CoC - Collection required for all components except SSO Coordinated Entry
- **Project Type Applicability:** All HMIS Project Types
- **Data Collected About:** All Clients
- **Collection Point:** Project Start, Update, and Project Exit
- **System Logic and Other System Issues:** The system must record the appropriate data collection stage for each record of this data element.
- **CSV:** `Disabilities`
- **Rationale:** To indicate whether clients have any mental health disorders which contribute to their experience of homelessness or may be a factor in housing.
- **Data Collection Instruction:** <https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/common-program-specific-data-elements/409-mental-health-disorder/>

## 4.10 Substance Use Disorder

- **Element Type:** Program Specific
- **Funder: Program-Component:** HUD: CoC - Collection required for all components except SSO Coordinated Entry
- **Project Type Applicability:** All HMIS Project Types
- **Data Collected About:** All Clients
- **Collection Point:** Project Start, Update, and Project Exit
- **System Logic and Other System Issues:** The system must record the appropriate collection stage for each data element. Systems must allow
- **CSV:** `Disabilities`
- **Rationale:** To indicate whether clients have a substance use disorder which contributes to their experience of homelessness or may be a factor in housing.
- **Data Collection Instruction:** <https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/common-program-specific-data-elements/410-substance-use-disorder/>

## 4.11 Domestic Violence

- **Element Type:** Program Specific
- **Funder: Program-Component:** HUD: CoC - Collection required for all components except SSO Coordinated Entry
- **Project Type Applicability:** All HMIS Project Types
- **Data Collected About:** Head of Household and Adults
- **Collection Point:** Project Start, Update
- **System Logic and Other System Issues:** The system must record the appropriate collection stage for each data element. Systems must also
- **CSV:** `HealthAndDV`
- **Rationale:** To indicate whether the Head of Household and other adults served are survivors of domestic violence. Ascertaining whether a person is a survivor of or fleeing from domestic violence is necessary to provide the person with the appropriate services to prevent further abuse and to treat the physical and psychological injuries from prior abuse. Also, ascertaining that a person may be experiencing domestic violence may be important for the safety of project staff and other clients. At the aggregate level, knowing the size of the population of persons experiencing homelessness who have also experienced domestic violence is critical for determining the resources needed to address the problem.
- **Data Collection Instruction:** <https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/common-program-specific-data-elements/411-domestic-violence/>

## 4.12 Current Living Situation

- **Element Type:** Program Specific
- **Funder: Program-Component:** HUD: CoC - Collection required for SSO - Street Outreach, SSO - Coordinated Entry
- **Project Type Applicability:** 1: Emergency Shelter - Night-by-Night 4: Street Outreach 6: Services Only 14: Coordinated Entry (or other depending on CoC design of Coordinated Entry system)
- **Data Collected About:** Head of Household and Adults
- **Collection Point:** Occurrence Point (At the Time of Contact)
- **System Logic and Other System Issues:** The information recorded for this data element is transactional; each time there is a contact, a record
- **CSV:** `CurrentLivingSituation`
- **Rationale:** To record each contact with people experiencing homelessness by street outreach and other projects. This element provides information on the number of contacts required to engage the client as well as to document a current living situation each time the client is contacted.
- **Data Collection Instruction:** <https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/common-program-specific-data-elements/412-current-living-situation/>

## 4.13 Date of Engagement

- **Element Type:** Program Specific
- **Funder: Program-Component:** HUD: CoC - Collection only required for Street Outreach
- **Project Type Applicability:** 1: Emergency Shelter - Night-by-Night 4: Street Outreach 6: Services Only
- **Data Collected About:** Head of Household and Adults
- **Collection Point:** Occurrence Point (At the Point of Engagement)
- **System Logic and Other System Issues:** Only one Date of Engagement is allowed between the Project Start Date and Project Exit Date.
- **CSV:** `Enrollment`
- **Rationale:** To record the date the client became 'engaged' in project services after one or more contacts with a street outreach project or Night-by-Night shelter.
- **Data Collection Instruction:** <https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/common-program-specific-data-elements/413-date-of-engagement/>

## 4.14 Bed-Night Date

- **Element Type:** Program Specific
- **Funder: Program-Component:** HUD: ESG - Collection required for ES - NbN
- **Project Type Applicability:** 1: Emergency Shelter - Night-by-Night
- **Data Collected About:** All Clients
- **Collection Point:** Occurrence Point (As Provided)
- **System Logic and Other System Issues:** Collect once for each bed night utilized. A Bed-Night Date indicates that the client has utilized a bed
- **CSV:** `Services`
- **Rationale:** To determine each bed-night utilized by a client in a Night-by-Night (NbN) shelter.
- **Data Collection Instruction:** <https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/common-program-specific-data-elements/414-bed-night-date/>

## 4.19 Coordinated Entry Assessment

- **Element Type:** Program Specific
- **Funder: Program-Component:** HUD: CoC - Collection required for all components providing Coordinated Entry
- **Project Type Applicability:** 14: Coordinated Entry (or other depending on CoC design of Coordinated Entry system)
- **Data Collected About:** Head of Household
- **Collection Point:** At occurrence
- **System Logic and Other System Issues:** Field 2 - It is recommended that a list managed by an HMIS Administrator be used for this field. If
- **CSV:** `Assessment, AssessmentQuestions, AssessmentResults`
- **Rationale:** The CE Assessment element is a flexible data element that collects an assessment date, location, and result. It allows CoCs to define their own assessment questions and responses and categorizes each assessment into different types: Crisis Needs or Housing Needs. This data element is intended to standardize data collection on core components of Coordinated Entry like access, assessment, referral, and prioritization.
- **Data Collection Instruction:** <https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/common-program-specific-data-elements/419-coordinated-entry-assessment/>

## 4.20 Coordinated Entry Event

- **Element Type:** Program Specific
- **Funder: Program-Component:** HUD: CoC - Collection required for all components providing Coordinated Entry
- **Project Type Applicability:** 14: Coordinated Entry (or other depending on CoC design of Coordinated Entry system)
- **Data Collected About:** Head of Household
- **Collection Point:** At occurrence
- **System Logic and Other System Issues:** Because the collection point for this data element is "at occurrence," fields must be updateable over
- **CSV:** `Event`
- **Rationale:** The Coordinated Entry Event element is designed to capture key referral and placement events, as well as the results of those events. It will help communities understand the events that go into achieving desired (and undesired) results through the Coordinated Entry system. This data element is intended to standardize data collection on core components of Coordinated Entry like access, assessment, referral, and prioritization.
- **Data Collection Instruction:** <https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/common-program-specific-data-elements/420-coordinated-entry-event/>

## 4.21 Sex

- **Element Type:** Program Specific
- **Funder: Program-Component:** HUD: CoC - Collection required for all components
- **Project Type Applicability:** 0: Emergency Shelter - Entry Exit 1: Emergency Shelter - Night-by-Night 2: Transitional Housing
- **Data Collected About:** All Clients
- **Collection Point:** Record Creation
- **System Logic and Other System Issues:** An HMIS end user must be able to edit data to correct errors or reflect changes in client responses.
- **CSV:** `Client`
- **Rationale:** To create separate counts of females and males experiencing homelessness.
- **Data Collection Instruction:** <https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/common-program-specific-data-elements/421-sex/>

## C2 Moving On Assistance Provided

- **Element Type:** Program Specific
- **Funder: Program-Component:** HUD: CoC - Collection required for Permanent Supportive Housing
- **Project Type Applicability:** 3: PH - Permanent Supportive Housing (disability required for entry)
- **Data Collected About:** Head of Household
- **Collection Point:** Occurrence Point (as provided)
- **System Logic and Other System Issues:** Dependent A has a 50-character limit when exporting in the HMIS CSV.
- **CSV:** `Services`
- **Rationale:** To understand the type of moving on assistance provided to PSH participants.
- **Data Collection Instruction:** <https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/coc/c2-moving-on-assistance-provided/>

## C3 Youth Education Status

- **Element Type:** Program Specific
- **Funder: Program-Component:** HUD: CoC - Youth Homeless Demonstration Program (YHDP)
- **Project Type Applicability:** 2: Transitional Housing 3: PH - Permanent Supportive Housing (disability required for entry) 6: Services Only 13: PH - Rapid Re-Housing
- **Data Collected About:** Head of Household
- **Collection Point:** Project Start, Project Exit
- **System Logic and Other System Issues:** The system must record the appropriate collection stage for each data element.
- **CSV:** `YouthEducationStatus`
- **Rationale:** To determine whether youth Heads of Household are accessing educational programs at the time of project start and exit, and to allow for analyzing changes in education status of youth between project start and exit.
- **Data Collection Instruction:** <https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/coc/c3-youth-education-status/>

## W1 Services Provided - HOPWA

- **Element Type:** Program Specific
- **Funder: Program-Component:** HUD: HOPWA - Collection required for all components
- **Project Type Applicability:** 0: Emergency Shelter - Entry Exit 2: Transitional Housing 3: PH - Permanent Supportive Housing (disability required for entry) 6: Services Only 12: Homelessness Prevention
- **Data Collected About:** All clients receiving services
- **Collection Point:** Occurrence Point (As Provided)
- **System Logic and Other System Issues:** Data are time sensitive and may change over the project stay. Systems must allow for multiple
- **CSV:** `Services`
- **Rationale:** To determine the services provided to clients during project participation.
- **Data Collection Instruction:** <https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/hopwa/w1-services-provided-hopwa/>

## W2 Financial Assistance - HOPWA

- **Element Type:** Program Specific
- **Funder: Program-Component:** HUD: HOPWA - Collection required for PHP and STRMU only as indicated above
- **Project Type Applicability:** 6: Services Only 12: Homelessness Prevention
- **Data Collected About:** Head of Household
- **Collection Point:** Occurrence Point (As Provided)
- **System Logic and Other System Issues:** Data are time sensitive and may change over the project stay. Systems must allow for multiple
- **CSV:** `Services`
- **Rationale:** To track HOPWA financial assistance provided to clients in Permanent Housing Placement, Tenant-Based Rental Assistance (TBRA) or Short-Term Rent, Mortgage, and Utilities (STRMU) during project participation.
- **Data Collection Instruction:** <https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/hopwa/w2-financial-assistance-hopwa/>

## W3 Medical Assistance

- **Element Type:** Program Specific
- **Funder: Program-Component:** HUD: HOPWA - Collection required for all components
- **Project Type Applicability:** 0: Emergency Shelter - Entry Exit 2: Transitional Housing 3: PH - Permanent Supportive Housing (disability required for entry) 6: Services Only 12: Homelessness Prevention
- **Data Collected About:** All Household Members with HIV/AIDS
- **Collection Point:** Project Start, Update, Project Exit
- **System Logic and Other System Issues:** The system must record the appropriate collection stage for each data element. Systems must also
- **CSV:** `IncomeBenefits`
- **Rationale:** Medical assistance information is important to determine whether HIV positive clients in households served by all HOPWA component types are accessing medical assistance benefits for which they may be eligible. Medical Assistance (W3) is designed to collect information on assistance provided to clients with HIV/AIDS.
- **Data Collection Instruction:** <https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/hopwa/w3-medical-assistance/>

## W4 T-Cell (CD4) and Viral Load

- **Element Type:** Program Specific
- **Funder: Program-Component:** HUD: HOPWA - Collection required for all components
- **Project Type Applicability:** 0: Emergency Shelter - Entry Exit 2: Transitional Housing 3: PH - Permanent Supportive Housing (disability required for entry) 6: Services Only 12: Homelessness Prevention
- **Data Collected About:** All Household Members with HIV/AIDS
- **Collection Point:** Project Start, Update, Annual Assessment, Project Exit
- **System Logic and Other System Issues:** The system must record the appropriate collection stage for each data element. Systems must also
- **CSV:** `Disabilities`
- **Rationale:** To measure the extent to which housing impacts the health of persons with HIV/AIDS in households served by all HOPWA component types.
- **Data Collection Instruction:** <https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/hopwa/w4-t-cell-cd4-and-viral-load/>

## W5 Housing Assessment at Exit

- **Element Type:** Program Specific
- **Funder: Program-Component:** HUD: CoC - Collection required only for Homelessness Prevention component
- **Project Type Applicability:** 0: Emergency Shelter - Entry Exit 2: Transitional Housing 3: PH - Permanent Supportive Housing (disability required for entry) 6: Services Only 12: Homelessness Prevention
- **Data Collected About:** All Clients
- **Collection Point:** Project Exit
- **System Logic and Other System Issues:** System stores collected information as "project exit" information and retains for historical purposes.
- **CSV:** `Exit`
- **Rationale:** To determine whether clients exiting all HOPWA component types have remained stably housed.
- **Data Collection Instruction:** <https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/hopwa/w5-housing-assessment-at-exit/>

## W6 Prescribed Anti-Retroviral

- **Element Type:** Program Specific
- **Funder: Program-Component:** HUD: HOPWA - collection required for all components
- **Project Type Applicability:** 0: Emergency Shelter - Entry Exit 2: Transitional Housing 3: PH - Permanent Supportive Housing (disability required for entry) 6: Services Only 12: Homeless Prevention
- **Data Collected About:** All Household Members with HIV/AIDS
- **Collection Point:** Project Start, Update, Project Exit
- **System Logic and Other System Issues:** The system must record the appropriate collection stage for each data element. Systems must allow
- **CSV:** `Disabilities`
- **Rationale:** To measure the extent to which housing impacts participation in care for persons with HIV/AIDS in households served by all HOPWA component types.
- **Data Collection Instruction:** <https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/hopwa/w6-prescribed-anti-retroviral/>

## P1 Services Provided - PATH Funded

- **Element Type:** Program Specific
- **Funder: Program-Component:** HHS: PATH - Collection required for all components
- **Project Type Applicability:** 4: Street Outreach 6: Services Only
- **Data Collected About:** Head of Household and Adults
- **Collection Point:** Occurrence Point (As Provided)
- **System Logic and Other System Issues:** Data are time sensitive and may change over the project stay. Systems must allow for multiple
- **CSV:** `Services`
- **Rationale:** To determine the PATH-funded services that are provided to a client during and throughout project enrollment and prior to project exit.
- **Data Collection Instruction:** <https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/path/p1-services-provided-path-funded/>

## P2 Referrals Provided - PATH

- **Element Type:** Program Specific
- **Funder: Program-Component:** HHS: PATH - Collection required for all components
- **Project Type Applicability:** 4: Street Outreach 6: Services Only
- **Data Collected About:** Head of Household and Adults
- **Collection Point:** Occurrence Point (As Provided)
- **System Logic and Other System Issues:** Data are time sensitive and may change over the project stay. Systems must allow multiple records
- **CSV:** `Services`
- **Rationale:** To determine the referrals that are made on behalf of a client during project enrollment.
- **Data Collection Instruction:** [HMIS Data Standards: PATH: P2 Referrals Provided - HUD Exchange](https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/path/p2-referrals-provided-path/)

## P3 PATH Status

- **Element Type:** Program Specific
- **Funder: Program-Component:** HHS: PATH - Collection required for all components
- **Project Type Applicability:** 4: Street Outreach 6: Services Only
- **Data Collected About:** Head of Household and Adults
- **Collection Point:** Occurrence Point (At Determination; collect once, at or before exit, when the status is determined)
- **System Logic and Other System Issues:** Only one PATH status date and response is allowed for each project stay. If a client exits and returns
- **CSV:** `Enrollment`
- **Rationale:** To determine whether a client is eligible for the PATH program.
- **Data Collection Instruction:** <https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/path/p3-path-status/>

## P4 Connection with SOAR

- **Element Type:** Program Specific
- **Funder: Program-Component:** HHS: PATH - Collection required for all components
- **Project Type Applicability:** 4: Street Outreach 6: Services Only 12: Homelessness Prevention 13: PH - Rapid Re-Housing
- **Data Collected About:** Head of Household and Adults
- **Collection Point:** Project Start, Update, Annual Assessment, and Exit
- **System Logic and Other System Issues:** The system must record the appropriate collection stage for each data element. Systems must also
- **CSV:** `IncomeBenefits`
- **Rationale:** Connection with SOAR is intended to determine if the client has been connected to the SSI/SSDI Outreach, Access, and Recovery (SOAR) program, regardless of whether that connection was established by the PATH provider or not.
- **Data Collection Instruction:** [HMIS Data Standards: PATH: P4 Connection with SOAR - HUD Exchange](https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/path/p4-connection-with-soar/)

## R1 Referral Source

- **Element Type:** Program Specific
- **Funder: Program-Component:** HHS: RHY - Collection required for all components except for Street Outreach
- **Project Type Applicability:** 0: Emergency Shelter - Entry Exit 2: Transitional Housing 12: Homelessness Prevention
- **Data Collected About:** Head of Household and Adults
- **Collection Point:** Project Start
- **System Logic and Other System Issues:** System stores collected information as "project start" information and retains for historical purpose.
- **CSV:** `Enrollment`
- **Rationale:** Referral sources indicate the person, place or organization that referred the youth to the project they are entering.
- **Data Collection Instruction:** <https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/rhy/r1-referral-source/>

## R2 RHY - BCP Status

- **Element Type:** Program Specific
- **Funder: Program-Component:** HHS: RHY - Collection required for BCP only
- **Project Type Applicability:** 0: Emergency Shelter - Entry Exit 12: Homelessness Prevention
- **Data Collected About:** All Clients
- **Collection Point:** Project Start
- **System Logic and Other System Issues:** Only one RHY status date and only one response for "FYSB Youth' is allowed for each project stay. If a
- **CSV:** `Enrollment`
- **Rationale:** This element serves a three-fold purpose:

  Enables a BCP emergency shelter to record a youth that is not eligible under the FYSB-RHY program and collect information about them. Upon reporting to RHY for the federal transfer, RHY is then able to remove these youth from their program and congressional reports.
  Facilitates the local CoC and HMIS to utilize participation in BCP as part of their point-in-time and other counts and measures.
  Identifies the number of runaway youth.
- **Data Collection Instruction:** <https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/rhy/r2-rhy-bcp-status/>

## R4 Last Grade Completed

- **Element Type:** Program Specific
- **Funder: Program-Component:** HUD: HUD-VASH - Collection required for HUD/VASH Collaborative Case Management
- **Project Type Applicability:** 0: Emergency Shelter - Entry Exit 2: Transitional Housing 3: PH - Permanent Supportive Housing (disability required for entry) 12: Homelessness Prevention 13: PH - Rapid Re-Housing
- **Data Collected About:** Head of Household and Adults
- **Collection Point:** Project Start, Project Exit
- **System Logic and Other System Issues:** System stores collected information as "project start" or "project exit" information and retains for
- **CSV:** `EmploymentEducation`
- **Rationale:** The purpose is to identify the educational attainment of youth served in RHY projects as well as, when appropriate, measure a change in education from project start to project exit for all Heads of Household and youth.
- **Data Collection Instruction:** <https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/rhy/r4-last-grade-completed/>

## R5 School Status

- **Element Type:** Program Specific
- **Funder: Program-Component:** HHS: RHY - Collection required for all components except for Street Outreach
- **Project Type Applicability:** 0: Emergency Shelter - Entry Exit 2: Transitional Housing 12: Homelessness Prevention
- **Data Collected About:** Head of Household and Adults
- **Collection Point:** Project Start, Project Exit
- **System Logic and Other System Issues:** System stores collected information as "project start" or "project exit" information and retains for
- **CSV:** `EmploymentEducation`
- **Rationale:** The purpose is to identify the educational status of youth served in RHY projects as well as, when appropriate, measure a change in school status from project start to project exit for all Heads of Household and youth.
- **Data Collection Instruction:** <https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/rhy/r5-school-status/>

## R6 Employment Status

- **Element Type:** Program Specific
- **Funder: Program-Component:** HUD: HUD-VASH - Collection required for HUD/VASH Collaborative Case Management
- **Project Type Applicability:** 0: Emergency Shelter - Entry Exit 2: Transitional Housing 3: PH - Permanent Supportive Housing (disability required for entry) 6: Services Only 8: Safe Haven 9: PH - Housing Only 12: Homelessness Prevention 13: PH - Rapid Re-Housing
- **Data Collected About:** Head of Household and Adults
- **Collection Point:** Project Start, Project Exit
- **System Logic and Other System Issues:** The system must record the appropriate collection stage for each data element. System stores
- **CSV:** `EmploymentEducation`
- **Rationale:** The purpose is to assess a client’s employment status and need for employment services as well as, when appropriate, measure a change in employment from project start to project exit for all Heads of Household and adults.
- **Data Collection Instruction:** <https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/rhy/r6-employment-status/>

## R7 General Health Status

- **Element Type:** Program Specific
- **Funder: Program-Component:** HUD: HUD-VASH - Collection required for HUD/VASH Collaborative Case Management
- **Project Type Applicability:** 0: Emergency Shelter - Entry Exit
- **Data Collected About:** Head of Household and Adults
- **Collection Point:** Project Start, Project Exit
- **System Logic and Other System Issues:** System stores collected information as "project start" or "project exit" information and retains for
- **CSV:** `HealthAndDV`
- **Rationale:** Information on health status (general health, dental health, and mental health) is a first step to identifying what types of health services a client may need. This element permits comparison between homeless youth to other youth their age as well as measure a change in status from project start to project exit for all Heads of Household and adults.
- **Data Collection Instruction:** <https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/rhy/r7-general-health-status/>

## R8 Dental Health Status

- **Element Type:** Program Specific
- **Funder: Program-Component:** HHS: RHY - Collection required for all components except for Street Outreach
- **Project Type Applicability:** 0: Emergency Shelter - Entry Exit 2: Transitional Housing 12: Homelessness Prevention
- **Data Collected About:** Head of Household and Adults
- **Collection Point:** Project Start, Project Exit
- **System Logic and Other System Issues:** System stores collected information as "project start" or ‘project exit" information and retains for
- **CSV:** `HealthAndDV`
- **Rationale:** Information on health status (general health, dental health, and mental health) is a first step to identifying what types of health services a client may need. This element permits comparison between homeless youth to other youth their age as well as measure a change in status from project start to project exit for all Heads of Household and adults.
- **Data Collection Instruction:** <https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/rhy/r8-dental-health-status/>

## R9 Mental Health Status

- **Element Type:** Program Specific
- **Funder: Program-Component:** HHS: RHY - Collection required for all components except for Street Outreach
- **Project Type Applicability:** 0: Emergency Shelter - Entry Exit 2: Transitional Housing 12: Homelessness Prevention
- **Data Collected About:** Head of Household and Adults
- **Collection Point:** Project Start, Project Exit
- **System Logic and Other System Issues:** System stores collected information as "project start" or "project exit" information and retains for
- **CSV:** `HealthAndDV`
- **Rationale:** Information on health status (general health, dental health, and mental health) is a first step to identifying what types of health services a client may need. This element permits comparison between homeless youth to other youth their age as well as measure a change in status from project start to project exit for all Heads of Household and adults.
- **Data Collection Instruction:** <https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/rhy/r9-mental-health-status/>

## R10 Pregnancy Status

- **Element Type:** Program Specific
- **Funder: Program-Component:** HHS: RHY - Collection required for all components
- **Project Type Applicability:** 0: Emergency Shelter - Entry Exit 2: Transitional Housing 4: Street Outreach 12: Homelessness Prevention
- **Data Collected About:** Head of Household and Adults
- **Collection Point:** Project Start, Update
- **System Logic and Other System Issues:** Data is time sensitive and may change over the project stay. System must allow for updated
- **CSV:** `HealthAndDV`
- **Rationale:** The purpose is to determine the number of people starting projects while pregnant and to determine eligibility for benefits and need for services.
- **Data Collection Instruction:** <https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/rhy/r10-pregnancy-status/>

## R11 Formerly a Ward of Child Welfare/Foster Care Agency

- **Element Type:** Program Specific
- **Funder: Program-Component:** HHS: RHY - Collection required for all components except for Street Outreach
- **Project Type Applicability:** 0: Emergency Shelter - Entry Exit 2: Transitional Housing 12: Homelessness Prevention
- **Data Collected About:** Head of Household and Adults
- **Collection Point:** Project Start
- **System Logic and Other System Issues:** System stores collected information as "project start" information and retains for historical purpose.
- **CSV:** `Enrollment`
- **Rationale:** The purpose is to identify clients with child welfare or foster care histories.
- **Data Collection Instruction:** <https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/rhy/r11-formerly-a-ward-of-child-welfarefoster-care-agency/>

## R12 Formerly a Ward of Juvenile Justice System

- **Element Type:** Program Specific
- **Funder: Program-Component:** HHS: RHY - Collection required for all components except for Street Outreach
- **Project Type Applicability:** 0: Emergency Shelter - Entry Exit 2: Transitional Housing 12: Homelessness Prevention
- **Data Collected About:** Head of Household and Adults
- **Collection Point:** Project Start
- **System Logic and Other System Issues:** System stores collected information as "project start" information and retains for historical purpose.
- **CSV:** `Enrollment`
- **Rationale:** The purpose is to identify clients with juvenile justice system history.
- **Data Collection Instruction:** <https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/rhy/r12-formerly-a-ward-of-juvenile-justice-system/>

## R13 Family Critical Issues

- **Element Type:** Program Specific
- **Funder: Program-Component:** HHS: RHY - Collection required for all components except for Street Outreach
- **Project Type Applicability:** 0: Emergency Shelter - Entry Exit 2: Transitional Housing 12: Homelessness Prevention
- **Data Collected About:** Head of Household and Adults
- **Collection Point:** Project Start
- **System Logic and Other System Issues:** System stores collected information as "project start" information and retains for historical purpose.
- **CSV:** `Enrollment`
- **Rationale:** The purpose is to identify specific family issues faced by youth in RHY programs that may have contributed to the youth’s homelessness or is a factor in family reunification.
- **Data Collection Instruction:** <https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/rhy/r13-family-critical-issues/>

## R14 RHY Service Connections

- **Element Type:** Program Specific
- **Funder: Program-Component:** HHS: RHY - Collection required for components as outlined in the source table
- **Project Type Applicability:** 0: Emergency Shelter - Entry Exit 2: Transitional Housing 6: Services Only 12: Homelessness Prevention
- **Data Collected About:** Head of Household and Adults
- **Collection Point:** Occurrence Point (At First Service)
- **System Logic and Other System Issues:** Data is time sensitive and may change over the project stay. The system must allow for
- **CSV:** `Services`
- **Rationale:** The RHY service connections enable projects to report on the services that they either directly provided to youth through their project or at their organization or which they facilitated being provided by another provider during the project stay for all Heads of Household and adults.
- **Data Collection Instruction:** <https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/rhy/r14-rhy-service-connections/>

## R15 Commercial Exploitation/Trafficking

- **Element Type:** Program Specific
- **Funder: Program-Component:** HHS: RHY - Collection required for all components
- **Project Type Applicability:** 0: Emergency Shelter - Entry Exit 2: Transitional Housing 4: Street Outreach 12: Homelessness Prevention
- **Data Collected About:** Head of Household and Adults
- **Collection Point:** Project Exit
- **System Logic and Other System Issues:** System stores collected information as project exit information and retains it for historical purposes. HMIS may be programmed to display dependent questions only when the HMIS end user selects the appropriate response. If mouse-over or hover functionality is available, RHY requests the explanatory wording provided for Field 1, Dependent B, and Dependent C in the data element table.
- **CSV:** `Exit`
- **Rationale:** The purpose is to assess the extent of sexual exploitation among youth experiencing homelessness.
- **Data Collection Instruction:** <https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/rhy/r15-commercial-sexual-exploitationsex-trafficking/>

## R16 Labor Exploitation/Trafficking

- **Element Type:** Program Specific
- **Funder: Program-Component:** HHS: RHY - Collection required for all components
- **Project Type Applicability:** 0: Emergency Shelter - Entry Exit 2: Transitional Housing 4: Street Outreach
- **Data Collected About:** Head of Household and Adults
- **Collection Point:** Project Exit
- **System Logic and Other System Issues:** System stores collected information as "project exit" information and retains for historical
- **CSV:** `Exit`
- **Rationale:** The purpose is to assess the extent of labor exploitation among youth experiencing homelessness.
- **Data Collection Instruction:** <https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/rhy/r16-labor-exploitationtrafficking/>

## R17 Project Completion Status

- **Element Type:** Program Specific
- **Funder: Program-Component:** HHS: RHY - Collection required for all components except for Street Outreach and BCP- Prevention
- **Project Type Applicability:** 0: Emergency Shelter - Entry Exit 2: Transitional Housing
- **Data Collected About:** Head of Household and Adults
- **Collection Point:** Project Exit
- **System Logic and Other System Issues:** System stores collected information as "project exit" information and retains for historical
- **CSV:** `Exit`
- **Rationale:** The purpose is to identify whether the youth completed the project or exited without completion. This data is only collected on heads of household and adults at project exit.
- **Data Collection Instruction:** <https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/rhy/r17-project-completion-status/>

## R18 Counseling

- **Element Type:** Program Specific
- **Funder: Program-Component:** HHS: RHY - Collection required for all components except for Street Outreach
- **Project Type Applicability:** 0: Emergency Shelter - Entry Exit 2: Transitional Housing 12: Homelessness Prevention
- **Data Collected About:** Head of Household and Adults
- **Collection Point:** Project Exit
- **System Logic and Other System Issues:** System stores collected information as "project exit" information and retains for historical
- **CSV:** `Exit`
- **Rationale:** The purpose of this element is to identify the type and amount of counseling received by adults and Heads of Household enrolled in RHY projects.
- **Data Collection Instruction:** <https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/rhy/r18-counseling/>

## R19 Safe and Appropriate Exit

- **Element Type:** Program Specific
- **Funder: Program-Component:** HHS: RHY - Collection required for all components except for Street Outreach and Homelessness Prevention
- **Project Type Applicability:** 0: Emergency Shelter - Entry Exit 2: Transitional Housing
- **Data Collected About:** Head of Household and Adults
- **Collection Point:** Project Exit
- **System Logic and Other System Issues:** System stores collected information as "project exit" information and retains for historical
- **CSV:** `Exit`
- **Rationale:** The purpose of this element is to determine the number of youth who exited to safe and appropriate destinations as determined by the youth (Head of Household and adult) themselves and as determined by the project/caseworker.
- **Data Collection Instruction:** <https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/rhy/r19-safe-and-appropriate-exit/>

## R20 Aftercare Plans

- **Element Type:** Program Specific
- **Funder: Program-Component:** HHS: RHY - Collection required for all components except for Street Outreach
- **Project Type Applicability:** 0: Emergency Shelter - Entry Exit 2: Transitional Housing 12: Homelessness Prevention
- **Data Collected About:** Head of Household and Adults
- **Collection Point:** Post Exit
- **System Logic and Other System Issues:** Information may be entered post exit for a period of up to 180 days after which point no data
- **CSV:** `Exit`
- **Rationale:** The purpose is to identify the extent of aftercare plans which were executed post-exit from the project.
- **Data Collection Instruction:** <https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/rhy/r20-aftercare-plans/>

## V1 Veteran's Information

- **Element Type:** Program Specific
- **Funder: Program-Component:** HUD: HUD-VASH - Collection required for all components VA: SSVF - Collection required for RRH and Homelessness Prevention VA: GPD - Collection required for all components VA: Community Contract Safe Haven VA: CRS Contract Residential Services
- **Project Type Applicability:** 0: Emergency Shelter - Entry Exit 2: Transitional Housing 3: PH - Permanent Supportive Housing (disability required for entry) 6: Supportive Services Only 8: Safe Haven 9: PH - Housing Only 12: Homelessness Prevention 13: PH - Rapid Re-Housing
- **Data Collected About:** All Veterans
- **Collection Point:** Record Creation
- **System Logic and Other System Issues:** None
- **CSV:** `Client`
- **Data Collection Instruction:** <https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/va/v1-veterans-information/>

## V2 Services Provided - SSVF

- **Element Type:** Program Specific
- **Funder: Program-Component:** VA: SSVF - Collection required for RRH and Homelessness Prevention
- **Project Type Applicability:** 12: Homelessness Prevention 13: PH - Rapid Re-Housing
- **Data Collected About:** All Clients receiving services
- **Collection Point:** Occurrence Point (As Provided)
- **System Logic and Other System Issues:** Services will be recorded as they are provided. The system must allow for a theoretically
- **CSV:** `Services`
- **Data Collection Instruction:** <https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/va/v2-services-provided-ssvf/>

## V3 Financial Assistance - SSVF

- **Element Type:** Program Specific
- **Funder: Program-Component:** VA: SSVF - Collection required for RRH and Homelessness Prevention
- **Project Type Applicability:** 12: Homelessness Prevention 13: PH - Rapid Re-Housing
- **Data Collected About:** All Clients receiving financial assistance
- **Collection Point:** Occurrence Point (As Provided)
- **System Logic and Other System Issues:** Both the Date Provided and the Start Date of Financial Services are required, even if they are
- **CSV:** `Services`
- **Data Collection Instruction:** <https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/va/v3-financial-assistance-ssvf/>

## V4 Percent of AMI (SSVF Eligibility)

- **Element Type:** Program Specific
- **Funder: Program-Component:** VA: SSVF - Collection required for RRH and Homelessness Prevention
- **Project Type Applicability:** 12: Homelessness Prevention 13: PH - Rapid Re-Housing
- **Data Collected About:** Head of Household
- **Collection Point:** Project Start
- **System Logic and Other System Issues:** System stores collected information as "project start" information and retains for historical
- **CSV:** `Enrollment`
- **Data Collection Instruction:** <https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/va/v4-percent-of-ami-ssvf-eligibility/>

## V6 VAMC Station Number

- **Element Type:** Program Specific
- **Funder: Program-Component:** HUD: HUD-VASH - Collection required for all components VA: SSVF - Collection required for RRH and Homelessness Prevention VA: GPD - Collection required for all components VA: CRS Contract Residential Services VA: Community Contract Safe Haven Program
- **Project Type Applicability:** 0: Emergency Shelter - Entry Exit 2: Transitional Housing 3: PH - Permanent Supportive Housing (disability required for entry) 6: Services Only 8: Safe Haven 9: PH - Housing Only 12: Homelessness Prevention 13: PH - Rapid Re-Housing
- **Data Collected About:** Head of Household
- **Collection Point:** Project Start
- **System Logic and Other System Issues:** Valid VAMC Station Numbers are up to 8 alphanumeric characters and should correspond to
- **CSV:** `Enrollment`
- **Data Collection Instruction:** <https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/va/v6-vamc-station-number/>

## V7 HP Targeting Criteria

- **Element Type:** Program Specific
- **Funder: Program-Component:** VA: SSVF - Collection required for Homelessness Prevention
- **Project Type Applicability:** 12: Homelessness Prevention
- **Data Collected About:** Head of Household
- **Collection Point:** Project Start
- **System Logic and Other System Issues:** Records must be editable for users to correct data entry errors.
- **CSV:** `Enrollment`
- **Data Collection Instruction:** <https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/va/v7-hp-targeting-criteria/>

## V8 HUD-VASH Voucher Tracking

- **Element Type:** Program Specific
- **Funder: Program-Component:** HUD: HUD-VASH - Collection required for HUD/VASH Collaborative Case Management
- **Project Type Applicability:** 3: PH - Permanent Supportive Housing (disability required for entry)
- **Data Collected About:** Head of Household/Veteran
- **Collection Point:** Occurrence Point (as provided)
- **System Logic and Other System Issues:** There may be only one response per Information Date.
- **CSV:** `Services`
- **Data Collection Instruction:** <https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/va/v8-hud-vash-voucher-tracking/>

## V9 HUD-VASH Exit Information

- **Element Type:** Program Specific
- **Funder: Program-Component:** HUD: HUD-VASH - Collection required for HUD/VASH Collaborative Case Management
- **Project Type Applicability:** 3: PH - Permanent Supportive Housing (disability required for entry)
- **Data Collected About:** Head of Household/Veteran
- **Collection Point:** Project Exit
- **System Logic and Other System Issues:** The system must record the appropriate collection stage for each data element.
- **CSV:** `Exit`
- **Data Collection Instruction:** <https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/va/v9-hud-vash-exit-information/>

## V10 Mental Health Consultation

- **Element Type:** Program Specific
- **Funder: Program-Component:** VA: SSVF - Collection required for RRH and Homelessness Prevention VA: Grant Per Diem - Case Management/Housing Retention
- **Project Type Applicability:** 6: Services Only 12: Homelessness Prevention 13: PH - Rapid Re-Housing
- **Data Collected About:** All Veterans
- **Collection Point:** Project Start
- **System Logic and Other System Issues:** Only one Mental Health Consultation Status is allowed for each project stay. If a client returns
- **CSV:** `Enrollment`
- **Data Collection Instruction:** <https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/va/v10-mental-health-consultation/>

## 5.01 Date Created

- **Element Type:** Metadata
- **Funder: Program-Component:** All Programs - All Components
- **Project Type Applicability:** All HMIS Project Types
- **Data Collected About:** All Records
- **Collection Point:** Record Creation
- **System Logic and Other System Issues:** HMIS auto-generated. An HMIS must have the ability to identify the date on which a record
- **CSV:** `<*><DateCreated> (Field collected across multiple files)`
- **Data Collection Instruction:** <https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/metadata-elements/501-date-created/>

## 5.02 Date Updated

- **Element Type:** Metadata
- **Funder: Program-Component:** All Programs - All Components
- **Project Type Applicability:** All HMIS Project Types
- **Data Collected About:** All Data Elements
- **Collection Point:** Record Creation / Edit
- **System Logic and Other System Issues:** HMIS auto-generated. Created by the HMIS when a record for any data element is first created
- **CSV:** `<*><DateUpdated> (Field collected across multiple files)`
- **Data Collection Instruction:** <https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/metadata-elements/502-date-updated/>

## 5.03 Data Collection Stage

- **Element Type:** Metadata
- **Funder: Program-Component:** All Programs - All Components
- **Project Type Applicability:** All HMIS Project Types
- **Data Collected About:** All Data Elements with multiple data collection stages
- **Collection Point:** Client Data Entry of Specified Elements
- **System Logic and Other System Issues:** HMIS auto-generated or HMIS end user selected. An HMIS must be able to distinguish between
- **CSV:** `<*><DataCollectionStage> (Field collected across multiple files)`
- **Data Collection Instruction:** <https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/metadata-elements/503-data-collection-stage/>

## 5.04 Information Date

- **Element Type:** Metadata
- **Funder: Program-Component:** All Programs - All Components
- **Project Type Applicability:** All HMIS Project Types
- **Data Collected About:** As Specified in Data Element Definitions
- **Collection Point:** Client Program-Specific Data Entry
- **System Logic and Other System Issues:** This Metadata Element is a hybrid in that it pertains to the client data and not directly to the
- **CSV:** `<*><InformationDate> (Field collected across multiple files)`
- **Data Collection Instruction:** <https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/metadata-elements/504-information-date/>

## 5.05 Project Identifier

- **Element Type:** Metadata
- **Funder: Program-Component:** All Programs - All Components
- **Project Type Applicability:** All HMIS Project Types
- **Data Collected About:** Specified Data Elements
- **Collection Point:** Record Creation/Edit
- **System Logic and Other System Issues:** HMIS auto-generated or HMIS end user selected. If this is HMIS end user selected, HMIS
- **CSV:** `<*><ProjectID> (Field collected across multiple files)`
- **Data Collection Instruction:** <https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/metadata-elements/505-project-identifier/>

## 5.06 Enrollment Identifier

- **Element Type:** Metadata
- **Funder: Program-Component:** All Programs - All Components
- **Project Type Applicability:** All HMIS Project Types
- **Data Collected About:** All Enrollment Level Data
- **Collection Point:** Record Creation
- **System Logic and Other System Issues:** HMIS auto-generated. The data element should be created by the HMIS at the time that the
- **CSV:** `<*><EnrollmentID> (Field collected across multiple files)`
- **Data Collection Instruction:** <https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/metadata-elements/506-enrollment-identifier/>

## 5.07 User Identifier

- **Element Type:** Metadata
- **Funder: Program-Component:** All Programs - All Components
- **Project Type Applicability:** All HMIS Project Types
- **Data Collected About:** All Records
- **Collection Point:** All Data Collection Points/Stages
- **System Logic and Other System Issues:** HMIS generated. Each HMIS end user must have a unique identifier stored in the HMIS. Every
- **CSV:** `<*><UserID> (Field collected across multiple files)`
- **Data Collection Instruction:** <https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/metadata-elements/507-user-identifier/>

## 5.08 Personal Identifier

- **Element Type:** Metadata
- **Funder: Program-Component:** All Programs - All Components
- **Project Type Applicability:** All HMIS Project Types
- **Data Collected About:** All Clients
- **Collection Point:** Record Creation
- **System Logic and Other System Issues:** The purpose of this data element is to ensure that, regardless of how many client records
- **CSV:** `Client`
- **Data Collection Instruction:** <https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/metadata-elements/508-personal-identifier/>

## 5.09 Household Identifier

- **Element Type:** Metadata
- **Funder: Program-Component:** All Programs - All Components
- **Project Type Applicability:** All HMIS Project Types
- **Data Collected About:** All Clients
- **Collection Point:** Project Start
- **System Logic and Other System Issues:** A Household ID will be assigned to each household at each project start and applies for the
- **CSV:** `Enrollment`
- **Data Collection Instruction:** <https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/metadata-elements/509-household-identifier/>

## 5.10 Implementation Identifier

- **Element Type:** Metadata
- **Funder: Program-Component:** Not specified in data element table
- **Project Type Applicability:** Not specified in data element table
- **Data Collected About:** All HMIS Implementations
- **Collection Point:** Upon creation of HMIS implementation
- **System Logic and Other System Issues:** The purpose of Implementation ID is to indicate the scope of uniqueness of the primary keys
- **CSV:** `Export`
- **Data Collection Instruction:** <https://www.hudexchange.info/programs/hmis/hmis-data-standards/standards/metadata-elements/510-implementation-identifier/>
