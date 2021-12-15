# Link corresponding lock file to a temporary file used by cache commands
if [ -f "package-lock.json" ]; then
    echo "Found package-lock.json file, assuming lockfile"
    ln package-lock.json /tmp/node-project-lockfile
elif [ -f "npm-shrinkwrap.json" ]; then
    echo "Found npm-shrinkwrap.json file, assuming lockfile"
    ln npm-shrinkwrap.json /tmp/node-project-lockfile
elif [ -f "yarn.lock" ]; then
    echo "Found yarn.lock file, assuming lockfile"
    ln yarn.lock /tmp/node-project-lockfile
fi
ln package.json /tmp/node-project-package.json