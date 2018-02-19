#!/bin/bash

GO_VER=1.9.3.linux-amd64
DOTNET_VER=2.1.4

# dependencies
apt install -y curl

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
  
  echo "export PATH=$PATH:/usr/local/go/bin" >> $HOME/.profile
else
  echo "go already installed..."
fi

# mongodb
MONGO_BIN=$(which mongod)
if [ "$MONGO_BIN" = "" ]; then
  echo "Adding mongodb PPA..."
  sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2930ADAE8CAF5059EE73BB4B58712A2291FA4AD5
  echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.6 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.6.list
else
  echo "MongoDB PPA already added"
fi

# dart
DART_BIN=$(which dart)
if [ "$DART_BIN" = "" ]; then
  echo "Adding dart PPA..."
  sudo sh -c 'curl https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -'
  sudo sh -c 'curl https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list'
  echo "export PATH=/usr/lib/dart/bin:$PATH" >> $HOME/.profile
else
  echo "dart already installed"
fi

# update package sources
apt update

# install packages
apt install -y vim git nodejs code dotnet-sdk-${DOTNET_VER} openjdk-8-jdk postgresql postgresql-contrib pgadmin3 mongodb-org dart
npm install -g npm
