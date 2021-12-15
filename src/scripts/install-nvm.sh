# Only install nvm if it's not already installed
if command -v nvm &> /dev/null; then
    echo "nvm is already installed. Skipping nvm install.";
else
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash;
    
    echo 'export NVM_DIR="$HOME/.nvm"' >> "$BASH_ENV";
    echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use' >> "$BASH_ENV";

    # shellcheck source=/dev/null
    source "$BASH_ENV";
fi

if [ "$NODE_PARAM_VERSION" = "lts" ]; then
    nvm install --lts
    nvm alias default lts/*
elif [ -n "$NODE_PARAM_VERSION" ]; then
    nvm install "$NODE_PARAM_VERSION"
    nvm alias default "$NODE_PARAM_VERSION"
elif [ -f ".nvmrc" ]; then
    NVMRC_SPECIFIED_VERSION=$(<.nvmrc)
    nvm install "$NVMRC_SPECIFIED_VERSION"
    nvm alias default "$NVMRC_SPECIFIED_VERSION"
else
    nvm install "node"
fi

echo 'nvm use default &>/dev/null' >> "$BASH_ENV"
