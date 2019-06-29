#!/bin/bash

echo "============================================"
echo "The exact version of php is $PHP_VERSION"
echo "============================================"

function getPHPVersion() {
    [[ ${PHP_VERSION} =~ ^([0-9]+)\.([0-9]+)\.([0-9]+) ]]
    num1=${BASH_REMATCH[1]}
    num2=${BASH_REMATCH[2]}
    num3=${BASH_REMATCH[3]}
    echo $[ $num1 * 10000 + $num2 * 100 + $num3 ]
}

version=$(getPHPVersion)

# Mcrypt was DEPRECATED in PHP 7.1.0, and REMOVED in PHP 7.2.0.
if [ ${version} -lt 70200 ]; then
    apt-get install -y libmcrypt-dev \
    && docker-php-ext-install mcrypt
fi

# From PHP 5.6, we can use docker-php-ext-install to install opcache
if [ ${version} -lt 50600 ]; then
    cd /tmp/extensions \
    && mkdir zendopcache \
    && tar -xf zendopcache-7.0.5.tgz -C zendopcache --strip-components=1 \
    && ( cd zendopcache && phpize && ./configure && make && make install ) \
    && docker-php-ext-enable opcache

else
    docker-php-ext-install opcache
fi


if [ "$REDIS_VERSION" != "false" ]; then
    cd /tmp/extensions \
    && mkdir redis \
    && tar -xf redis-${REDIS_VERSION}.tgz -C redis --strip-components=1 \
    && ( cd redis && phpize && ./configure && make && make install ) \
    && docker-php-ext-enable redis
fi


if [ "$XDEBUG_VERSION" != "false" ]; then
    cd /tmp/extensions \
    && mkdir xdebug \
    && tar -xf xdebug-${XDEBUG_VERSION}.tgz -C xdebug --strip-components=1 \
    && ( cd xdebug && phpize && ./configure && make && make install ) \
    && docker-php-ext-enable xdebug
fi

# swoole require PHP version 5.5 or later.
if [ "$SWOOLE_VERSION" != "false" ]; then
    cd /tmp/extensions \
    && mkdir swoole \
    && tar -xf swoole-${SWOOLE_VERSION}.tgz -C swoole --strip-components=1 \
    && ( cd swoole && phpize && ./configure && make && make install ) \
    && docker-php-ext-enable swoole
fi
