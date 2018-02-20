#!/bin/bash

TEMP_DIR=$HOME/crouton-install-temp

# clean up if things are left over for some reason
if [ -d "$TEMP_DIR" ]; then
  rm -rf $TEMP_DIR
fi

# create temporary directory
mkdir $TEMP_DIR
cd $TEMP_DIR

# clone repository
git clone https://github.com/mzrimsek/crouton-init.git
cd crouton-init/vscode

# backup settings and snippets
cp $HOME/.config/Code/User/settings.json settings.json
cp $HOME/.config/Code/User/snippets/typescript.json snippets/typescript.json

# backup extensions
cd extensions
./backup-extensions.sh

GIT_STATUS=$(git status --short)
if [ "$GIT_STATUS" != "" ]; then
  git commit -am "Update vscode settings"
  git push
fi

# clean up
cd $HOME
rm -rf $TEMP_DIR
