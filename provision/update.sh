#!/usr/bin/env bash

# Update CentOS first
yum update

# Need to get EPEL repositories
rpm -Uvh http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm
sudo yum update
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
sudo yum install -y openssl-devel
sudo yum install -y readline-devel
sudo yum install -y zlib-devel
sudo yum install -y gcc
sudo yum install -y gcc-c++
sudo yum install -y boost

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
