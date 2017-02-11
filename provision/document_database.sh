#!/usr/bin/env bash

# Gardening include

# install couchbase
wget http://packages.couchbase.com/releases/4.5.0/couchbase-server-community-4.5.0-centos7.x86_64.rpm
rpm -ivh couchbase-server-community-4.5.0-centos7.x86_64.rpm

rm -rf couchbase-server-community-4.5.0-centos7.x86_64.rpm

# install mongodb
cat > /etc/yum.repos.d/mongodb-org-3.4.repo << EOF
[mongodb-org-3.4]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/\$releasever/mongodb-org/3.4/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-3.4.asc
EOF

sudo yum clean all
sudo yum update

sudo yum install -y mongodb-org
