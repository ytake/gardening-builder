#!/usr/bin/env bash

# Gardening include

# install couchbase
wget http://packages.couchbase.com/releases/4.0.0/couchbase-server-community-4.0.0-centos7.x86_64.rpm
rpm -ivh couchbase-server-community-4.0.0-centos7.x86_64.rpm

rm -rf couchbase-server-community-4.0.0-centos7.x86_64.rpm

# install mongodb
cat > /etc/yum.repos.d/mongodb-org-3.2.repo << EOF
[mongodb-org-3.2]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/\$releasever/mongodb-org/3.2/x86_64/
gpgcheck=0
enabled=1
EOF

sudo yum clean all
sudo yum update

sudo yum install -y mongodb-org
