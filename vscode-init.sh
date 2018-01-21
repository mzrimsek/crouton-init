#!/bin/bash

TEMP_DIR=$HOME/crouton-install-temp

# clean up if things are left over for smoe reason
if [ -d "$TEMP_DIR" ]; then
  rm -rf $TEMP_DIR
fi

# create temporary directory
mkdir $TEMP_DIR
cd $TEMP_DIR

# restore extensions
wget https://raw.githubusercontent.com/mzrimsek/crouton-init/master/vscode/extensions/extensions.txt
wget https://raw.githubusercontent.com/mzrimsek/crouton-init/master/vscode/extensions/restore-extensions.sh -O - | sh

# restore user settings and snippets
wget https://raw.githubusercontent.com/mzrimsek/crouton-init/master/vscode/settings.json
mv settings.json $HOME/.config/Code/User

wget https://raw.githubusercontent.com/mzrimsek/crouton-init/master/vscode/snippets/typescript.json
mv typescript.json $HOME/.config/Code/User/snippets

# clean up
cd $HOME
rm -rf $TEMP_DIR
