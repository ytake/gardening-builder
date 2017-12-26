#!/usr/bin/env bash

yum-complete-transaction -y

# Gardening include

# install couchbase
wget https://packages.couchbase.com/releases/5.0.1/couchbase-server-community-5.0.1-centos7.x86_64.rpm
rpm -ivh couchbase-server-community-5.0.1-centos7.x86_64.rpm

rm -rf couchbase-server-community-5.0.1-centos7.x86_64.rpm

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
