#!/bin/bash

echo
echo "============================================"
echo "More Extensions from: ${MORE_EXTENSION_INSTALLER}"
echo "============================================"
echo


export mc="-j$(nproc)";
echo "Multicore Compilation is ${mc}"


# Mcrypt was DEPRECATED in PHP 7.1.0, and REMOVED in PHP 7.2.0.
if [[ " ${EXTENSIONS[@]} " =~ " mcrypt " ]]; then
    echo "↓---------- Install mcrypt ----------↓"
    apt install -y libmcrypt-dev \
    && docker-php-ext-install $mc mcrypt
fi


# From PHP 5.6, we can use docker-php-ext-install to install opcache
if [[ " ${EXTENSIONS[@]} " =~ " opcache " ]]; then
    echo "↓---------- Install opcache ----------↓"
    docker-php-ext-install opcache
fi


if [[ " ${EXTENSIONS[@]} " =~ " opcache " ]]; then
    echo "↓---------- Install redis ----------↓"
    mkdir redis \
    && tar -xf redis-4.1.1.tgz -C redis --strip-components=1 \
    && ( cd redis && phpize && ./configure && make $mc && make install ) \
    && docker-php-ext-enable redis
fi


if [[ " ${EXTENSIONS[@]} " =~ " xdebug " ]]; then
    echo "↓---------- Install xdebug ----------↓"
    mkdir xdebug \
    && tar -xf xdebug-2.5.5.tgz -C xdebug --strip-components=1 \
    && ( cd xdebug && phpize && ./configure && make $mc && make install ) \
    && docker-php-ext-enable xdebug
fi


# swoole require PHP version 5.5 or later.
if [[ " ${EXTENSIONS[@]} " =~ " swoole " ]]; then
    echo "↓---------- Install swoole ----------↓"
    mkdir swoole \
    && tar -xf swoole-2.0.11.tgz -C swoole --strip-components=1 \
    && ( cd swoole && phpize && ./configure && make $mc && make install ) \
    && docker-php-ext-enable swoole
fi
