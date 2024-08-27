#!/usr/bin/env bash

# Run override ci command if provided, otherwise run default npm install
if [[ -n "$PARAM_OVERRIDE_COMMAND" ]]; then
    echo "Running override package installation command:"
    eval "$PARAM_OVERRIDE_COMMAND"
else
    pnpm install --frozen-lockfile
fi
