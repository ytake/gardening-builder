#!/usr/bin/env bash

# Gardening include

# install couchbase
wget http://packages.couchbase.com/releases/4.1.0/couchbase-server-community-4.1.0-centos7.x86_64.rpm
rpm -ivh couchbase-server-community-4.1.0-centos7.x86_64.rpm

rm -rf couchbase-server-community-4.1.0-centos7.x86_64.rpm

# install mongodb
cat > /etc/yum.repos.d/mongodb-org-3.2.repo << EOF
[mongodb-org-3.2]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/\$releasever/mongodb-org/3.2/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-3.2.asc
EOF

sudo yum clean all
sudo yum update

sudo yum install -y mongodb-org
