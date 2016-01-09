#!/usr/bin/env bash

# node.js install 5.*
curl -sL https://rpm.nodesource.com/setup_5.x | bash -
yum install -y nodejs

# node.js version
node -v
npm --version

npm install -g jshint
npm install -g grunt
npm install -g gulp
