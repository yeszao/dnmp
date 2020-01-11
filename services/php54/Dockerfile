ARG PHP_VERSION
FROM ${PHP_VERSION}

ARG TZ
ARG PHP_EXTENSIONS
ARG CONTAINER_PACKAGE_URL


RUN sed -i "s/httpredir.debian.org/${CONTAINER_PACKAGE_URL}/g" /etc/apt/sources.list \
    && sed -i "s/security.debian.org/${CONTAINER_PACKAGE_URL}\/debian-security/g" /etc/apt/sources.list \
    && apt-get update


COPY ./extensions /tmp/extensions
WORKDIR /tmp/extensions
RUN chmod +x install.sh \
    && sh install.sh \
    && rm -rf /tmp/extensions


# Install composer and change it's cache home
RUN curl -o /usr/bin/composer https://mirrors.aliyun.com/composer/composer.phar \
    && chmod +x /usr/bin/composer
ENV COMPOSER_HOME=/tmp/composer


# php image's www-data user uid & gid are 82, change them to 1000 (primary user)
RUN usermod -u 1000 www-data && groupmod -g 1000 www-data


WORKDIR /www
