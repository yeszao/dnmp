#!/bin/sh

#
# Here you can add custom scripts
# to add some unpopular extensions
# or add specific compilation parameters for the extension

# e.g. yaml extension
apk add --no-cache yaml-dev
printf "\n" | pecl install yaml
docker-php-ext-enable yaml

# e.g. phalcon extension
mkdir cphalcon
tar -xf cphalcon-3.2.0.tgz -C cphalcon --strip-components=1
( cd cphalcon/build/php7/64bits && phpize && ./configure && make "${MC}" && make install )
docker-php-ext-enable phalcon

# e.g. swoole extension add specific compilation parameters
# If you do this step please remove swoole in the .env file
mkdir swoole
tar -xf swoole-4.4.2 -C swoole --strip-components=1
( cd swoole && phpize && ./configure --enable-openssl --enable-sockets --enable-debug-log && make "${MC}" && make install )
docker-php-ext-enable swoole