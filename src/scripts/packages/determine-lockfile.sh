# Link corresponding lock file to a temporary file used by cache commands
if [ -f "package-lock.json" ]; then
    echo "Found package-lock.json file, assuming lockfile"
    ln -s package-lock.json /tmp/node-project-lockfile
elif [ -f "npm-shrinkwrap.json" ]; then
    echo "Found npm-shrinkwrap.json file, assuming lockfile"
    ln -s npm-shrinkwrap.json /tmp/node-project-lockfile
elif [ -f "yarn.lock" ]; then
    echo "Found yarn.lock file, assuming lockfile"
    ln -s yarn.lock /tmp/node-project-lockfile
fi
ln -s package.json /tmp/node-project-package.json