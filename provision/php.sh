#!/usr/bin/env bash

sudo yum install iy libyaml-devel

# php70 developer files
sudo yum install -y --enablerepo=remi-safe php70-php-devel php70-php-pecl-igbinary-devel php70-php-pecl-pcs-devel php70-php-phalcon3

# php71 developer files
sudo yum install -y --enablerepo=remi-safe php71-php-devel php71-php-pecl-igbinary-devel php71-php-pecl-pcs-devel php71-php-phalcon3

# php72 developer files
sudo yum install -y --enablerepo=remi-safe php72-php-devel php72-php-pecl-igbinary-devel php72-php-pecl-pcs-devel php72-php-phalcon3

# php70 extensions
sudo yum install -y --enablerepo=remi-safe php70-php-xml php70-php-sqlsrv php70-php-soap \
php70-php-pgsql php70-php-pecl-zmq php70-php-pecl-zip php70-php-pecl-yaml php70-php-pecl-xdebug php70-php-pecl-uuid php70-php-pecl-uopz \
php70-php-pecl-stomp php70-php-pecl-ssh2 php70-php-pecl-solr2 php70-php-pecl-redis php70-php-pecl-rdkafka \
php70-php-pecl-pcs php70-php-pecl-msgpack php70-php-pecl-mongodb php70-php-pecl-memprof php70-php-pecl-memcached php70-php-pecl-mcrypt \
php70-php-pecl-libsodium php70-php-pecl-imagick php70-php-pecl-event php70-php-pecl-amqp php70-php-pecl-apcu php70-php-pecl-apcu-bc \
php70-php-pear php70-php-pdo-dblib php70-php-pdo php70-php-opcache php70-php-mysqlnd php70-php-mbstring \
php70-php-ldap php70-php-gd php70-php-fpm php70-php-dbg php70-php-common php70-php-cli php70-php-bcmath php70-php-ast php70-php-xmlrpc php70-zephir

# php71 extensions
sudo yum install -y --enablerepo=remi-safe php71-php-xml php71-php-sqlsrv php71-php-soap \
php71-php-pgsql php71-php-pecl-zmq php71-php-pecl-zip php71-php-pecl-yaml php71-php-pecl-xdebug php71-php-pecl-uuid php71-php-pecl-uopz \
php71-php-pecl-stomp php71-php-pecl-ssh2 php71-php-pecl-solr2 php71-php-pecl-redis php71-php-pecl-rdkafka \
php71-php-pecl-pcs php71-php-pecl-msgpack php71-php-pecl-mongodb php71-php-pecl-memprof php71-php-pecl-memcached php71-php-pecl-mcrypt \
php71-php-pecl-libsodium php71-php-pecl-imagick php71-php-pecl-event php71-php-pecl-amqp php71-php-pecl-apcu php71-php-pecl-apcu-bc \
php71-php-pear php71-php-pdo-dblib php71-php-pdo  php71-php-opcache php71-php-mysqlnd php71-php-mbstring \
php71-php-ldap php71-php-gd php71-php-fpm php71-php-dbg php71-php-common php71-php-cli php71-php-bcmath php71-php-ast php71-php-xmlrpc php71-zephir

# php72 extensions
sudo yum install -y --enablerepo=remi-safe php72-php-xml php72-php-sqlsrv php72-php-soap \
php72-php-pgsql php72-php-pecl-zmq php72-php-pecl-zip php72-php-pecl-yaml php72-php-pecl-xdebug php72-php-pecl-uuid php72-php-pecl-uopz \
php72-php-pecl-stomp php72-php-pecl-ssh2 php72-php-pecl-solr2 php72-php-pecl-redis php72-php-pecl-rdkafka \
php72-php-pecl-pcs php72-php-pecl-msgpack php72-php-pecl-mongodb php72-php-pecl-memprof php72-php-pecl-memcached php72-php-pecl-mcrypt \
php72-php-pecl-libsodium php72-php-pecl-imagick php72-php-pecl-event php72-php-pecl-amqp php72-php-pecl-apcu php72-php-pecl-apcu-bc \
php72-php-pear php72-php-pdo-dblib php72-php-pdo  php72-php-opcache php72-php-mysqlnd php72-php-mbstring \
php72-php-ldap php72-php-gd php72-php-fpm php72-php-dbg php72-php-common php72-php-cli php72-php-bcmath php72-php-ast php72-php-xmlrpc php72-zephir

# php70 environment/libraries
sudo yum install -y --enablerepo=remi-safe php70-php-intl php70-php-json php70-php-pecl-igbinary php70-php-sodium

# php71 environment/libraries
sudo yum install -y --enablerepo=remi-safe php71-php-intl php71-php-json php71-php-pecl-igbinary php71-php-sodium

# php72 environment/libraries
sudo yum install -y --enablerepo=remi-safe php72-php-intl php72-php-json php72-php-pecl-igbinary php72-php-sodium

# php alternatives
sudo update-alternatives \
--install /bin/php php /opt/remi/php72/root/usr/bin/php 30 \
--slave /bin/erb pear /opt/remi/php72/root/usr/bin/pear \
--slave /bin/phpdbg phpdbg /opt/remi/php72/root/usr/bin/phpdbg \
--slave /bin/php-cgi php-cgi /opt/remi/php72/root/usr/bin/php-cgi \
--slave /bin/phar phar /opt/remi/php72/root/usr/bin/phar.phar \
--slave /bin/php-config php-config /opt/remi/php72/root/usr/bin/php-config \
--slave /bin/pecl pecl /opt/remi/php72/root/usr/bin/pecl \
--slave /bin/phpize phpize /opt/remi/php72/root/usr/bin/phpize \
--slave /bin/zephir zephir /opt/remi/php72/root/usr/bin/zephir

sudo update-alternatives \
--install /bin/php php /opt/remi/php71/root/usr/bin/php 20 \
--slave /bin/erb pear /opt/remi/php71/root/usr/bin/pear \
--slave /bin/phpdbg phpdbg /opt/remi/php71/root/usr/bin/phpdbg \
--slave /bin/php-cgi php-cgi /opt/remi/php71/root/usr/bin/php-cgi \
--slave /bin/phar phar /opt/remi/php71/root/usr/bin/phar.phar \
--slave /bin/php-config php-config /opt/remi/php71/root/usr/bin/php-config \
--slave /bin/pecl pecl /opt/remi/php71/root/usr/bin/pecl \
--slave /bin/phpize phpize /opt/remi/php71/root/usr/bin/phpize \
--slave /bin/zephir zephir /opt/remi/php71/root/usr/bin/zephir

sudo update-alternatives \
--install /bin/php php /opt/remi/php70/root/usr/bin/php 10 \
--slave /bin/erb pear /opt/remi/php70/root/usr/bin/pear \
--slave /bin/phpdbg phpdbg /opt/remi/php70/root/usr/bin/phpdbg \
--slave /bin/php-cgi php-cgi /opt/remi/php70/root/usr/bin/php-cgi \
--slave /bin/phar phar /opt/remi/php70/root/usr/bin/phar.phar \
--slave /bin/php-config php-config /opt/remi/php70/root/usr/bin/php-config \
--slave /bin/pecl pecl /opt/remi/php70/root/usr/bin/pecl \
--slave /bin/phpize phpize /opt/remi/php70/root/usr/bin/phpize \
--slave /bin/zephir zephir /opt/remi/php70/root/usr/bin/zephir


# composer install
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer
chmod 755 /usr/local/bin/composer
sudo chown vagrant /usr/local/bin/composer

printf "\nPATH=\"/home/vagrant/.config/composer/vendor/bin:\$PATH\"\n" | tee -a /home/vagrant/.profile

# php70 ini setup
sed -i "s/display_errors = .*/display_errors = On/" /etc/opt/remi/php70/php.ini
sed -i "s/memory_limit = .*/memory_limit = 512M/" /etc/opt/remi/php70/php.ini
sed -i "s/;date.timezone.*/date.timezone = Asia\/Tokyo/" /etc/opt/remi/php70/php.ini
sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/opt/remi/php70/php.ini

## php70 xdebug
echo "xdebug.remote_enable = 1" >> /etc/opt/remi/php70/php.d/15-xdebug.ini
echo "xdebug.remote_connect_back = 1" >> /etc/opt/remi/php70/php.d/15-xdebug.ini
echo "xdebug.remote_port = 9070" >> /etc/opt/remi/php70/php.d/15-xdebug.ini
echo "xdebug.max_nesting_level = 512" >> /etc/opt/remi/php70/php.d/15-xdebug.ini
echo "xdebug.idekey = PHPSTORM" >> /etc/opt/remi/php70/php.d/15-xdebug.ini
echo "xdebug.remote_autostart = 1" >> /etc/opt/remi/php70/php.d/15-xdebug.ini
echo "opcache.revalidate_freq = 0" >> /etc/opt/remi/php70/php.d/10-opcache.ini

sed -i -e "s/listen = 127.0.0.1:9000/listen = \/var\/run\/php70-fpm.sock/g" /etc/opt/remi/php70/php-fpm.d/www.conf
sed -i "s|user = apache|user = vagrant|g" /etc/opt/remi/php70/php-fpm.d/www.conf
sed -i "s|group = apache|group = vagrant|g" /etc/opt/remi/php70/php-fpm.d/www.conf

sed -i "s/;listen\.owner.*/listen.owner = vagrant/" /etc/opt/remi/php70/php-fpm.d/www.conf
sed -i "s/;listen\.group.*/listen.group = vagrant/" /etc/opt/remi/php70/php-fpm.d/www.conf
sed -i "s/;listen\.mode.*/listen.mode = 0666/" /etc/opt/remi/php70/php-fpm.d/www.conf

# php71 ini setup
sed -i "s/display_errors = .*/display_errors = On/" /etc/opt/remi/php71/php.ini
sed -i "s/memory_limit = .*/memory_limit = 512M/" /etc/opt/remi/php71/php.ini
sed -i "s/;date.timezone.*/date.timezone = Asia\/Tokyo/" /etc/opt/remi/php71/php.ini
sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/opt/remi/php71/php.ini

## php71 xdebug
echo "xdebug.remote_enable = 1" >> /etc/opt/remi/php71/php.d/15-xdebug.ini
echo "xdebug.remote_connect_back = 1" >> /etc/opt/remi/php71/php.d/15-xdebug.ini
echo "xdebug.remote_port = 9071" >> /etc/opt/remi/php71/php.d/15-xdebug.ini
echo "xdebug.max_nesting_level = 512" >> /etc/opt/remi/php71/php.d/15-xdebug.ini
echo "xdebug.idekey = PHPSTORM" >> /etc/opt/remi/php71/php.d/15-xdebug.ini
echo "xdebug.remote_autostart = 1" >> /etc/opt/remi/php71/php.d/15-xdebug.ini
echo "opcache.revalidate_freq = 0" >> /etc/opt/remi/php71/php.d/10-opcache.ini

sed -i -e "s/listen = 127.0.0.1:9000/listen = \/var\/run\/php71-fpm.sock/g" /etc/opt/remi/php71/php-fpm.d/www.conf
sed -i "s|user = apache|user = vagrant|g" /etc/opt/remi/php71/php-fpm.d/www.conf
sed -i "s|group = apache|group = vagrant|g" /etc/opt/remi/php71/php-fpm.d/www.conf

sed -i "s/;listen\.owner.*/listen.owner = vagrant/" /etc/opt/remi/php71/php-fpm.d/www.conf
sed -i "s/;listen\.group.*/listen.group = vagrant/" /etc/opt/remi/php71/php-fpm.d/www.conf
sed -i "s/;listen\.mode.*/listen.mode = 0666/" /etc/opt/remi/php71/php-fpm.d/www.conf

# php72 ini setup
sed -i "s/display_errors = .*/display_errors = On/" /etc/opt/remi/php72/php.ini
sed -i "s/memory_limit = .*/memory_limit = 512M/" /etc/opt/remi/php72/php.ini
sed -i "s/;date.timezone.*/date.timezone = Asia\/Tokyo/" /etc/opt/remi/php72/php.ini
sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/opt/remi/php72/php.ini

## php72 xdebug
echo "xdebug.remote_enable = 1" >> /etc/opt/remi/php72/php.d/15-xdebug.ini
echo "xdebug.remote_connect_back = 1" >> /etc/opt/remi/php72/php.d/15-xdebug.ini
echo "xdebug.remote_port = 9072" >> /etc/opt/remi/php72/php.d/15-xdebug.ini
echo "xdebug.max_nesting_level = 512" >> /etc/opt/remi/php72/php.d/15-xdebug.ini
echo "xdebug.idekey = PHPSTORM" >> /etc/opt/remi/php72/php.d/15-xdebug.ini
echo "xdebug.remote_autostart = 1" >> /etc/opt/remi/php72/php.d/15-xdebug.ini
echo "opcache.revalidate_freq = 0" >> /etc/opt/remi/php72/php.d/10-opcache.ini

sed -i -e "s/listen = 127.0.0.1:9000/listen = \/var\/run\/php72-fpm.sock/g" /etc/opt/remi/php72/php-fpm.d/www.conf
sed -i "s|user = apache|user = vagrant|g" /etc/opt/remi/php72/php-fpm.d/www.conf
sed -i "s|group = apache|group = vagrant|g" /etc/opt/remi/php72/php-fpm.d/www.conf

sed -i "s/;listen\.owner.*/listen.owner = vagrant/" /etc/opt/remi/php72/php-fpm.d/www.conf
sed -i "s/;listen\.group.*/listen.group = vagrant/" /etc/opt/remi/php72/php-fpm.d/www.conf
sed -i "s/;listen\.mode.*/listen.mode = 0666/" /etc/opt/remi/php72/php-fpm.d/www.conf

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

sudo yum install -y --enablerepo=remi-safe libcouchbase-devel libcouchbase-tools automake cmake gcc gcc-c++ git libtool openssl-devel wget gmp gmp-devel boost pcre-devel git

###############################################################
## cassandra
###############################################################

sudo rpm -Uvh http://downloads.datastax.com/cpp-driver/centos/7/dependencies/libuv/v1.11.0/libuv-1.11.0-1.el7.centos.x86_64.rpm
sudo yum install -y --enablerepo=remi-safe cassandra-cpp-driver

###############################################################
## xhprof
## https://github.com/Yaoguais/phpng-xhprof
###############################################################
cd /home/vagrant
git clone https://github.com/Yaoguais/phpng-xhprof.git ./xhprof
cd xhprof

/opt/remi/php70/root/usr/bin/phpize
./configure --with-php-config=/opt/remi/php70/root/usr/bin/php-config
sudo make && sudo make install
sudo sh -c "echo 'extension=phpng_xhprof.so' >> /etc/opt/remi/php70/php.d/50-phpng_xhprof.ini"
sudo echo "xhprof.output_dir = /tmp/xhprof" >> /etc/opt/remi/php70/php.d/50-phpng_xhprof.ini
sudo make clean

/opt/remi/php71/root/usr/bin/phpize
./configure --with-php-config=/opt/remi/php71/root/usr/bin/php-config
sudo make && sudo make install
sudo sh -c "echo 'extension=phpng_xhprof.so' >> /etc/opt/remi/php71/php.d/50-phpng_xhprof.ini"
sudo echo "xhprof.output_dir = /tmp/xhprof" >> /etc/opt/remi/php71/php.d/50-phpng_xhprof.ini
sudo make clean

/opt/remi/php72/root/usr/bin/phpize
./configure --with-php-config=/opt/remi/php72/root/usr/bin/php-config
sudo make && sudo make install
sudo sh -c "echo 'extension=phpng_xhprof.so' >> /etc/opt/remi/php72/php.d/50-phpng_xhprof.ini"
sudo echo "xhprof.output_dir = /tmp/xhprof" >> /etc/opt/remi/php72/php.d/50-phpng_xhprof.ini
sudo make clean

cd ..
sudo rm -rf /home/vagrant/xhprof

## append php70 extension
sudo yum install -y --enablerepo=remi-safe php70-php-pecl-couchbase2 php70-php-pecl-cassandra php70-php-phpiredis

## append php71 extension
sudo yum install -y --enablerepo=remi-safe php71-php-pecl-couchbase2 php71-php-pecl-cassandra php71-php-phpiredis

## append php72 extension
sudo yum install -y --enablerepo=remi-safe php72-php-pecl-couchbase2 php72-php-pecl-cassandra php72-php-phpiredis

