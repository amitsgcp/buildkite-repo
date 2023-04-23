#!/bin/bash

# Install OPA binary
curl -sL https://github.com/open-policy-agent/opa/releases/download/v0.32.0/opa_linux_amd64 -o /usr/local/bin/opa
chmod +x /usr/local/bin/opa

# Set inputs for policy evaluation
BUILDKITE_BRANCH=${BUILDKITE_BRANCH:-"main"}
BUILDKITE_PULL_REQUEST=${BUILDKITE_PULL_REQUEST:-"false"}
BUILDKITE_TAG=${BUILDKITE_TAG:-"false"}

# Evaluate policy
opa eval --format=json --input=opa_input_file\buildkite_inputs.json --data=policies/buildkite_policy.rego | grep -q 'true'
if [ $? -ne 0 ]; then
  echo "Buildkite prebuild step failed policy check"
  exit 1
fi
