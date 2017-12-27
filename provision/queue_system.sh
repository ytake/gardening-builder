#!/usr/bin/env bash

# rabbitmq install
wget https://packages.erlang-solutions.com/erlang-solutions-1.0-1.noarch.rpm
rpm -Uvh erlang-solutions-1.0-1.noarch.rpm
sudo yum install -y erlang socat

wget https://dl.bintray.com/rabbitmq/all/rabbitmq-server/3.7.2/rabbitmq-server-3.7.2-1.el7.noarch.rpm
sudo rpm --import https://www.rabbitmq.com/rabbitmq-release-signing-key.asc
rpm -Uvh rabbitmq-server-3.7.2-1.el7.noarch.rpm

systemctl enable rabbitmq-server
systemctl start rabbitmq-server

rabbitmq-plugins enable rabbitmq_management
chown -R rabbitmq:rabbitmq /var/lib/rabbitmq/

rabbitmqctl add_user gardening 00:secreT,@
rabbitmqctl set_user_tags gardening administrator
rabbitmqctl set_permissions -p / gardening ".*" ".*" ".*"

# beanstalkd
# configure /etc/sysconfig/beanstalkd
sudo yum install -y beanstalkd --enablerepo=epel-testing
systemctl enable beanstalkd
systemctl start beanstalkd
