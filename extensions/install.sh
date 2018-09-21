#!/bin/bash

# Install mcrypt extension,
# Mcrypt was DEPRECATED in PHP 7.1.0, and REMOVED in PHP 7.2.0.
if $SUPPORT_MCRYPT; then
    apt-get install -y libmcrypt-dev \
    && docker-php-ext-install mcrypt
fi

# Install redis extension
cd /tmp/extensions \
    && mkdir redis \
    && tar -xf redis-${REDIS_VERSION}.tgz -C redis --strip-components=1 \
    && ( cd redis && phpize && ./configure && make && make install ) \
    && docker-php-ext-enable redis

# Install xdebug extension
cd /tmp/extensions \
    && mkdir xdebug \
    && tar -xf xdebug-${XDEBUG_VERSION}.tgz -C xdebug --strip-components=1 \
    && ( cd xdebug && phpize && ./configure && make && make install ) \
    && docker-php-ext-enable xdebug

# Install swoole extension
# swoole require PHP version 5.5 or later.
if $SWOOLE_VERSION; then
    cd /tmp/extensions \
    && mkdir swoole \
    && tar -xf swoole-${SWOOLE_VERSION}.tgz -C swoole --strip-components=1 \
    && ( cd swoole && phpize && ./configure && make && make install ) \
    && docker-php-ext-enable swoole
fi

# Install opcache extension
if $BUILT_IN_OPCACHE; then
    docker-php-ext-install opcache
else
    cd /tmp/extensions \
    && mkdir zendopcache \
    && tar -xf zendopcache-7.0.5.tgz -C zendopcache --strip-components=1 \
    && ( cd zendopcache && phpize && ./configure && make && make install ) \
    && docker-php-ext-enable opcache
fi