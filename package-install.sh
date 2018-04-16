#!/bin/bash

GO_VER=1.9.3.linux-amd64
DOTNET_VER=2.1.4
NEW_PATH=$PATH

# dependencies
sudo apt-get install -y curl

# git
GIT_BIN=$(which git)
if [ "$GIT_BIN" = "" ]; then
  echo "Adding git PPA..."
  apt-add-repository ppa:git-core/ppa
else
  echo "git PPA already added..."
fi

# nodejs
NODE_BIN=$(which node)
if [ "$NODE_BIN" = "" ]; then
  echo "Adding nodejs PPA..."
  curl -sL https://deb.nodesource.com/setup_9.x | sudo -E bash -
else
  echo "nodejs PPA already added..."
fi

# vscode
VSCODE_BIN=$(which code)
if [ "$VSCODE_BIN" = "" ]; then
  echo "Adding vscode PPA..."
  curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
  mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
  sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
else
  echo "vscode PPA already added..."
fi

# dotnet core
DOTNET_BIN=$(which dotnet)
if [ "$DOTNET_BIN" = "" ]; then
  echo "Adding dotnet PPA..."
  curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
  mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
  sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-ubuntu-xenial-prod xenial main" > /etc/apt/sources.list.d/dotnetdev.list'
else
  echo "dotnet PPA already added..."
fi

# postgresql
PSQL_BIN=$(which psql)
if [ "$PSQL_BIN" = "" ]; then
  echo "Adding postgresql PPA..."
  sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" >> /etc/apt/sources.list.d/pgdg.list'
  wget -q https://www.postgresql.org/media/keys/ACCC4CF8.asc -O - | sudo apt-key add -
else
  echo "postgresql PPA already added..."
fi

# go
GO_BIN=$(which go)
if [ "$GO_BIN" = "" ]; then
  echo "Installing go from source..."
  wget https://storage.googleapis.com/golang/go${GO_VER}.tar.gz
  tar -C /usr/local -xzf go${GO_VER}.tar.gz
  rm go${GO_VER}.tar.gz

  NEW_PATH=$NEW_PATH:/usr/local/go/bin
else
  echo "go already installed..."
fi

# dart
DART_BIN=$(which dart)
if [ "$DART_BIN" = "" ]; then
  echo "Adding dart PPA..."
  sudo sh -c 'curl https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -'
  sudo sh -c 'curl https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list'

  NEW_PATH=$NEW_PATH:/usr/lib/dart/bin
else
  echo "dart already added"
fi

# yarn
YARN_BIN=$(which yarn)
if [ "$YARN_BIN" = "" ]; then
  echo "Adding yarn PPA..."
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
else
  echo "yarn already added"
fi

# update path
if [ "$PATH" != "$NEW_PATH" ]; then
  echo "Updating PATH..."
  echo "export PATH=$NEW_PATH" >> $HOME/.profile
else
  echo "No PATH changes to make..."
fi

# update package sources
sudo apt-get update && sudo apt-get upgrade

# install packages
echo "Installing packages..."
sudo apt-get install -y vim git nodejs code dotnet-sdk-${DOTNET_VER} openjdk-8-jdk postgresql postgresql-contrib pgadmin3 dart yarn
