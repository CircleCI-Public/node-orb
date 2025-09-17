#!/usr/bin/env bash

TARGET_DIR="/tmp"
if [ -n "$HOMEDRIVE" ]; then
    TARGET_DIR="$HOMEDRIVE\\tmp"
fi

# Link corresponding lock file to a temporary file used by cache commands
if [ -f "package-lock.json" ]; then
    echo "Found package-lock.json file, assuming lockfile"
    cp package-lock.json "$TARGET_DIR"/node-project-lockfile
elif [ -f "npm-shrinkwrap.json" ]; then
    echo "Found npm-shrinkwrap.json file, assuming lockfile"
    cp npm-shrinkwrap.json "$TARGET_DIR"/node-project-lockfile
elif [ -f "yarn.lock" ]; then
    echo "Found yarn.lock file, assuming lockfile"
    cp yarn.lock "$TARGET_DIR"/node-project-lockfile
elif [ -f "pnpm-lock.yaml" ]; then
    echo "Found pnpm-lock.yaml file, assuming lockfile"
    cp pnpm-lock.yaml "$TARGET_DIR"/node-project-lockfile
elif [ -f "bun.lock" ]; then
    echo "Found bun.lock file, assuming lockfile"
    # Check if both bun.lock and bun.lockb exist and provide helpful guidance
    if [ -f "bun.lockb" ]; then
        echo "Warning: Both bun.lock and bun.lockb are present. Because bun.lock exists, bun.lockb will be ignored."
        echo "To clear this warning, remove one of these two files."
        echo "The bun.lockb format is still supported by bun, but may be removed in the future."
    fi
    cp bun.lock "$TARGET_DIR"/node-project-lockfile
elif [ -f "bun.lockb" ]; then
    echo "Found bun.lockb file, assuming lockfile"
    cp bun.lockb "$TARGET_DIR"/node-project-lockfile
else
    echo "Found no lockfile, adding empty one"
    touch "$TARGET_DIR"/node-project-lockfile
fi

cp package.json "$TARGET_DIR"/node-project-package.json
