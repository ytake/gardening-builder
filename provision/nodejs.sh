#!/usr/bin/env bash

# node.js install 6.*
curl -sL https://rpm.nodesource.com/setup_6.x | bash -
yum install -y nodejs

# node.js version
node -v
npm --version

sudo npm install -g jshint
sudo npm install -g grunt
sudo npm install -g gulp
