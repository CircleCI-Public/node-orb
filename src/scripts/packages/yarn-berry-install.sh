# Run override ci command if provided, otherwise run default yarn install
# See: https://yarnpkg.com/configuration/yarnrc/#cacheFolder
if [[ -n "$PARAM_CACHE_PATH" ]]; then
    yarn config set cacheFolder "$PARAM_CACHE_PATH"
fi

if [[ -n "$PARAM_OVERRIDE_COMMAND" ]]; then
    echo "Running override package installation command:"
    eval "$PARAM_OVERRIDE_COMMAND"
else
    # If a cache folder is already present, then we use Yarn Zero installs
    # See: https://yarnpkg.com/features/zero-installs
    if [[ -e "$PARAM_CACHE_PATH" ]]; then
        # See: https://yarnpkg.com/features/zero-installs#does-it-have-security-implications
        YARN_LOCKFILE_PATH="/tmp/yarn-zero-lockfile"

        if [[ "$PARAM_CHECK_CACHE" == "detect" ]]; then
            if [[ ! -f "$YARN_LOCKFILE_PATH" ]]; then
                echo "No yarn zero lockfile cached. Enabling check cache this run."
                ENABLE_CHECK_CACHE="true"
                elif [[ $(diff -q "$YARN_LOCKFILE_PATH" yarn.lock) ]]; then
                echo "Detected changes in lockfile. Enabling check cache this run."
                rm -f "$YARN_LOCKFILE_PATH"
                ENABLE_CHECK_CACHE="true"
            else
                echo "No changes detected in lockfile. Skipping check cache this run."
            fi
        fi

        if [[ "$PARAM_CHECK_CACHE" == "always" || -n "$ENABLE_CHECK_CACHE" ]]; then
            set -- "$@" --check-cache
        fi

        yarn install --immutable --immutable-cache "$@"

        if [[ "$PARAM_CHECK_CACHE" == "detect" && -n "$ENABLE_CHECK_CACHE" ]]; then
            cp yarn.lock "$YARN_LOCKFILE_PATH"
        fi
    else
        yarn install --immutable
    fi
fi