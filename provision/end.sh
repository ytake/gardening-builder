#!/usr/bin/env bash

sudo echo -en "\033[1;34m" > /etc/motd
sudo echo '>>>>>>>>>> scripting language <<<<<<<<<<' >> /etc/motd
sudo echo `php -r \@phpinfo\(\)\; | grep 'PHP Version' -m 1` >> /etc/motd
sudo echo `/usr/local/bin/hhvm --version | grep 'HipHop'` >> /etc/motd
sudo echo 'node.js:' `node -v` >> /etc/motd
sudo echo '>>>>>>>>>> data storage <<<<<<<<<<' >> /etc/motd
sudo echo `memcached -h | grep 'memcached' -m 1` >> /etc/motd
sudo echo `redis-server --version` >> /etc/motd
sudo echo `psql --version` >> /etc/motd
sudo echo `mysql --version` >> /etc/motd
sudo echo `mongo -version` >> /etc/motd
sudo echo `/opt/couchbase/bin/couchbase-server -v` >> /etc/motd
sudo echo 'Elasticsearch 2.x' >> /etc/motd
sudo echo '>>>>>>>>>> web servers <<<<<<<<<<' >> /etc/motd
sudo echo `httpd -v | grep Apache -m 1` >> /etc/motd
sudo echo `nginx -v` >> /etc/motd
sudo echo '' >> /etc/motd
sudo echo -en "\033[0m" >> /etc/motd
sudo echo '----------------------------------------------' >> /etc/motd
sudo echo '>>>>>>>>>> gardening author <<<<<<<<<<' >> /etc/motd
sudo echo ' Copyright (c) 2015-2016 Yuuki Takezawa<yuuki.takezawa@comnect.jp.net> ' >> /etc/motd
sudo echo ' The MIT License (MIT) ' >> /etc/motd
sudo echo '----------------------------------------------' >> /etc/motd
