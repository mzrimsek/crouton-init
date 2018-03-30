#!/bin/bash

NPM_PKGS=""

install_package() {
  BIN=$(which $1)
  PKG=$2
  
  if [ "$BIN" = "" ]; then
    echo "Adding $PKG to be installed"
    NPM_PKGS="$NPM_PKGS $PKG"
  else
    INSTALLED_VER=$(npm list -g $PKG | awk -F'@' 'NR==2 { print $NF }')
    LATEST_VER=$(npm view $PKG version)
    if [ $INSTALLED_VER != $LATEST_VER ]; then
      echo "Adding $PKG to be updated"
      NPM_PKGS="$NPM_PKGS $PKG"
    else
      echo "Latest version of $PKG already installed"
    fi
  fi
}

# npm
install_package npm npm

# @angular/cli
install_package ng @angular/cli

# create-react-app
install_package create-react-app create-react-app

# @vue/cli
install_package vue @vue/cli

# license-generator
install_package license-generator license-generator

# firebase
install_package firebase firebase-tools

# install packages
if [ "$NPM_PKGS" != "" ]; then
  echo "Installing packages..."
  npm install -g $NPM_PKGS
else
  echo "No packages to install..."
fi
