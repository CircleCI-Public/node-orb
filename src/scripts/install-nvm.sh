curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash
echo 'export NVM_DIR="$HOME/.nvm"' >> $BASH_ENV
echo "[ -s \"$NVM_DIR/nvm.sh\" ] && \. \"$NVM_DIR/nvm.sh\"" >> $BASH_ENV
source $BASH_ENV
if [ "$NODE_PARAM_LTS" = "1" ]; then
    nvm install --lts
else
    nvm install "$NODE_PARAM_VERSION"
fi