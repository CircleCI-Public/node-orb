#!/usr/bin/env bash
if [[ $EUID == 0 ]]; then export SUDO=""; else export SUDO="sudo"; fi

# FUNCTIONS
get_bun_version () {
    if [[ "$NODE_PARAM_BUN_VERSION" == "" ]]; then
        BUN_ORB_VERSION=$(curl --fail --retry 5 -Ls -o /dev/null -w '%{url_effective}' "https://github.com/oven-sh/bun/releases/latest" | sed 's:.*/bun-v::')
        echo "Latest version of Bun is $BUN_ORB_VERSION"
    else
        BUN_ORB_VERSION="$NODE_PARAM_BUN_VERSION"
        echo "Selected version of Bun is $BUN_ORB_VERSION"
    fi
}

installation_check () {
    echo "Checking if Bun is already installed..."
    if command -v bun > /dev/null 2>&1; then
        if bun --version | grep "$BUN_ORB_VERSION" > /dev/null 2>&1; then
            echo "Bun $BUN_ORB_VERSION is already installed"
            exit 0
        else
            echo "A different version of Bun is installed ($(bun --version)); removing it"

            # Remove existing bun installation
            $SUDO rm -rf "$HOME/.bun" > /dev/null 2>&1
            $SUDO npm rm -g bun > /dev/null 2>&1
        fi
    fi
}

# cd to home so that bun --version will not use relative installed bun
cd ~ || echo "Cannot change directory to home directory, bun version may be mismatched."

get_bun_version
installation_check

# install bun

echo "Installing Bun v$BUN_ORB_VERSION"
if [ -w "$(npm root -g)" ]; then
    npm install -g "bun@$BUN_ORB_VERSION"
else
    $SUDO npm install -g "bun@$BUN_ORB_VERSION"
fi

# test/verify version
echo "Verifying Bun install"
if bun --version | grep "$BUN_ORB_VERSION" > /dev/null 2>&1; then
    echo "Success! Bun $(bun --version) has been installed to $(command -v bun)"
else
    echo "Something went wrong; the specified version of Bun could not be installed"
    exit 1
fi
