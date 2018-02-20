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

# restore user settings and snippets
mv settings.json $HOME/.config/Code/User
mv snippets/typescript.json $HOME/.config/Code/User/snippets

# restore extensions
cd extensions
./restore-extensions.sh

# clean up
cd $HOME
rm -rf $TEMP_DIR
