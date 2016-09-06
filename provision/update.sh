#!/usr/bin/env bash

# Update CentOS first
yum update

# Need to get EPEL repositories
rpm -Uvh http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm

sudo yum install -y epel-release
rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
sudo rm -f remi-release-7.rpm

sudo yum update
sudo yum install -y telnet

sudo yum install -y telnet

## to japanese
sudo yum -y install ibus-kkc vlgothic-*
localectl set-locale LANG=ja_JP.UTF-8
source /etc/locale.conf
timedatectl set-timezone Asia/Tokyo

sudo yum groupinstall 'Development tools'
sudo yum -y install vim
sudo yum install -y unzip

sudo yum install -y cronie
/bin/systemctl enable crond
/bin/systemctl restart crond

# iptables無効
iptables -F
systemctl disable firewalld.service

# SELinux無効
cp /vagrant/rewrites/selinux.conf /etc/selinux/config
setenforce 0

sudo yum install -y git
sudo yum install -y expect

# openssl
sudo yum install -y openssl-devel readline-devel zlib-devel gcc gcc-c++ boost zeromq-devel
# sudo yum update -y kernel
# sudo yum install -y kernel-devel kernel-headers dkms
# sudo /etc/init.d/vboxadd setup

# for memory swap
/bin/dd if=/dev/zero of=/var/swap.1 bs=1M count=1024
/sbin/mkswap /var/swap.1
/sbin/swapon /var/swap.1

# for freetds
yum install -y freetds

echo "
export PS1=\"\[\e[1;32m\][\u@\h:\w]\$\[\e[00m\] \"
" >> /home/vagrant/.bash_profile

# install java
sudo yum install -y java
java -version
export JAVA_HOME=/usr/bin

# re2c
rpm -Uvh http://mirrors.karan.org/epel7/Packages/re2c/20131231011915/0.13.5-1.el6.x86_64/re2c-0.13.5-1.el7.x86_64.rpm
rpm -Uvh http://downloads.datastax.com/cpp-driver/centos/7/dependencies/libuv/v1.8.0/libuv-1.8.0-1.el7.centos.x86_64.rpm
