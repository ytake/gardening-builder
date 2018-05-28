#!/usr/bin/env bash

yum-complete-transaction -y

# Gardening include

# install couchbase
curl -O http://packages.couchbase.com/releases/couchbase-release/couchbase-release-1.0-5-x86_64.rpm
sudo rpm -i couchbase-release-1.0-5-x86_64.rpm
sudo yum update
sudo yum install -y couchbase-server-community

rm -rf couchbase-release-1.0-5-x86_64.rpm

# install mongodb
cat > /etc/yum.repos.d/mongodb-org-3.6.repo << EOF
[mongodb-org-3.6]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/\$releasever/mongodb-org/3.6/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-3.6.asc
EOF

sudo yum clean all
sudo yum update

sudo yum install -y mongodb-org
