#!/usr/bin/env bash

# for mysql 5.6 install
yum remove mysql*

yum -y remove mariadb-libs

wget http://dev.mysql.com/get/mysql-community-release-el6-5.noarch.rpm
rpm -Uvh mysql-community-release-el6-5.noarch.rpm
yum install -y mysql mysql-devel mysql-server mysql-libs

# for backup ini
cp /etc/my.cnf /etc/my.cnf.backup

/bin/systemctl enable mysqld.service
/bin/systemctl start mysqld.service

mysql --user="root" -e "set password = password('secret');"
mysql --user="root" --password="secret" -e "DROP USER ''@'localhost';"
mysql --user="root" --password="secret" -e "GRANT ALL ON *.* TO root@'0.0.0.0' IDENTIFIED BY 'secret' WITH GRANT OPTION;"
mysql --user="root" --password="secret" -e "CREATE USER 'gardening'@'0.0.0.0' IDENTIFIED BY 'secret';"
mysql --user="root" --password="secret" -e "GRANT ALL ON *.* TO 'gardening'@'0.0.0.0' IDENTIFIED BY 'secret' WITH GRANT OPTION;"
mysql --user="root" --password="secret" -e "GRANT ALL ON *.* TO 'gardening'@'%' IDENTIFIED BY 'secret' WITH GRANT OPTION;"
mysql --user="root" --password="secret" -e "FLUSH PRIVILEGES;"
mysql --user="root" --password="secret" -e "CREATE DATABASE gardening;"
mysql --user="root" --password="secret" -e  "set password for 'gardening'@'localhost' = password('secret');"

/bin/systemctl restart mysqld.service

###############################################################
## for postgresql install
###############################################################
wget http://yum.postgresql.org/9.4/redhat/rhel-7-x86_64/pgdg-centos94-9.4-2.noarch.rpm

rpm -ivh pgdg-centos94-9.4-2.noarch.rpm
sudo yum -y install postgresql94-server postgresql94-devel postgresql94-contrib

sudo /usr/pgsql-9.4/bin/postgresql94-setup initdb
/bin/systemctl enable postgresql-9.4.service
/bin/systemctl start postgresql-9.4.service

sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g" /var/lib/pgsql/9.4/data/postgresql.conf
echo "host    all             all             10.0.2.2/32               md5" | tee -a /var/lib/pgsql/9.4/data/pg_hba.conf
sudo -u postgres psql -c "CREATE ROLE gardening LOGIN UNENCRYPTED PASSWORD 'secret' SUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;"
sudo -u postgres /usr/bin/createdb --echo --owner=gardening gardening
/bin/systemctl restart postgresql-9.4.service

rm -rf pgdg-centos94-9.4-2.noarch.rpm

###############################################################
## for memcached
###############################################################
sudo yum install -y memcached memcached-devel

/bin/systemctl enable memcached
/bin/systemctl restart memcached

###############################################################
## Redis
###############################################################
sudo yum --enablerepo=remi,epel install -y redis

sed -i "s/daemonize no/daemonize yes/" /etc/redis.conf
sed -i "s/appendonly no/appendonly yes/" /etc/redis.conf

/bin/systemctl enable redis
/bin/systemctl start redis

###############################################################
## install fluentd
###############################################################
sudo curl -L https://toolbelt.treasuredata.com/sh/install-redhat-td-agent2.sh | sh

echo "
<match local.**>
  type stdout
</match>

# for lumen
<match lumen.**>
  type stdout
</match>
" >> /etc/td-agent/td-agent.conf

# for elasticsearch
rpm --import https://packages.elastic.co/GPG-KEY-elasticsearch
cat > /etc/yum.repos.d/elasticsearch.repo << EOF
[elasticsearch-2.x]
name=Elasticsearch repository for 2.x packages
baseurl=http://packages.elastic.co/elasticsearch/2.x/centos
gpgcheck=1
gpgkey=http://packages.elastic.co/GPG-KEY-elasticsearch
enabled=1
EOF

sudo yum install -y elasticsearch

sed -i "s/#http.port: 9200/http.port: 9200/" /etc/elasticsearch/elasticsearch.yml

sudo /usr/share/elasticsearch/bin/plugin install mobz/elasticsearch-head
sudo /usr/share/elasticsearch/bin/plugin install royrusso/elasticsearch-HQ
sudo /usr/share/elasticsearch/bin/plugin install polyfractal/elasticsearch-inquisitor
sudo /usr/share/elasticsearch/bin/plugin install analysis-kuromoji
sudo /usr/share/elasticsearch/bin/plugin install analysis-icu

