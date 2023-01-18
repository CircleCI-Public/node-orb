# Only install nvm if it's not already installed
if command -v nvm &> /dev/null; then
    echo "nvm is already installed. Skipping nvm install.";
else
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash;
    
    echo 'export NVM_DIR="$HOME/.nvm"' >> "$BASH_ENV";
    echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use' >> "$BASH_ENV";
    
    # shellcheck source=/dev/null
    source "$BASH_ENV";
fi

# See: https://github.com/nvm-sh/nvm#usage
if [ "$NODE_PARAM_VERSION" = "latest" ]; then
    # When no version is specified we default to the latest version of Node
    NODE_ORB_INSTALL_VERSION=$(nvm ls-remote | tail -n1 | grep -Eo 'v[0-9]+\.[0-9]+\.[0-9]+')
    nvm install "$NODE_ORB_INSTALL_VERSION" # aka nvm install node. We're being explicit here.
    nvm alias default "$NODE_ORB_INSTALL_VERSION"
elif [ -n "$NODE_PARAM_VERSION" ] && [ "$NODE_PARAM_VERSION" != "lts" ]; then
    nvm install "$NODE_PARAM_VERSION"
    nvm alias default "$NODE_PARAM_VERSION"
elif [ -f ".nvmrc" ]; then
    NVMRC_SPECIFIED_VERSION=$(<.nvmrc)
    nvm install "$NVMRC_SPECIFIED_VERSION"
    nvm alias default "$NVMRC_SPECIFIED_VERSION"
else
    nvm install --lts
    nvm alias default lts/*
fi

echo 'nvm use default &>/dev/null' >> "$BASH_ENV"
