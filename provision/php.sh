#!/usr/bin/env bash

rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm

sudo yum install -y --enablerepo=remi --enablerepo=remi-php56 php php-opcache php-devel php-fpm php-gd php-pdo php-dom \
php-mbstring php-mcrypt php-mysqlnd php-mssql \
php-pecl-xdebug php-pecl-xhprof \ php-openssl php-json php-pecl-apcu php-pdo_sqlite php-pdo_mysql \
php-pecl-memcached php-pecl-couchbase2 php-pecl-zmq php-bcmath php-msgpack php-ldap \
php-pecl-imagick php-pgsql php-pecl-stomp php-pecl-zmq

# composer install
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer
printf "\nPATH=\"/home/vagrant/.composer/vendor/bin:\$PATH\"\n" | tee -a /home/vagrant/.profile

sed -i "s/display_errors = .*/display_errors = On/" /etc/php.ini
sed -i "s/memory_limit = .*/memory_limit = 512M/" /etc/php.ini
sed -i "s/;date.timezone.*/date.timezone = Asia\/Tokyo/" /etc/php.ini

# for xdebug
echo "xdebug.remote_enable = 1" >> /etc/php.d/15-xdebug.ini
echo "xdebug.remote_connect_back = 1" >> /etc/php.d/15-xdebug.ini
echo "xdebug.remote_port = 9080" >> /etc/php.d/15-xdebug.ini
echo "xdebug.max_nesting_level = 512" >> /etc/php.d/15-xdebug.ini
echo "xdebug.idekey = PHPSTORM" >> /etc/php.d/15-xdebug.ini

echo "opcache.revalidate_freq = 0" >> /etc/php.d/10-opcache.ini

sed -i -e "s/listen = 127.0.0.1:9000/listen = \/var\/run\/php5-fpm.sock/g" /etc/php-fpm.d/www.conf
sed -i "s|user = apache|user = vagrant|g" /etc/php-fpm.d/www.conf
sed -i "s|group = apache|group = vagrant|g" /etc/php-fpm.d/www.conf

sed -i "s/;listen\.owner.*/listen.owner = vagrant/" /etc/php-fpm.d/www.conf
sed -i "s/;listen\.group.*/listen.group = vagrant/" /etc/php-fpm.d/www.conf
sed -i "s/;listen\.mode.*/listen.mode = 0666/" /etc/php-fpm.d/www.conf

sudo su vagrant <<'EOF'
/usr/local/bin/composer global require "fabpot/php-cs-fixer"
/usr/local/bin/composer global require "squizlabs/php_codesniffer=*"
/usr/local/bin/composer global require "phpmd/phpmd=*"
EOF

echo "
export PATH=\"\$PATH:\$HOME/.composer/vendor/bin\"
" >> /home/vagrant/.bash_profile
