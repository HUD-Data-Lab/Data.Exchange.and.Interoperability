#!/usr/bin/env bash
# Contract-test the HMIS Data Exchange API with Newman.
#
# 1. Lint the OpenAPI description and the Arazzo workflows.
# 2. Build a Postman collection from the OpenAPI description with Portman, adding a
#    contract test per operation (status, content type, JSON body, response schema).
# 3. Run that collection with Newman.
#
# By default the collection runs against a Prism mock server generated from the same
# OpenAPI file, which checks that the description and its examples agree. Set
# HMIS_API_BASE_URL to run the same tests against a real HMIS implementation instead.
set -euo pipefail
cd "$(dirname "$0")"
mkdir -p build

npm run --silent lint
npm run --silent collection

mock_pid=""
if [[ -z "${HMIS_API_BASE_URL:-}" ]]; then
  npx prism mock ../hmis-api.openapi.yaml --port 4010 --errors > build/prism.log 2>&1 &
  mock_pid=$!
  trap '[[ -n "$mock_pid" ]] && kill "$mock_pid" 2>/dev/null || true' EXIT
  for _ in $(seq 1 30); do
    if curl -s -o /dev/null http://localhost:4010; then break; fi
    sleep 1
  done
fi

npm run --silent newman
