# Run override ci command if provided, otherwise run default yarn install
# see: https://yarnpkg.com/configuration/yarnrc/#cacheFolder
if [[ -n "$PARAM_CACHE_PATH" ]]; then
    yarn config set cacheFolder "$PARAM_CACHE_PATH"
fi

if [[ -n "$PARAM_OVERRIDE_COMMAND" ]]; then
    echo "Running override package installation command:"
    eval "$PARAM_OVERRIDE_COMMAND"
else
    yarn install --immutable
fi