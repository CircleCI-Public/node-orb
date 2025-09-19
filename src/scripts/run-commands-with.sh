#!/usr/bin/env bash

if [[ "$ORB_PARAM_PKG_MANAGER" == "npm" ]]; then
    npm run "$ORB_PARAM_NPM_RUN"
elif [[ "$ORB_PARAM_PKG_MANAGER" == "pnpm" ]]; then
    pnpm run "$ORB_PARAM_PNPM_RUN"
elif [[ "$ORB_PARAM_PKG_MANAGER" == "bun" ]]; then
    bun run "$ORB_PARAM_BUN_RUN"
else
    yarn run "$ORB_PARAM_YARN_RUN"
fi
