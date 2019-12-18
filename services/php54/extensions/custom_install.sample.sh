#!/bin/sh

echo "---------- Install XDEBUG ----------"
mkdir xdebug \
&& tar -xf xdebug-2.4.1.tgz -C xdebug --strip-components=1 \
&& ( cd xdebug && phpize && ./configure && make && make install ) \
&& docker-php-ext-enable xdebug

echo "---------- Install mysql ----------"
docker-php-ext-install mysql