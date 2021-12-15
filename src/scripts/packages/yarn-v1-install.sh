
# Run override ci command if provided, otherwise run default yarn install
if [[ ! -z "$PARAM_OVERRIDE_COMMAND" ]]; then
    echo "Running override package installation command:"
    eval $PARAM_OVERRIDE_COMMAND
else
    yarn install --frozen-lockfile
fi