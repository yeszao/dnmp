ARG PHP_VERSION
FROM php:8.2-fpm

ARG TZ
ARG PHP_EXTENSIONS
ARG DEBIAN_MIRROR_DOMAIN

ENV TZ=${TZ}

# Set debian mirror
RUN sed -i "s|deb.debian.org|${DEBIAN_MIRROR_DOMAIN}|g" /etc/apt/sources.list.d/debian.sources

# Install required packages
RUN export option="--no-install-recommends -y" \
    && apt-get $option update \
    && apt-get $option install tzdata curl

# Clean up the package list to reduce image size
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install PHP extensions
RUN curl -sSLf -o /usr/local/bin/install-php-extensions https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions \
&& chmod +x /usr/local/bin/install-php-extensions \
&& install-php-extensions $PHP_EXTENSIONS

# Install composer and change it's cache home
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
ENV COMPOSER_HOME=/tmp/composer

# Set work directory
WORKDIR /www
