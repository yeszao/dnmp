ARG PHP_VERSION
FROM ${PHP_VERSION}

ARG TZ
ARG PHP_EXTENSIONS
ARG CONTAINER_PACKAGE_URL

RUN rm /etc/apt/sources.list

#https://lists.debian.org/debian-devel-announce/2023/02/msg00004.html
RUN echo deb http://archive.debian.org/debian-security jessie/updates main >> /etc/apt/sources.list \
    && echo deb http://archive.debian.org/debian jessie main >>  /etc/apt/sources.list
    
RUN apt-get update 

COPY ./extensions /tmp/extensions
WORKDIR /tmp/extensions
RUN chmod +x install.sh \
    && sh install.sh \
    && rm -rf /tmp/extensions


# Install composer and change it's cache home
RUN curl -ko  /usr/bin/composer https://getcomposer.org/download/1.10.27/composer.phar \
    && chmod +x /usr/bin/composer
ENV COMPOSER_HOME=/tmp/composer


# php image's www-data user uid & gid are 82, change them to 1000 (primary user)
RUN usermod -u 1000 www-data && groupmod -g 1000 www-data


WORKDIR /www
