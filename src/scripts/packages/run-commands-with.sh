if [[ "npm" == "$PKG_MANAGER" ]]; then
    npm run "$NPM_RUN"
else
    yarn run "$YARN_RUN"
fi