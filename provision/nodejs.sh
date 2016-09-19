#!/usr/bin/env bash

# node.js install 6.*
curl -sL https://rpm.nodesource.com/setup_6.x | bash -
yum install -y nodejs

NPM_CONFIG=`npm config get prefix`
if [ $NPM_CONFIG = '/usr' ]; then
 mkdir ~/.npm-global
 echo "export NPM_CONFIG_PREFIX=~/.npm-global" >> /home/vagrant/.bash_profile
fi
