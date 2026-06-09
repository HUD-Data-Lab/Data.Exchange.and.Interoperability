
## Overview

The HMIS API toolchain generates OpenAPI specifications, JSON-LD contexts, and Mockoon configurations from YAML-LD ontology files. This guide shows you how to create **custom templates** for specific use cases (e.g., state Medicaid billing forms) not covered by baseline HUD scenarios.

**Use this guide when:**

- Your community needs a custom data exchange format
- State/local requirements differ from federal standards
- You want to generate forms or reports from HMIS data
- You're building integrations with non-HMIS systems

---

## Prerequisites

- Python 3.9+ installed
- Basic familiarity with YAML syntax
- Access to HMIS data element documentation
- The `hmis-codegen` toolchain installed

```bash
# Install the toolchain
pip install hmis-codegen
```

---

## Quick-Start: Create a Custom Template in 5 Steps

### Step 1: Identify Your Data Requirements

**Answer these questions:**

1. What HMIS data elements do you need? (e.g., PersonalID, VeteranStatus, EntryDate)
2. What external data is required? (e.g., state-specific fields, MCO identifiers)
3. What format is the output? (JSON, CSV, PDF form fields, API endpoint)

**Example scenario:** California Medicaid billing requires PersonalID, DOB, EnrollmentID, and MCO Plan ID (not in HMIS).

---

### Step 2: Create Your Template File

Templates live in `hmis-codegen/templates/custom/`.

**Create:** `templates/custom/ca_medicaid_billing.yaml`

```yaml
# Template metadata
template:
  name: "California Medicaid Billing Export"
  version: "1.0"
  description: "Generates billing data for CA MCOs from HMIS enrollment records"
  output_format: "json"  # Options: json, csv, xml, api_endpoint

# Map HMIS data elements to template fields <!-- REVIEW: So we would need to define each data element? Would the data element number be helpful? -->
fields:
  # Standard HMIS fields (from ontology)
  - hmis_element: "PersonalID"
    output_field: "client_id"
    required: true
    
  - hmis_element: "DOB"
    output_field: "date_of_birth"
    required: true
    format: "MM/DD/YYYY"  # Override default ISO format
    
  - hmis_element: "EnrollmentID"
    output_field: "enrollment_id"
    required: true
  
  - hmis_element: "EntryDate"
    output_field: "service_start_date"
    required: true
  
  # Custom fields (not in HMIS ontology)
  custom_fields:
    - name: "mco_plan_id"
      type: "string"
      description: "Managed Care Organization Plan Identifier"
      required: true
      source: "manual_entry"  # Options: manual_entry, lookup_table, computed
    
    - name: "billing_code"
      type: "string"
      description: "CA Medicaid billing code for RRH services"
      required: true
      default: "H0043"  # Housing support services code

# Validation rules
validation:
  - rule: "DOB must be in the past"
    field: "date_of_birth"
  - rule: "service_start_date must match HMIS EntryDate"
    fields: ["service_start_date", "EntryDate"]
```

---

### Step 3: Generate Your Template Output

Run the toolchain generator:

```bash
# Generate JSON output file
python -m hmis_codegen generate-template \
  --template templates/custom/ca_medicaid_billing.yaml \
  --ontology ontology/hmis_ontology.jsonld \
  --output-format json \
  --output ./output/ca_medicaid_billing_template.json

# Generate API endpoint spec (adds to OpenAPI spec)
python -m hmis_codegen generate-template \
  --template templates/custom/ca_medicaid_billing.yaml \
  --ontology ontology/hmis_ontology.jsonld \
  --output-format api_endpoint \
  --output ./output/hmis_api_extended.yaml
```

**What this creates:**

- `ca_medicaid_billing_template.json` - Sample output structure
- `hmis_api_extended.yaml` - OpenAPI spec with new `/billing/ca-medicaid` endpoint
- `ca_medicaid_context.jsonld` - JSON-LD context for semantic validation

---

### Step 4: Test Your Template

Use the generated Mockoon configuration for testing:

```bash
# Generate Mockoon mock server
python -m hmis_codegen generate-mockoon \
  --template templates/custom/ca_medicaid_billing.yaml \
  --output ./mockoon/ca_medicaid_mock.json

# Start Mockoon (requires Mockoon CLI)
mockoon-cli start --data ./mockoon/ca_medicaid_mock.json
```

**Test the endpoint:**

```bash
curl http://localhost:3000/api/v1/billing/ca-medicaid?PersonalID=12345
```

---

### Step 5: Deploy and Document

**For community use:**

1. Share the template YAML file with your HMIS Lead
2. Include instructions for populating custom fields (e.g., MCO Plan ID lookup)
3. Document any manual data entry requirements

**For vendor integration:**

1. Add the generated API endpoint to your HMIS vendor's API
2. Configure field mappings in your HMIS admin interface
3. Set up automated export schedules

---

## Advanced: Custom Validation Rules

Add business logic to your templates:

```yaml
validation:
  # Conditional requirements
  - rule: "If VeteranStatus = Yes, require YearEnteredService"
    condition:
      field: "VeteranStatus"
      value: 1  # Yes
    then_require: ["YearEnteredService"]
  
  # Cross-field validation
  - rule: "service_end_date must be after service_start_date"
    type: "date_range"
    fields: ["service_start_date", "service_end_date"]
  
  # External API validation
  - rule: "Validate MCO Plan ID against state registry"
    field: "mco_plan_id"
    validation_endpoint: "https://ca.gov/api/validate-mco"
    cache_duration: "24h"
```

---

## Template Directory Structure

Organize templates by jurisdiction and use case:

```
hmis-codegen/
├── templates/
│   ├── federal/          # HUD baseline scenarios (don't modify)
│   ├── custom/
│   │   ├── ca/           # California-specific
│   │   │   ├── medicaid_billing.yaml
│   │   │   └── calworks_reporting.yaml
│   │   ├── ny/           # New York-specific
│   │   └── shared/       # Multi-state templates
│   └── examples/         # Sample templates for learning
```

---

## Common Use Cases

### 1. State Medicaid Billing

**Template:** `templates/custom/{state}/medicaid_billing.yaml` **Outputs:** JSON for MCO submission, PDF form generation

### 2. CoC Custom Reporting

**Template:** `templates/custom/{coc_code}/quarterly_report.yaml` **Outputs:** CSV for data warehouse, Excel-ready format

### 3. Healthcare System Integration

**Template:** `templates/custom/healthcare/fhir_care_plan.yaml` **Outputs:** FHIR-compliant API endpoint, HL7 messaging

### 4. Benefits Enrollment

**Template:** `templates/custom/benefits/snap_application.yaml` **Outputs:** Pre-filled application forms, eligibility screening data

---

## Troubleshooting

**Template won't generate:**

- Check YAML syntax: `yamllint templates/custom/your_template.yaml`
- Verify HMIS data element names match ontology exactly
- Ensure required fields are marked `required: true`

**Validation errors:**

- Review HUD Data Dictionary for correct element names
- Check date formats (ISO 8601 is default: YYYY-MM-DD)
- Verify enum values match HUD standards (e.g., VeteranStatus: 0=No, 1=Yes)

**Custom fields not appearing:**

- Ensure `custom_fields` section is properly indented
- Add `source: manual_entry` for non-HMIS data
- Document where users should obtain custom field data

---

## Getting Help

**Resources:**

- HMIS Data Dictionary: https://hudexchange.info/resource/3824/
- Toolchain documentation: https://github.com/HUD-Data-Lab/hmis-codegen
- Example templates: `hmis-codegen/templates/examples/`

**Support:**

- CoC HMIS Lead: For local policy questions
- Vendor technical support: For HMIS integration issues
- HUD Technical Assistance: For data standards interpretation

---

## Key Principles

✓ **Keep it simple:** Start with core HMIS fields before adding custom data  
✓ **Document everything:** Future users need context for custom fields  
✓ **Test thoroughly:** Validate against real HMIS data before deployment  
✓ **Version control:** Track template changes for audit compliance  
✓ **Stay 1:1 with HUD:** Match Data Dictionary names and formats exactly

---

**Questions? Contact your CoC's HMIS Lead or System Administrator.**