if [[ "$ORB_PARAM_PKG_MANAGER" == "npm" ]]; then
    npm run "$ORB_PARAM_NPM_RUN"
else
    yarn run "$ORB_PARAM_YARN_RUN"
fi