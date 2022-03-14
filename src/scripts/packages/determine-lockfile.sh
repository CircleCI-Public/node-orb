# Link corresponding lock file to a temporary file used by cache commands
if [ -f "package-lock.json" ]; then
    echo "Found package-lock.json file, assuming lockfile"
    cp package-lock.json /tmp/node-project-lockfile
elif [ -f "npm-shrinkwrap.json" ]; then
    echo "Found npm-shrinkwrap.json file, assuming lockfile"
    cp npm-shrinkwrap.json /tmp/node-project-lockfile
elif [ -f "yarn.lock" ]; then
    echo "Found yarn.lock file, assuming lockfile"
    cp yarn.lock /tmp/node-project-lockfile
fi
cp package.json /tmp/node-project-package.json