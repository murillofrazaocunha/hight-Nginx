#!/bin/bash
# [Setup] Load the PHP version from the file
PHP_VERSION=$(cat "/app/php_version.txt")

# [Docker] Starting PHP-FPM with the specified PHP version
echo "[Docker] Starting PHP-FPM"
php-fpm$PHP_VERSION -c /app/php/php.ini --fpm-config /app/php/php-fpm.conf --daemonize

# [Docker] Adjust socket permissions for Nginx to access it
echo "[Docker] Adjusting permissions for PHP-FPM socket"
chmod 770 /app/tmp/php-fpm.sock
chown nobody:nogroup /app/tmp/php-fpm.sock


# [Docker] Starting NGINX
echo "[Docker] Starting NGINX"
echo "[Docker] Services successfully launched"

nginx -c /app/nginx/nginx.conf -p /app
