#!/usr/bin/env bash

yum-complete-transaction -y

# for mysql 5.6 install
yum remove mysql*

yum -y remove mariadb-libs

# sqlite3
sudo yum -y install sqlite

wget https://dev.mysql.com/get/mysql57-community-release-el7-8.noarch.rpm
sudo yum install -y mysql57-community-release-el7-8.noarch.rpm
sudo yum install -y mysql mysql-devel mysql-server mysql-libs
sudo systemctl start mysqld.service
sudo systemctl enable mysqld.service

MYSQL_TEMP_PWD=`sudo cat /var/log/mysqld.log | grep 'A temporary password is generated' | awk -F'root@localhost: ' '{print $2}'`
mysqladmin -u root -p`echo $MYSQL_TEMP_PWD` password '00:secreT,@'

# for backup ini
cp /etc/my.cnf /etc/my.cnf.backup

echo "
character-set-server = utf8
default-storage-engine = InnoDB

slow_query_log=1
long_query_time=1
log_queries_not_using_indexes=1
slow_query_log_file=/var/log/mysql/slow_query.log

[client]
user=root
password=00:secreT,@
" >> /etc/my.cnf

sudo systemctl restart mysqld.service

mysql -e "GRANT ALL ON *.* TO root@'%' IDENTIFIED BY '00:secreT,@' WITH GRANT OPTION;"
mysql -e "GRANT ALL ON *.* TO root@'0.0.0.0' IDENTIFIED BY '00:secreT,@' WITH GRANT OPTION;"
mysql -e "CREATE USER 'gardening'@'0.0.0.0' IDENTIFIED BY '00:secreT,@';"
mysql -e "GRANT ALL ON *.* TO 'gardening'@'0.0.0.0' IDENTIFIED BY '00:secreT,@' WITH GRANT OPTION;"
mysql -e "GRANT ALL ON *.* TO 'gardening'@'localhost' IDENTIFIED BY '00:secreT,@' WITH GRANT OPTION;"
mysql -e "GRANT ALL ON *.* TO 'gardening'@'%' IDENTIFIED BY '00:secreT,@' WITH GRANT OPTION;"
mysql -e "FLUSH PRIVILEGES;"
mysql -e "CREATE DATABASE gardening;"
mysql -e "set password for 'gardening'@'localhost' = password('00:secreT,@');"

sudo systemctl restart mysqld.service

###############################################################
## for postgresql install
###############################################################
wget https://download.postgresql.org/pub/repos/yum/10/redhat/rhel-7-x86_64/pgdg-centos10-10-2.noarch.rpm
sudo rpm -ivh pgdg-centos10-10-2.noarch.rpm
sudo yum -y install postgresql10-server postgresql10-devel postgresql10-contrib

sudo /usr/pgsql-10/bin/postgresql-10-setup initdb
/bin/systemctl enable postgresql-10.service
/bin/systemctl start postgresql-10.service

sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g" /var/lib/pgsql/10/data/postgresql.conf
echo "host    all             all             10.0.2.2/32               md5" | tee -a /var/lib/pgsql/10/data/pg_hba.conf
sudo -u postgres psql -c "CREATE ROLE gardening LOGIN UNENCRYPTED PASSWORD '00:secreT,@' SUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;"
sudo -u postgres /usr/bin/createdb --echo --owner=gardening gardening
/bin/systemctl restart postgresql-10.service

rm -rf pgdg-centos10-10-2.noarch.rpm

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
rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch
cat > /etc/yum.repos.d/elasticsearch.repo << EOF
[elasticsearch-6.x]
name=Elasticsearch repository for 6.x packages
baseurl=https://artifacts.elastic.co/packages/6.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md
EOF

sudo yum install -y elasticsearch

sed -i "s/#http.port: 9200/http.port: 9200/" /etc/elasticsearch/elasticsearch.yml
echo "network.host: 0.0.0.0" >> /etc/elasticsearch/elasticsearch.yml
sed -i "s|-Xms2g|-Xms1g|g" /etc/elasticsearch/jvm.options
sed -i "s|-Xmx2g|-Xmx1g|g" /etc/elasticsearch/jvm.options

sudo /usr/share/elasticsearch/bin/elasticsearch-plugin install analysis-kuromoji
sudo /usr/share/elasticsearch/bin/elasticsearch-plugin install analysis-icu

rm -rf mysql57-community-release-el7-8.noarch.rpm

# for kibana
rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch

cat > /etc/yum.repos.d/kibana.repo << EOF
[kibana-6.x]
name=Kibana repository for 6.x packages
baseurl=https://artifacts.elastic.co/packages/6.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md
EOF

sudo yum install -y kibana

echo "server.host: 0.0.0.0" >> /etc/kibana/kibana.yml
