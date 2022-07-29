if [[ $EUID == 0 ]]; then export SUDO=""; else export SUDO="sudo"; fi

# FUNCTIONS
get_yarn_version () {
    if [[ "$NODE_PARAM_YARN_VERSION" == "" ]]; then
    YARN_ORB_VERSION=$(curl -s https://cdn.jsdelivr.net/npm/yarn/package.json | sed -n 's/.*version": "\(.*\)".*/\1/p')
    echo "Latest version of Yarn is $YARN_ORB_VERSION"
    else
    YARN_ORB_VERSION="$NODE_PARAM_YARN_VERSION"

    echo "Selected version of Yarn is $YARN_ORB_VERSION"
    fi
}

installation_check () {
    echo "Checking if YARN is already installed..."
    if command -v yarn > /dev/null 2>&1; then
    if yarn --version | grep "$YARN_ORB_VERSION" > /dev/null 2>&1; then
        echo "Yarn $YARN_ORB_VERSION is already installed"
        exit 0
    else
        echo "A different version of Yarn is installed ($(yarn --version)); removing it"

        if uname -a | grep Darwin > /dev/null 2>&1; then
        brew uninstall yarn > /dev/null 2>&1
        elif grep Alpine /etc/issue > /dev/null 2>&1; then
        apk del yarn > /dev/null 2>&1
        elif grep Debian /etc/issue > /dev/null 2>&1; then
        $SUDO apt-get remove yarn > /dev/null 2>&1 && \
            $SUDO apt-get purge yarn > /dev/null 2>&1
        elif grep Ubuntu /etc/issue > /dev/null 2>&1; then
        $SUDO apt-get remove yarn > /dev/null 2>&1 && \
            $SUDO apt-get purge yarn > /dev/null 2>&1
        elif command -v yum > /dev/null 2>&1; then
        yum remove yarn > /dev/null 2>&1
        fi

        $SUDO rm -rf "$HOME/.yarn" > /dev/null 2>&1
        $SUDO rm -f /usr/local/bin/yarn /usr/local/bin/yarnpkg > /dev/null 2>&1
    fi
    fi
}

# cd to home so that yarn --version will not use relative installed yarn from .yarn/releases
cd ~ || echo "Cannot change directory to home directory, yarn version may be mismatched."

get_yarn_version
installation_check

# install yarn
echo "Installing YARN v$YARN_ORB_VERSION"
curl --retry 5 -L -o yarn.tar.gz --silent "https://yarnpkg.com/downloads/$YARN_ORB_VERSION/yarn-v$YARN_ORB_VERSION.tar.gz"

$SUDO tar -xzf yarn.tar.gz && rm yarn.tar.gz

$SUDO mkdir -p /opt/yarn
$SUDO mv yarn-v"${YARN_ORB_VERSION}"/* /opt/yarn

$SUDO rm -rf "yarn-v${YARN_ORB_VERSION}"

$SUDO chmod 777 "/opt/yarn"

$SUDO ln -s /opt/yarn/bin/yarn /usr/local/bin/yarn
$SUDO ln -s /opt/yarn/bin/yarnpkg /usr/local/bin/yarnpkg
$SUDO ln -s /opt/yarn/bin/yarn.js /usr/local/bin/yarn.js

$SUDO mkdir -p ~/.config

if uname -a | grep Darwin; then
    $SUDO chown -R "$USER:$GROUP" ~/.config
    $SUDO chown -R "$USER:$GROUP" /opt/yarn
else
    $SUDO chown -R "$(whoami):$(whoami)" /opt/yarn
    $SUDO chown -R "$(whoami):$(whoami)" ~/.config
fi

# test/verify version
echo "Verifying YARN install"
if yarn --version | grep "$YARN_ORB_VERSION" > /dev/null 2>&1; then
    echo "Success! Yarn $(yarn --version) has been installed to $(command -v yarn)"
else
    echo "Something went wrong; the specified version of Yarn could not be installed"
    exit 1
fi
