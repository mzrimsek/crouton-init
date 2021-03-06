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

if [ "$#" -le 1 ]; then
    if [ "$1" = "" ] || [ "$1" = "r" ]; then
        echo "Restoring..."

        # restore user settings and snippets
        mv settings.json $HOME/.config/Code/User
        mv snippets/typescript.json $HOME/.config/Code/User/snippets

        # restore extensions
        cd extensions
        ./restore-extensions.sh
    elif [ "$1" = "b" ]; then
        echo "Backing up..."

        # backup user settings and snippets
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
    else
        echo "Invalid option"
        echo "Valid options are restore('r') (default) and backup('b')"
    fi
else
    echo "Too many arguments"
fi

# clean up
cd $HOME
rm -rf $TEMP_DIR
