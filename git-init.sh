#!/bin/bash

# set up github helpers
if [ "$#" -eq 2 ]; then

wget https://raw.githubusercontent.com/mzrimsek/github-helpers/master/.github_helpers
mv .github_helpers $HOME

echo -e "\n# github helpers" >> $HOME/.bashrc
echo "export GITHUB_USER=$1" >> $HOME/.bashrc
echo "export GITHUB_TOKEN=$2" >> $HOME/.bashrc

cat <<ENDSCRIPT >> $HOME/.bashrc
if [ -f ~/.github_helpers ]; then
	. ~/.github_helpers
fi
ENDSCRIPT

# set up git credential store
cat <<ENDSCRIPT >> $HOME/.gitconfig
[user]
	email = mikezrimsek@gmail.com
	name = Mike Zrimsek
[credential]
	helper = store
[core]
	autocrlf = input
ENDSCRIPT

echo "https://${1}:${2}@github.com" >> $HOME/.git-credentials

source $HOME/.bashrc

else
  echo "Supply github username and token"
fi
