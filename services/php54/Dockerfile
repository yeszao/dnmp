ARG PHP_VERSION
FROM ${PHP_VERSION}

ARG TZ
ARG PHP_EXTENSIONS
ARG CONTAINER_PACKAGE_URL


COPY ./extensions /tmp/extensions
WORKDIR /tmp/extensions

RUN chmod +x install.sh \
    && sh install.sh \
    && rm -rf /tmp/extensions

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN apt-get update && \
    apt-get -y install sudo

WORKDIR /www
