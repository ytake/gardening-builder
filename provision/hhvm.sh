#!/usr/bin/env bash

#!/usr/bin/env bash

sudo yum install -y libc-client
sudo yum install -y libdwarf
sudo yum install -y libyaml
sudo yum install -y lz4-devel lz4
sudo yum install -y tbb
sudo yum install -y inotify-tools
sudo rpm -Uvh http://dl.fedoraproject.org/pub/epel/7/x86_64/i/inotify-tools-devel-3.14-8.el7.x86_64.rpm
sudo rpm -Uvh http://mirrors.linuxeye.com/hhvm-repo/7/x86_64/hhvm-3.12.0-1.el7.centos.x86_64.rpm

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
