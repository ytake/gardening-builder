#!/usr/bin/env bash

wget https://copr.fedoraproject.org/coprs/no1youknowz/hhvm-repo/repo/epel-7/no1youknowz-hhvm-repo-epel-7.repo -O /etc/yum.repos.d/no1youknowz-hhvm-repo-epel-7.repo
yum install -y hhvm

echo "hhvm.server.user = vagrant" >> /etc/hhvm/server.ini
echo "hhvm.log.header = true" >> /etc/hhvm/server.ini
echo "hhvm.debug.server_error_message" >> /etc/hhvm/server.ini
echo "display_errors = On" >> /etc/hhvm/server.ini
echo "html_errors = On" >> /etc/hhvm/server.ini
echo "error_reporting = 22527" >> /etc/hhvm/server.ini
echo "hhvm.server.fix_path_info = true" >> /etc/hhvm/server.ini

sed -i "s/date.timezone.*/date.timezone = Asia\/Tokyo/" /etc/hhvm/php.ini
sed -i "s/ExecStart=\/usr\/bin\/hhvm -c \/etc\/hhvm\/server.ini -c \/etc\/hhvm\/php.ini --user hhvm --mode daemon*/ExecStart=\/usr\/bin\/hhvm -c \/etc\/hhvm\/server.ini -c \/etc\/hhvm\/php.ini --user vagrant --mode daemon/" /usr/lib/systemd/system/hhvm.service

mkdir /var/run/hhvm
chmod 775 /var/run/hhvm
mkdir /var/log/hhvm
chmod 777 /var/log/hhvm
