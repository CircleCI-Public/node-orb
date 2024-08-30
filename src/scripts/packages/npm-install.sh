#!/usr/bin/env bash

# Configure npm cache path if provided
if [[ -n "$PARAM_CACHE_PATH" ]] && [[ "$PARAM_OVERRIDE_COMMAND" != "npm ci" ]] && [[ -n "$PARAM_OVERRIDE_COMMAND" ]]; then
    npm config set cache "$PARAM_CACHE_PATH"
fi

# Run override ci command if provided, otherwise run default npm install
if [[ -n "$PARAM_OVERRIDE_COMMAND" ]]; then
    echo "Running override package installation command:"
    eval "$PARAM_OVERRIDE_COMMAND"
else
    npm ci
fi