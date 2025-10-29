use wasm_bindgen::prelude::*;
use serde::{Deserialize, Serialize};

mod validator;
mod generated; // Auto-generated from Python toolchain

/// Main HMIS validator for WASM runtime
#[wasm_bindgen]
pub struct HMISValidator {
    // For Phase 1, keep state minimal
    version: String,
}

#[wasm_bindgen]
impl HMISValidator {
    /// Create a new validator instance
    #[wasm_bindgen(constructor)]
    pub fn new() -> Self {
        HMISValidator {
            version: "0.1.0".to_string(),
        }
    }
    
    /// Get validator version
    #[wasm_bindgen]
    pub fn version(&self) -> String {
        self.version.clone()
    }
    
    /// Validate client data against HUD Data Standards
    /// Returns ValidationResult as JSON string
    #[wasm_bindgen]
    pub fn validate_client(&self, json_data: &str) -> Result<JsValue, JsValue> {
        let client: serde_json::Value = serde_json::from_str(json_data)
            .map_err(|e| JsValue::from_str(&format!("Parse error: {}", e)))?;
        
        let result = validator::validate_client_data(&client);
        
        serde_wasm_bindgen::to_value(&result)
            .map_err(|e| JsValue::from_str(&format!("Serialization error: {}", e)))
    }
    
    /// Validate business rules (e.g., exit date >= entry date)
    #[wasm_bindgen]
    pub fn validate_business_rules(&self, json_data: &str) -> Result<JsValue, JsValue> {
        let data: serde_json::Value = serde_json::from_str(json_data)
            .map_err(|e| JsValue::from_str(&format!("Parse error: {}", e)))?;
        
        let result = validator::validate_business_rules(&data);
        
        serde_wasm_bindgen::to_value(&result)
            .map_err(|e| JsValue::from_str(&format!("Serialization error: {}", e)))
    }
    
    /// Transform plain JSON to JSON-LD with embedded context
    #[wasm_bindgen]
    pub fn to_jsonld(&self, json_data: &str, context_url: &str) -> Result<String, JsValue> {
        let mut data: serde_json::Value = serde_json::from_str(json_data)
            .map_err(|e| JsValue::from_str(&format!("Parse error: {}", e)))?;
        
        // Add JSON-LD context
        if let Some(obj) = data.as_object_mut() {
            obj.insert("@context".to_string(), serde_json::json!(context_url));
            
            // Add @type if we can infer it (using generated types)
            if let Some(type_uri) = generated::infer_type(obj) {
                obj.insert("@type".to_string(), serde_json::json!(type_uri));
            }
        }
        
        serde_json::to_string_pretty(&data)
            .map_err(|e| JsValue::from_str(&format!("Serialization error: {}", e)))
    }
}

/// Validation result structure
#[derive(Serialize, Deserialize)]
pub struct ValidationResult {
    pub valid: bool,
    pub errors: Vec<ValidationError>,
    pub warnings: Vec<String>,
}

#[derive(Serialize, Deserialize)]
pub struct ValidationError {
    pub field: String,
    pub message: String,
    pub rule: String,
}