#!/usr/bin/env bash

# Configure bun cache path if provided
if [[ -n "$PARAM_CACHE_PATH" ]]; then
    export BUN_INSTALL_CACHE_DIR="$PARAM_CACHE_PATH"
fi

# Run override ci command if provided, otherwise run default bun install
# Note: bun install respects bunfig.toml configuration automatically
if [[ -n "$PARAM_OVERRIDE_COMMAND" ]]; then
    echo "Running override package installation command:"
    eval "$PARAM_OVERRIDE_COMMAND"
else
    bun install --frozen-lockfile
fi
