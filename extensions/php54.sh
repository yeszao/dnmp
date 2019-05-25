#!/bin/bash

echo
echo "============================================"
echo "More Extensions from: ${MORE_EXTENSION_INSTALLER}"
echo "============================================"
echo


export mc=""
echo "Multicore Compilation is ${mc}"


if [[ " ${EXTENSIONS[@]} " =~ " mcrypt " ]]; then
    apt install -y libmcrypt-dev \
    && docker-php-ext-install $mc mcrypt
fi


if [[ " ${EXTENSIONS[@]} " =~ " opcache " ]]; then
    mkdir zendopcache \
    && tar -xf zendopcache-7.0.5.tgz -C zendopcache --strip-components=1 \
    && ( cd zendopcache && phpize && ./configure && make $mc && make install ) \
    && docker-php-ext-enable opcache
fi


if [[ " ${EXTENSIONS[@]} " =~ " redis " ]]; then
    mkdir redis \
    && tar -xf redis-4.1.1.tgz -C redis --strip-components=1 \
    && ( cd redis && phpize && ./configure && make $mc && make install ) \
    && docker-php-ext-enable redis
fi


if [[ " ${EXTENSIONS[@]} " =~ " xdebug " ]]; then
    mkdir xdebug \
    && tar -xf xdebug-2.4.1.tgz -C xdebug --strip-components=1 \
    && ( cd xdebug && phpize && ./configure && make $mc && make install ) \
    && docker-php-ext-enable xdebug
fi


if [[ " ${EXTENSIONS[@]} " =~ " swoole " ]]; then
    echo "swoole require PHP version 5.5 or later."
fi
