"""
Utility functions for the hmis-codegen toolchain
"""

from typing import Dict, Any
from pathlib import Path


def load_yaml_safe(path: Path) -> Dict[str, Any]:
    """Safely load YAML file"""
    import yaml
    with open(path, 'r') as f:
        return yaml.safe_load(f)


def write_json_pretty(path: Path, data: Dict[str, Any]) -> None:
    """Write JSON with pretty formatting"""
    import json
    with open(path, 'w') as f:
        json.dump(data, f, indent=2)


def ensure_dir(path: Path) -> Path:
    """Ensure directory exists"""
    path.mkdir(parents=True, exist_ok=True)
    return path


def get_local_name(uri: str) -> str:
    """Extract local name from URI"""
    return uri.split('#')[-1].split('/')[-1]