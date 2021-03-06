# gardening-builder

for gardening.box

Vagrant Box Builder(CentOS 7.*)

## Features
### System
 - CentOS 7.*
 - PHP 7.*(remi repository)
 - Node.js 10.*
 - Java 1.8.0_151
 - Git
 - GD and Imagick
 - Composer
 - npm
 - Apache 2.4.6
 - Nginx 1.14.2

### Database
 - MySQL 5.7.20
 - PostgreSQL 10.1
 - SQLite 3.7.17
 - MongoDB 3.6.0
 - Couchbase 5.0.1
 - ElasticSearch 6.2.4
 - Kibana 6.2.4
 - Apache Cassandra 3.11
 
### Caching
 - Redis 4.0.6
 - Memcached 1.4.15

### Message Broker
 - Apache Kafka 1.0.1 [Confluent Platform](https://docs.confluent.io/current/platform.html)
 - RabbitMQ 3.7.2 [RabbitMQ](https://www.rabbitmq.com/)
 - beanstalkd 1.10 [beanstalkd](http://kr.github.io/beanstalkd/)
 
### Other
 - fluentd
 - Apache Spark 2.2.1 [Apache Spark](https://spark.apache.org/)
 
 etc...

## PHP
### php70 bin dir

```
/opt/remi/php70/root/usr/bin
``` 

#### fpm-socket

`/var/run/php70-fpm.sock`

### php71 bin dir

```
/opt/remi/php71/root/usr/bin
``` 

#### fpm-socket

`/var/run/php71-fpm.sock`

### php72 bin dir

```
/opt/remi/php72/root/usr/bin
```
 
#### fpm-socket

`/var/run/php72-fpm.sock`
