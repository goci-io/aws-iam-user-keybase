#!/bin/bash
set +o history
set -e

# Parse query params (json)
eval "$(jq -r '@sh "KEYBASE_USERNAME=\(.keybase) PRIVATE_KEY=\(.private_key)"')"

# Encrypt from stdin
encrypted=$(echo "$PRIVATE_KEY" | KEYBASE_ALLOW_ROOT=1 keybase --standalone pgp encrypt --no-self ${KEYBASE_USERNAME} | base64)

# Build result json
jq -n --arg result "$encrypted" '{"key": $result}'
