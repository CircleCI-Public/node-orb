#!/usr/bin/env bash

if [[ $EUID == 0 ]]; then export SUDO=""; else export SUDO="sudo"; fi

# FUNCTIONS
get_pnpm_version () {
    if [[ "$NODE_PARAM_PNPM_VERSION" == "" ]]; then
    PNPM_ORB_VERSION=$(curl -s https://cdn.jsdelivr.net/npm/pnpm/package.json | sed -n 's/.*version": "\(.*\)".*/\1/p')
    echo "Latest version of pnpm is $PNPM_ORB_VERSION"
    else
    PNPM_ORB_VERSION="$NODE_PARAM_PNPM_VERSION"

    echo "Selected version of pnpm is $PNPM_ORB_VERSION"
    fi
}

installation_check () {
    echo "Checking if pnpm is already installed..."
    if command -v pnpm > /dev/null 2>&1; then
      if pnpm --version | grep "$PNPM_ORB_VERSION" > /dev/null 2>&1; then
          echo "pnpm $PNPM_ORB_VERSION is already installed"
          exit 0
      else
          echo "A different version of pnpm is installed ($(pnpm --version)); removing it"

          $SUDO rm -rf "$(pnpm store path)" > /dev/null 2>&1
          $SUDO rm -rf "$PNPM_HOME" > /dev/null 2>&1
          $SUDO npm rm -g pnpm > /dev/null 2>&1
      fi
    fi
}

# cd to home so that pnpm --version will not use relative installed pnpm
cd ~ || echo "Cannot change directory to home directory, pnpm version may be mismatched."

get_pnpm_version
installation_check

# install pnpm
echo "Installing pnpm v$PNPM_ORB_VERSION"
curl --retry 5 -fsSL https://get.pnpm.io/install.sh | env PNPM_VERSION="$PNPM_ORB_VERSION" sh -

# test/verify version
echo "Verifying pnpm install"
if pnpm --version | grep "$PNPM_ORB_VERSION" > /dev/null 2>&1; then
    echo "Success! pnpm $(pnpm --version) has been installed to $(command -v pnpm)"
else
    echo "Something went wrong; the specified version of pnpm could not be installed"
    exit 1
fi
