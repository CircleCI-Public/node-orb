TARGET_DIR="/tmp"
if [ -n "$HOMEDRIVE" ]; then
    TARGET_DIR="$HOMEDRIVE\\tmp"
fi

# Link corresponding lock file to a temporary file used by cache commands
if [ -f "package-lock.json" ]; then
    echo "Found package-lock.json file, assuming lockfile"
    cp package-lock.json $TARGET_DIR/node-project-lockfile
elif [ -f "npm-shrinkwrap.json" ]; then
    echo "Found npm-shrinkwrap.json file, assuming lockfile"
    cp npm-shrinkwrap.json $TARGET_DIR/node-project-lockfile
elif [ -f "yarn.lock" ]; then
    echo "Found yarn.lock file, assuming lockfile"
    cp yarn.lock $TARGET_DIR/node-project-lockfile
fi

cp package.json $TARGET_DIR/node-project-package.json
