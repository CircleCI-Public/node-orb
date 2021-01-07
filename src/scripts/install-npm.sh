if [[ $EUID == 0 ]]; then export SUDO=""; else export SUDO="sudo"; fi

# FUNCTIONS
get_npm_version () {
    if [[ "$NODE_PARAM_NPM_VERSION" == latest ]]; then
    NPM_ORB_VERSION="$(npm view npm | sed -E 's|.*-||g' | grep latest | \
        perl -pe 's/.*: //g' | perl -pe "s/'|,//g")"

    echo "Latest version of NPM is $NPM_ORB_VERSION"
    else
    NPM_ORB_VERSION="$NODE_PARAM_NPM_VERSION"

    echo "Selected version of NPM is $NPM_ORB_VERSION"
    fi
}

installation_check () {
    if command -v npm > /dev/null 2>&1; then
    if npm -v | grep "$NPM_ORB_VERSION" > /dev/null 2>&1; then
        echo "NPM $NPM_ORB_VERSION is already installed"
        exit 0
    fi
    fi
}

get_npm_version
installation_check

if [ "$NODE_PARAM_NPM_VERSION" = latest ]; then
$SUDO npm install -g npm@latest > /dev/null 2>&1 || \
    npm install -g npm@latest > /dev/null 2>&1
else
$SUDO npm install -g "npm@$NPM_ORB_VERSION" > /dev/null 2>&1 || \
    npm install -g "npm@$NPM_ORB_VERSION" > /dev/null 2>&1
fi

# test/verify version
if npm -v | grep "$NPM_ORB_VERSION" > /dev/null 2>&1; then
echo "Success! NPM $(npm -v) has been installed to $(which npm)"
else
echo "Something went wrong; the specified version of NPM could not be installed"
exit 1
fi
