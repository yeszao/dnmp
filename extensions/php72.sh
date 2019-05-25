#!/bin/bash

echo
echo "============================================"
echo "More Extensions from: ${MORE_EXTENSION_INSTALLER}"
echo "Extensions is: ${EXTENSIONS[*]} "
echo "============================================"
echo

pwd
export mc="-j$(nproc)"
echo "Multicore Compilation is ${mc}"


if [[ " ${EXTENSIONS[@]} " =~ " mcrypt " ]]; then
    echo "↓---------- mcrypt was REMOVED from PHP 7.2.0 ----------↓"
fi


if [[ " ${EXTENSIONS[@]} " =~ " opcache " ]]; then
    echo "↓---------- Install opcache ----------↓"
    docker-php-ext-install opcache
fi


if [[ " ${EXTENSIONS[@]} " =~ " redis " ]]; then
    echo "↓---------- Install redis ----------↓"
    mkdir redis \
    && tar -xf redis-4.1.1.tgz -C redis --strip-components=1 \
    && ( cd redis && phpize && ./configure && make $mc && make install ) \
    && docker-php-ext-enable redis
fi


if [[ " ${EXTENSIONS[@]} " =~ " xdebug " ]]; then
    echo "↓---------- Install xdebug ----------↓"
    mkdir xdebug \
    && tar -xf xdebug-2.6.1.tgz -C xdebug --strip-components=1 \
    && ( cd xdebug && phpize && ./configure && make $mc && make install ) \
    && docker-php-ext-enable xdebug
fi


if [[ " ${EXTENSIONS[@]} " =~ " swoole " ]]; then
    echo "↓---------- Install swoole ----------↓"
    mkdir swoole \
    && tar -xf swoole-4.2.1.tgz -C swoole --strip-components=1 \
    && ( cd swoole && phpize && ./configure && make $mc && make install ) \
    && docker-php-ext-enable swoole
fi
