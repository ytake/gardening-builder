#!/usr/bin/env bash

# Update CentOS first
sudo yum update
sudo yum update -y --enablerepo=remi --enablerepo=remi-php56
