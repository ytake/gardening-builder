#!/usr/bin/env bash

sudo yum install -y --enablerepo=remi --enablerepo=remi-php70 php php-opcache php-devel php-fpm php-gd php-pdo php-dom \
php-mbstring php-mcrypt php-mysqlnd php-sqlsrv php-pear.noarch php-pdo-dblib \
php-pecl-xdebug php-openssl php-json php-pecl-apcu php-pecl-apcu-bc php-pdo_sqlite php-pdo_mysql \
php-pecl-memcached php-bcmath php-msgpack php-ldap php-pecl-uopz php-pecl-redis \
php-pecl-imagick php-pgsql php-pecl-pthreads php-pecl-mongodb php-pecl-zmq php-pecl-stomp php-pecl-amqp

# composer install
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer
printf "\nPATH=\"/home/vagrant/.config/composer/vendor/bin:\$PATH\"\n" | tee -a /home/vagrant/.profile

sed -i "s/display_errors = .*/display_errors = On/" /etc/php.ini
sed -i "s/memory_limit = .*/memory_limit = 512M/" /etc/php.ini
sed -i "s/;date.timezone.*/date.timezone = Asia\/Tokyo/" /etc/php.ini

###############################################################
## xdebug
###############################################################
echo "xdebug.remote_enable = 1" >> /etc/php.d/15-xdebug.ini
echo "xdebug.remote_connect_back = 1" >> /etc/php.d/15-xdebug.ini
echo "xdebug.remote_port = 9080" >> /etc/php.d/15-xdebug.ini
echo "xdebug.max_nesting_level = 512" >> /etc/php.d/15-xdebug.ini
echo "xdebug.idekey = PHPSTORM" >> /etc/php.d/15-xdebug.ini

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
pushd /tmp
wget http://dist.libuv.org/dist/v1.9.1/libuv-v1.9.1.tar.gz
tar xzf libuv-v1.9.1.tar.gz
pushd libuv-v1.9.1
sh autogen.sh
./configure
sudo make install
popd
popd
sudo rpm -Uvh http://downloads.datastax.com/cpp-driver/centos/7/cassandra/v2.4.3/cassandra-cpp-driver-2.4.3-1.el7.centos.x86_64.rpm

###############################################################
## cassandra
###############################################################
git clone https://github.com/datastax/cpp-driver.git
sudo mkdir cpp-driver/build
cd cpp-driver/build
sudo cmake ..
sudo make
sudo make install
cd ..
sudo pecl install cassandra
sudo sh -c "echo 'extension=cassandra.so' >> /etc/php.d/50-cassandra.ini"
cd ..
sudo rm -rf /home/vagrant/cpp-driver

###############################################################
## xhprof
## https://github.com/Yaoguais/phpng-xhprof
###############################################################
git clone https://github.com/Yaoguais/phpng-xhprof.git ./xhprof
cd xhprof
phpize
./configure
sudo make && sudo make install

sudo sh -c "echo 'extension=phpng_xhprof.so' >> /etc/php.d/50-phpng_xhprof.ini"
sudo echo "xhprof.output_dir = /tmp/xhprof" >> /etc/php.d/50-phpng_xhprof.ini
cd ..
sudo rm -rf xhprof

## phalcon
# curl -s https://packagecloud.io/install/repositories/phalcon/stable/script.rpm.sh | sudo bash

# git clone --depth=1 https://github.com/phalcon/cphalcon
# cd  cphalcon/
# sudo ./build/install
# sudo sh -c "echo 'extension=phalcon.so' >> /etc/php.d/50-phalcon.ini"

## append php extension
sudo yum install -y --enablerepo=remi --enablerepo=remi-php70 php-phpiredis php-pecl-couchbase2  \
php-phalcon3 apcu-panel
