#!/usr/bin/env bash

sudo echo -en "\033[1;34m" > /etc/motd
sudo echo '>>>>>>>>>> scripting language <<<<<<<<<<' >> /etc/motd
sudo echo "[PHP]" $(php -v | grep PHP -m 1 2>&1) >> /etc/motd
sudo echo "[Node.js]" $(node -v 2>&1) >> /etc/motd
sudo echo '>>>>>>>>>> data storage <<<<<<<<<<' >> /etc/motd
sudo echo "[memcached]" $(memcached -h | grep 'memcached' -m 1) >> /etc/motd
sudo echo "[Redis]" $(redis-server --version) >> /etc/motd
sudo echo "[PostgreSQL]" $(psql --version) >> /etc/motd
sudo echo "[mysql]" $(mysql --version 2>&1) >> /etc/motd
sudo echo "[mongodb]" $(mongo -version 2>&1) >> /etc/motd
sudo echo "[couchbase]" $(/opt/couchbase/bin/couchbase-server -v 2>&1) >> /etc/motd
sudo echo '>>>>>>>>>> web servers <<<<<<<<<<' >> /etc/motd
sudo echo "[apache]" $(httpd -v | grep Apache 2>&1) >> /etc/motd
sudo echo "[nginx]" $(nginx -v 2>&1) >> /etc/motd
sudo echo -en "\033[0m" >> /etc/motd
sudo echo '----------------------------------------------' >> /etc/motd
sudo echo '>>>>>>>>>> gardening author <<<<<<<<<<' >> /etc/motd
sudo echo ' Copyright (c) 2015-2017 Yuuki Takezawa<yuuki.takezawa@comnect.jp.net> ' >> /etc/motd
sudo echo ' The MIT License (MIT) ' >> /etc/motd
sudo echo '----------------------------------------------' >> /etc/motd
