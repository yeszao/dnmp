ARG PHP_VERSION
FROM php:8.2-fpm

ARG TZ
ARG PHP_EXTENSIONS
ARG CONTAINER_PACKAGE_URL


RUN if [ "${CONTAINER_PACKAGE_URL}" != "" ] ; then  \
    sed -i "s|deb.debian.org|${CONTAINER_PACKAGE_URL}|g" /etc/apt/sources.list ; \
fi


RUN apt-get update \
    && apt-get install -y tzdata curl \
    && ln -fs /usr/share/zoneinfo/${TZ} /etc/localtime  \
    && dpkg-reconfigure -f noninteractive tzdata


# Clean up the package list to reduce image size
RUN apt-get clean && rm -rf /var/lib/apt/lists/*


RUN curl -sSLf \
        -o /usr/local/bin/install-php-extensions \
        https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions
RUN chmod +x /usr/local/bin/install-php-extensions
RUN install-php-extensions $PHP_EXTENSIONS


# Install composer and change it's cache home
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
ENV COMPOSER_HOME=/tmp/composer


WORKDIR /www
