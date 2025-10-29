use serde_json::Value;
use crate::{ValidationResult, ValidationError};

/// Validate client data against HUD Data Standards
pub fn validate_client_data(data: &Value) -> ValidationResult {
    let mut errors = Vec::new();
    let mut warnings = Vec::new();
    
    // Required fields validation
    if !data.get("FirstName").is_some() && !data.get("LastName").is_some() {
        errors.push(ValidationError {
            field: "Name".to_string(),
            message: "Either FirstName or LastName is required".to_string(),
            rule: "HUD Data Standards 3.01".to_string(),
        });
    }
    
    // SSN validation (if present)
    if let Some(ssn) = data.get("SSN").and_then(|v| v.as_str()) {
        if ssn.len() != 9 || !ssn.chars().all(|c| c.is_numeric()) {
            errors.push(ValidationError {
                field: "SSN".to_string(),
                message: "SSN must be exactly 9 digits".to_string(),
                rule: "HUD Data Standards 3.02".to_string(),
            });
        }
    }
    
    // DOB validation (if present)
    if let Some(dob) = data.get("DOB").and_then(|v| v.as_str()) {
        if !is_valid_date(dob) {
            errors.push(ValidationError {
                field: "DOB".to_string(),
                message: "DOB must be in YYYY-MM-DD format".to_string(),
                rule: "HUD Data Standards 3.03".to_string(),
            });
        }
    }
    
    // Gender multi-select validation
    let gender_fields = ["Woman", "Man", "NonBinary", "CulturallySpecific", 
                         "Transgender", "Questioning", "DifferentIdentity"];
    let has_gender = gender_fields.iter()
        .any(|field| data.get(field).and_then(|v| v.as_i64()) == Some(1));
    
    if !has_gender && data.get("GenderNone").and_then(|v| v.as_i64()) != Some(8) {
        warnings.push("No gender identity selected".to_string());
    }
    
    ValidationResult {
        valid: errors.is_empty(),
        errors,
        warnings,
    }
}

/// Validate business rules (HUD policy logic)
pub fn validate_business_rules(data: &Value) -> ValidationResult {
    let mut errors = Vec::new();
    let mut warnings = Vec::new();
    
    // Example: If VeteranStatus = Yes, require YearEnteredService
    if data.get("VeteranStatus").and_then(|v| v.as_i64()) == Some(1) {
        if !data.get("YearEnteredService").is_some() {
            errors.push(ValidationError {
                field: "YearEnteredService".to_string(),
                message: "Required when VeteranStatus = Yes".to_string(),
                rule: "HUD Data Standards 3.07 Conditional".to_string(),
            });
        }
        
        if !data.get("YearSeparated").is_some() {
            errors.push(ValidationError {
                field: "YearSeparated".to_string(),
                message: "Required when VeteranStatus = Yes".to_string(),
                rule: "HUD Data Standards 3.07 Conditional".to_string(),
            });
        }
    }
    
    // Example: ExitDate must be >= EntryDate
    if let (Some(entry), Some(exit)) = (
        data.get("EntryDate").and_then(|v| v.as_str()),
        data.get("ExitDate").and_then(|v| v.as_str())
    ) {
        if exit < entry {
            errors.push(ValidationError {
                field: "ExitDate".to_string(),
                message: "Exit date cannot be before entry date".to_string(),
                rule: "HUD Business Logic".to_string(),
            });
        }
    }
    
    ValidationResult {
        valid: errors.is_empty(),
        errors,
        warnings,
    }
}

fn is_valid_date(date_str: &str) -> bool {
    // Simple YYYY-MM-DD validation
    let parts: Vec<&str> = date_str.split('-').collect();
    if parts.len() != 3 {
        return false;
    }
    
    parts[0].len() == 4 && parts[0].parse::<u32>().is_ok() &&
    parts[1].len() == 2 && parts[1].parse::<u32>().is_ok() &&
    parts[2].len() == 2 && parts[2].parse::<u32>().is_ok()
}