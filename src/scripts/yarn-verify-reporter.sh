#!/usr/bin/env bash

YARN_VERSION=$(yarn --version)

MAJOR_VERSION=${YARN_VERSION%%.*}

if [[ "$MAJOR_VERSION" -eq 1 ]]; then
  yarn list --pattern "${PARAM_PATTERN}" | grep "${PARAM_GREP}" || (echo "${PARAM_ERROR}" && exit 1)
else
  yarn info --pattern "${PARAM_PATTERN}" | grep "${PARAM_GREP}" || (echo "${PARAM_ERROR}" && exit 1)
fi