#!/usr/bin/env bash

sudo yum install -y GeoIP inotify-tools tbb lz4-devel lz4 libyaml libdwarf libc-client
sudo rpm -Uvh http://dl.fedoraproject.org/pub/epel/7/x86_64/i/inotify-tools-devel-3.14-8.el7.x86_64.rpm

sudo yum install cpp gcc-c++ cmake git psmisc {binutils,boost,jemalloc,numactl}-devel \
{ImageMagick,sqlite,tbb,bzip2,openldap,readline,elfutils-libelf,gmp,lz4,pcre}-devel \
lib{xslt,event,yaml,vpx,png,zip,icu,mcrypt,memcached,cap,dwarf}-devel \
{unixODBC,expat,mariadb}-devel lib{edit,curl,xml2,xslt}-devel \
glog-devel oniguruma-devel ocaml gperf enca libjpeg-turbo-devel openssl-devel \
mariadb mariadb-server make -y

sudo rpm -Uvh http://mirrors.linuxeye.com/hhvm-repo/7/x86_64/hhvm-3.14.4-1.el7.centos.x86_64.rpm

echo "hhvm.server.user = vagrant" >> /etc/hhvm/server.ini
echo "hhvm.log.header = true" >> /etc/hhvm/server.ini
echo "hhvm.debug.server_error_message" >> /etc/hhvm/server.ini
echo "display_errors = On" >> /etc/hhvm/server.ini
echo "html_errors = On" >> /etc/hhvm/server.ini
echo "error_reporting = 22527" >> /etc/hhvm/server.ini
echo "hhvm.server.fix_path_info = true" >> /etc/hhvm/server.ini

sed -i "s|date.timezone = *|date.timezone = Asia\/Tokyo|g" /etc/hhvm/server.ini
sed -i "s|hhvm.server.port = 9001|hhvm.server.port = 9000|g" /etc/hhvm/server.ini

sed -i "s|--user nginx|--user vagrant|g" /usr/lib/systemd/system/hhvm.service
sed -i "s|-vServer.Port=9001|-vServer.Port=9000|g" /usr/lib/systemd/system/hhvm.service

sudo mkdir /var/run/hhvm
sudo chmod 775 /var/run/hhvm
sudo mkdir /var/log/hhvm
sudo chmod 777 /var/log/hhvm
sudo mkdir /var/cache/nginx
sudo chmod 777 /var/cache/nginx
