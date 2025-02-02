#!/bin/bash
# [Setup] Load the PHP version from the file
PHP_VERSION=$(cat "/app/php_version.txt")

# [Docker] Starting PHP-FPM with the specified PHP version
echo "[Docker] Starting PHP-FPM"
php-fpm$PHP_VERSION -c /app/php/php.ini --fpm-config /app/php/php-fpm.conf --daemonize

# [Docker] Adjust socket permissions for Nginx to access it
echo "[Docker] Adjusting permissions"
chmod 770 /app/tmp/php-fpm.sock
chown www-data:www-data /app/tmp/php-fpm.sock
chown -R www-data:www-data /app/www
chown www-data:www-data /app/php/sessions

chmod g+s /app/www

echo "10.0.0.190 painel.hight.systems" >> /etc/hosts
echo "10.0.0.190 node2.hight.systems" >> /etc/hosts

# [Docker] Starting NGINX
echo "[Docker] Starting NGINX"
echo "[Docker] Services successfully launched"

nginx -c /app/nginx/nginx.conf -p /app
