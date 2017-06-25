#!/usr/bin/env bash

# nginxリポジトリ設定
rpm -Uvh http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm

sudo yum clean all
sudo yum update

# nginxインストール
sudo yum install -y nginx

# nginx バージョン確認
/usr/sbin/nginx -V

sed -i "s/user nginx;/user vagrant;/" /etc/nginx/nginx.conf
sed -i "s/user  nginx;/user vagrant;/" /etc/nginx/nginx.conf
sed -i "s/# server_names_hash_bucket_size.*/server_names_hash_bucket_size 64;/" /etc/nginx/nginx.conf

# Copy fastcgi_params to Nginx because they broke it on the PPA

cat > /etc/nginx/fastcgi_params << EOF
fastcgi_param QUERY_STRING \$query_string;
fastcgi_param REQUEST_METHOD \$request_method;
fastcgi_param CONTENT_TYPE \$content_type;
fastcgi_param CONTENT_LENGTH \$content_length;
fastcgi_param SCRIPT_FILENAME \$request_filename;
fastcgi_param SCRIPT_NAME \$fastcgi_script_name;
fastcgi_param REQUEST_URI \$request_uri;
fastcgi_param DOCUMENT_URI \$document_uri;
fastcgi_param DOCUMENT_ROOT \$document_root;
fastcgi_param SERVER_PROTOCOL \$server_protocol;
fastcgi_param GATEWAY_INTERFACE CGI/1.1;
fastcgi_param SERVER_SOFTWARE nginx/\$nginx_version;
fastcgi_param REMOTE_ADDR \$remote_addr;
fastcgi_param REMOTE_PORT \$remote_port;
fastcgi_param SERVER_ADDR \$server_addr;
fastcgi_param SERVER_PORT \$server_port;
fastcgi_param SERVER_NAME \$server_name;
fastcgi_param HTTPS \$https if_not_empty;
fastcgi_param REDIRECT_STATUS 200;
EOF

/bin/systemctl enable php-fpm
/bin/systemctl restart php-fpm

dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY
sync

# for apache
sudo yum install -y httpd
sudo yum install -y mod_ssl
sudo mkdir /etc/httpd/fcgi-bin
sudo mkdir /etc/httpd/hhvm

sed -i "s/User apache/User vagrant/" /etc/httpd/conf/httpd.conf
sed -i "s/Group apache/Group vagrant/" /etc/httpd/conf/httpd.conf

echo "Mutex fcntl" >> /etc/httpd/conf/httpd.conf

mv /etc/httpd/conf.d/php.conf /etc/httpd/conf.d/php.conf.dist
mv /etc/httpd/conf.d/welcome.conf /etc/httpd/conf.d/welcome.conf.dist
