#!/bin/sh

# The latest mirror's composer version only support for PHP 7.2.5
# And if your PHP version is lesser than that, will be download supported version.
supportLatest=$(php -r "echo version_compare(PHP_VERSION, '7.2.5', '>');")

if [ "$supportLatest" -eq "1" ]; then
    curl -o /usr/bin/composer https://mirrors.aliyun.com/composer/composer.phar \
    && chmod +x /usr/bin/composer
else
    curl -o /tmp/composer-setup.php https://getcomposer.org/installer  \
    && php /tmp/composer-setup.php --install-dir=/tmp \
    && mv /tmp/composer.phar /usr/bin/composer \
    && chmod +x /usr/bin/composer \
    && rm -rf /tmp/composer-setup.php
fi