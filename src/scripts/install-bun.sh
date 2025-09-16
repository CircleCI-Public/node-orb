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
            $SUDO rm -f /usr/local/bin/bun > /dev/null 2>&1
            
            # Remove from PATH in common shell profiles
            sed -i.bak '/export PATH=".*\.bun\/bin.*"/d' "$HOME/.bashrc" > /dev/null 2>&1
            sed -i.bak '/export PATH=".*\.bun\/bin.*"/d' "$HOME/.zshrc" > /dev/null 2>&1
            sed -i.bak '/export PATH=".*\.bun\/bin.*"/d' "$HOME/.profile" > /dev/null 2>&1
        fi
    fi
}

# cd to home so that bun --version will not use relative installed bun
cd ~ || echo "Cannot change directory to home directory, bun version may be mismatched."

get_bun_version
installation_check

# install bun
echo "Installing Bun v$BUN_ORB_VERSION"

if [[ "$BUN_ORB_VERSION" == "" ]]; then
    # Install latest version
    curl --retry 5 -fsSL https://bun.sh/install | bash
else
    # Install specific version
    curl --retry 5 -fsSL https://bun.sh/install | bash -s "bun-v$BUN_ORB_VERSION"
fi

# Ensure bun is in PATH for current session
export PATH="$HOME/.bun/bin:$PATH"

# test/verify version
echo "Verifying Bun install"
if command -v bun > /dev/null 2>&1; then
    INSTALLED_VERSION=$(bun --version)
    if [[ "$BUN_ORB_VERSION" == "" ]] || echo "$INSTALLED_VERSION" | grep "$BUN_ORB_VERSION" > /dev/null 2>&1; then
        echo "Success! Bun $INSTALLED_VERSION has been installed to $(command -v bun)"
    else
        echo "Something went wrong; the specified version of Bun could not be installed"
        echo "Expected version: $BUN_ORB_VERSION, but got: $INSTALLED_VERSION"
        exit 1
    fi
else
    echo "Something went wrong; Bun could not be installed or is not in PATH"
    exit 1
fi