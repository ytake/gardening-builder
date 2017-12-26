#!/usr/bin/env bash

yum-complete-transaction -y

# For Lambda|Kappa Architecture Developer
# Confluent platform(Apache Kafka) install
sudo rpm --import https://packages.confluent.io/rpm/4.0/archive.key

sudo cat > /etc/yum.repos.d/confluent.repo << EOF
[Confluent.dist]
name=Confluent repository (dist)
baseurl=https://packages.confluent.io/rpm/4.0/7
gpgcheck=1
gpgkey=https://packages.confluent.io/rpm/4.0/archive.key
enabled=1

[Confluent]
name=Confluent repository
baseurl=https://packages.confluent.io/rpm/4.0
gpgcheck=1
gpgkey=https://packages.confluent.io/rpm/4.0/archive.key
enabled=1
EOF

sudo yum clean all
sudo yum install -y confluent-platform-oss-2.11

sed -i "s|log.dirs=/var/lib/kafka|log.dirs=/var/log/kafka/" /etc/kafka/server.properties

# Apache Cassandra
sudo cat > /etc/yum.repos.d/cassandra.repo << EOF
[cassandra]
name=Apache Cassandra
baseurl=https://www.apache.org/dist/cassandra/redhat/311x/
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://www.apache.org/dist/cassandra/KEYS
EOF

sudo yum -y install cassandra

sudo yum install python-pip -y
sudo pip install --upgrade pip
sudo pip install cassandra-driver

# Apache Spark2.2.1
wget http://ftp.jaist.ac.jp/pub/apache/spark/spark-2.2.1/spark-2.2.1-bin-hadoop2.7.tgz
tar xzvf spark-2.2.1-bin-hadoop2.7.tgz
sudo mv spark-2.2.1-bin-hadoop2.7 /opt/spark
sudo echo "
export SPARK_HOME=/opt/spark
export PATH=\$PATH:\$SPARK_HOME/bin
export SPARK_LOCAL_IP=127.0.0.1
" >> /etc/profile.d/spark.sh
sudo source /etc/profile.d/spark.sh

sudo rm -rf spark-2.2.1-bin-hadoop2.7.tgz

sudo cp /opt/spark/conf/spark-defaults.conf.template /opt/spark/conf/spark-defaults.conf
sudo echo "
spark.driver.extraJavaOptions -Dderby.system.home=/tmp/derby -Dderby.stream.error.file=/tmp/stream_error
spark.sql.warehouse.dir /tmp/warehouse
" >> /opt/spark/conf/spark-defaults.conf
sudo cp /opt/spark/conf/spark-env.sh.template /opt/spark/conf/spark-env.sh
