# Fail if package.json does not exist in working directory

if [ ! -f "package.json" ]; then
    echo
    echo "---"
    echo "Unable to find your package.json file. Did you forget to set the app-dir parameter?"
    echo "---"
    echo
    echo "Current directory: $(pwd)"
    echo
    echo
    echo "List directory: "
    echo
    ls
    exit 1
fi