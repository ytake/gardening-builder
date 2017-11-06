#!/usr/bin/env bash

sudo yum install -y --enablerepo=remi --enablerepo=remi-php71 php php-fpm \
php-opcache php-devel php-fpm php-gd php-pdo php-dom \
php-mbstring php-mcrypt php-mysqlnd php-sqlsrv php-pear.noarch php-pdo-dblib php-pecl-event \
php-pecl-xdebug php-openssl php-json php-pecl-apcu php-pecl-apcu-bc php-pdo_sqlite php-pdo_mysql \
php-pecl-igbinary php-pecl-igbinary-devel php-pecl-zip \
php-pecl-memcached php-bcmath php-msgpack php-ldap php-pecl-uopz php-pecl-redis \
php-pecl-imagick php-pgsql php-pecl-pthreads php-pecl-mongodb php-pecl-zmq php-pecl-stomp php-pecl-amqp php-intl

# composer install
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer
chmod 755 /usr/local/bin/composer
sudo chown vagrant /usr/local/bin/composer

printf "\nPATH=\"/home/vagrant/.config/composer/vendor/bin:\$PATH\"\n" | tee -a /home/vagrant/.profile

sed -i "s/display_errors = .*/display_errors = On/" /etc/php.ini
sed -i "s/memory_limit = .*/memory_limit = 512M/" /etc/php.ini
sed -i "s/;date.timezone.*/date.timezone = Asia\/Tokyo/" /etc/php.ini
sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php.ini

###############################################################
## xdebug
###############################################################
echo "xdebug.remote_enable = 1" >> /etc/php.d/15-xdebug.ini
echo "xdebug.remote_connect_back = 1" >> /etc/php.d/15-xdebug.ini
echo "xdebug.remote_port = 9080" >> /etc/php.d/15-xdebug.ini
echo "xdebug.max_nesting_level = 512" >> /etc/php.d/15-xdebug.ini
echo "xdebug.idekey = PHPSTORM" >> /etc/php.d/15-xdebug.ini
echo "xdebug.remote_autostart = 1" >> /etc/php.d/15-xdebug.ini

echo "opcache.revalidate_freq = 0" >> /etc/php.d/10-opcache.ini

sed -i -e "s/listen = 127.0.0.1:9000/listen = \/var\/run\/php7-fpm.sock/g" /etc/php-fpm.d/www.conf
sed -i "s|user = apache|user = vagrant|g" /etc/php-fpm.d/www.conf
sed -i "s|group = apache|group = vagrant|g" /etc/php-fpm.d/www.conf

sed -i "s/;listen\.owner.*/listen.owner = vagrant/" /etc/php-fpm.d/www.conf
sed -i "s/;listen\.group.*/listen.group = vagrant/" /etc/php-fpm.d/www.conf
sed -i "s/;listen\.mode.*/listen.mode = 0666/" /etc/php-fpm.d/www.conf

###############################################################
## composer global
###############################################################
sudo su vagrant <<'EOF'
/usr/local/bin/composer global require "hirak/prestissimo:^0.3"
/usr/local/bin/composer global require "friendsofphp/php-cs-fixer"
/usr/local/bin/composer global require "squizlabs/php_codesniffer=*"
/usr/local/bin/composer global require "phpmd/phpmd=*"
/usr/local/bin/composer global require "phpmetrics/phpmetrics"
EOF

echo "
export PATH=\"\$PATH:\$HOME/.config/composer/vendor/bin\"
" >> /home/vagrant/.bash_profile

###############################################################
## couchbase
###############################################################

sudo yum install -y openssl-devel libcouchbase-devel
sudo yum install -y --enablerepo=remi --enablerepo=remi-php70 automake cmake gcc gcc-c++ git libtool openssl-devel wget gmp gmp-devel boost pcre-devel git

###############################################################
## cassandra
###############################################################

sudo rpm -Uvh http://downloads.datastax.com/cpp-driver/centos/7/dependencies/libuv/v1.11.0/libuv-1.11.0-1.el7.centos.x86_64.rpm
sudo rpm -Uvh http://downloads.datastax.com/cpp-driver/centos/7/cassandra/v2.7.0/cassandra-cpp-driver-2.7.0-1.el7.centos.x86_64.rpm

###############################################################
## xhprof
## https://github.com/Yaoguais/phpng-xhprof
###############################################################
cd /home/vagrant
git clone https://github.com/Yaoguais/phpng-xhprof.git ./xhprof
cd xhprof
phpize
./configure
sudo make && sudo make install

sudo sh -c "echo 'extension=phpng_xhprof.so' >> /etc/php.d/50-phpng_xhprof.ini"
sudo echo "xhprof.output_dir = /tmp/xhprof" >> /etc/php.d/50-phpng_xhprof.ini
cd ..
sudo rm -rf xhprof

## append php extension
sudo yum install -y --enablerepo=remi --enablerepo=remi-php71 php-pecl-couchbase2  \
php-phalcon3 apcu-panel php-soap php-pecl-uuid php-pecl-pcs php-pecl-rdkafka php-dbg php-pecl-cassandra \
php-phpiredis php-ast php-pecl-ssh2
