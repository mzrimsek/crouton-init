#!/bin/bash

# set up github helpers
if [ "$#" -eq 4 ]; then

wget https://raw.githubusercontent.com/mzrimsek/github-helpers/master/.github_helpers
mv .github_helpers $HOME

cat <<ENDSCRIPT >> $HOME/.bashrc

# github helpers
export GITHUB_USER=$1
export GITHUB_TOKEN=$2

if [ -f ~/.github_helpers ]; then
	. ~/.github_helpers
fi
ENDSCRIPT

# set up git credential store
cat <<ENDSCRIPT >> $HOME/.gitconfig
[user]
	email = $3
	name = $4
[credential]
	helper = store
[core]
	autocrlf = input
ENDSCRIPT

echo "https://${1}:${2}@github.com" >> $HOME/.git-credentials

source $HOME/.bashrc

else
  echo "Supply github username, github token, email, and full name"
fi
